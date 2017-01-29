%==========================================================================
%Generate an object with the same format as the SPM-output variable, xSPM, 
%using the information from an input NIDM-Results json pack. This takes in 
%two or three argument:
%
%graph - the nidm-results graph
%jsonFile - the filepath to the NIDM pack.
%exObj - an object containing all information about multiple excursions 
%sets.
%
%Authors: Thomas Maullin, Camille Maumet.
%==========================================================================

function NxSPM = changeNIDMtoxSPM(graph, jsonFile, exObj)
        
    % Checking inputs.
    if nargin == 2
        multipleExcursions = false;
    end
    if nargin == 3
        multipleExcursions = true;
        exNum = exObj{1};
        exLabels = exObj{2};
    end
    
    NxSPM = struct;
    
    %======================================================================
    %title
    
    %Find the contrast map holding the title.
    contrastMaps = searchforType('nidm_ContrastMap', graph);
    
    if(multipleExcursions)
        counter = 1;
        resultant = {};
        %Work out which object belongs to which excursion set.
        for(i = 1:length(contrastMaps))
            if(any(ismember(exLabels(contrastMaps{i}.prov_wasGeneratedBy.x_id),exNum)))
                resultant{counter} = contrastMaps{i};
                counter = counter+1;
            end
        end
        contrastMaps = resultant;
    end
    
    if(~isempty(contrastMaps))
        for i = 1:length(contrastMaps)
            if isfield(contrastMaps{i}, 'nidm_contrastName')
                titleTemp = contrastMaps{i}.('nidm_contrastName');
            end
        end 
    else
        titleTemp = '';
    end
    
    %======================================================================
    %STAT
    
    %Using getStatType, obtain the statisticMaps objects and statistic type. 
    [STATTemp, statisticMaps] = getStatType(graph);
       
    %======================================================================
    %STATStr
    
    %Obtain the degrees of freedom.
    for i = 1:length(statisticMaps)
        if isfield(statisticMaps{i}, 'nidm_errorDegreesOfFreedom')
            anyStatType = statisticMaps{i}.('nidm_statisticType').('x_id');
            if ~strcmp(anyStatType, 'obo:STATO_0000376')
                effectDegrees = get_value(statisticMaps{i}.('nidm_effectDegreesOfFreedom'));
                errorDegrees = get_value(statisticMaps{i}.('nidm_errorDegreesOfFreedom'));
            end
        end
    end 
    
    if ischar(effectDegrees)
        effectDegrees = str2num(effectDegrees);
        errorDegrees = str2num(errorDegrees);
    end
    
    %Add the degrees of freedom as a subscript.
    effectDegrees = sprintf('%4.1f', effectDegrees);
    errorDegrees = sprintf('%4.1f', errorDegrees);
    
    if strcmp(STATTemp, 'T') || strcmp(STATTemp, 'X')
        STATStrTemp = [STATTemp '_{' errorDegrees '}'];
    elseif strcmp(STATTemp, 'Z') || strcmp(STATTemp, 'P')
        STATStrTemp = STATTemp;
    else
        STATStrTemp = [STATTemp '_{' effectDegrees ',' errorDegrees '}'];
    end
    
    %===============================================
    %M
    
    %Locate the excursion set maps and their indices in the graph.
    [excursionSetMaps, ~] = searchforType('nidm_ExcursionSetMap', graph);
    if(multipleExcursions)
        excursionSetMaps = relevantToExcursion(excursionSetMaps, exNum, exLabels);
    end
    coordSpaceId = excursionSetMaps{1}.('nidm_inCoordinateSpace').('x_id');
    coordSpace = searchforID(coordSpaceId, graph);
    
    %Obtain the voxel to world mapping and transform it to obtain M.
    v2wm = spm_jsonread(coordSpace.nidm_voxelToWorldMapping);
    transform = [1, 0, 0, -1; 0, 1, 0, -1; 0, 0, 1, -1; 0, 0, 0, 1];
    mTemp = v2wm*transform;
    
    %===============================================
    %DIM
    
    dimTemp = str2num(coordSpace.('nidm_dimensionsInVoxels'))';
    
    %======================================================================
    %nidm - NOTE: In the standard format for SPM output the MIP is 
    %derived from other fields and this field does not exist.
    
    nidmTemp = struct;
    
    %If there's already an MIP, save it's location, else generate one.
    if isfield(excursionSetMaps{1}, 'nidm_hasMaximumIntensityProjection')
        mipFilepath = searchforID(excursionSetMaps{1}.nidm_hasMaximumIntensityProjection.('x_id'),graph);
        nidmTemp.MIP = getPathDetails(mipFilepath.('prov_atLocation').('x_value'), jsonFile);
    else
        %Find the units of the MIP.
        searchSpaceMaskMap = searchforType('nidm_SearchSpaceMaskMap', graph);
        if(multipleExcursions)
            searchSpaceMaskMap = relevantToExcursion(searchSpaceMaskMap, exNum, exLabels);
        end
        searchSpace = searchforID(searchSpaceMaskMap{1}.('nidm_inCoordinateSpace').('x_id'), graph);
        voxelUnits = strrep(strrep(strrep(strrep(searchSpace.('nidm_voxelUnits'), '\"', ''), '[', ''), ']', ''), ',', '');
        
        %Generate the MIP.
        filenameNII = excursionSetMaps{1}.('nfo_fileName');
        generateMIP(jsonFile, filenameNII, dimTemp, voxelUnits);
        nidmTemp.MIP = spm_file(fullfile(jsonFile,'MIP.png'));
        
        %Store information about the new MIP in the NIDM pack. Temporarily
        %remove the filepath from the json object.
        
% Update of the json file is commented out until we can have: a function 
% that checks that two json graphs are identical (irrespective of the order
% of the fields) and be able to output an indented json file.
%         [~, filenameTemp] = fileparts(jsonFile);
%         filepathTemp = jsonFile;
%         json = rmfield(json, 'filepath');
%         
%         %Create a structure to store information about the MIP.
%         
%         s = struct;
%         s.x_id = ['niiri:', char(java.util.UUID.randomUUID)];
%         s.x_type = {'dctype:Image'; 'prov:Entity'};
%         s.dcterms_format = 'image/png';
%         s.nfo_fileName = 'MIP.png';
%         s.prov_atLocation.x_type = 'xsd:anyURI';
%         s.prov_atLocation.x_value = 'MIP.png';
%         
%         %Update the graph.
%         graph{excurIndices{1}}.nidm_hasMaximumIntensityProjection.x_id = s.x_id;
%         graph{length(graph)+1} = s;
%         json.x_graph = graph;
%         
%         spm_jsonwrite(json_file, json);
%         
%         % Replace 'x_' back with '@' in the json document (Matlab cannot
%         % handle variable names starting with '@' so those are replaced when 
%         % reading with spm_jsonread)
%         json_str = fileread(json_file);
%         json_str = strrep(json_str, 'x_', '@');
%         fid = fopen(json_file, 'w');
%         fwrite(fid, json_str, '*char');
%         fclose(fid);
%         
%         jsonFile = filepathTemp;
        
    end
    
    %======================================================================
    
    NxSPM.title = titleTemp;
    NxSPM.STAT = STATTemp;
    NxSPM.STATstr = STATStrTemp;
    NxSPM.nidm = nidmTemp;
    %Number of contrast vectors, currently only working with one.
    NxSPM.Ic = 1;
    NxSPM.DIM = dimTemp;
    NxSPM.M = mTemp;
    
end