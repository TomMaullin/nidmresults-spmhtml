%==========================================================================
%This function takes in an NIDM-Results json and creates a hashmap labelling
%objects with a pointer to their relevant excursion set. The resultant
%hashmap takes in the id of an object from the main NIDM-Results graph and
%outputs a number for it's corresponding ExcursionMap. It does this by
%creating a list of keys (which are ID's of nodes in the NIDM graph) and a
%list of values (which are arrays of integers corresponding to the excursion
%sets each node is associated to).
%
%graph - the graph from an NIDM-Results json.
%ids - a list of ids for the graph objects.
%typemap - a hashmap for object types.
%
%Authors: Thomas Maullin, Camille Maumet.
%==========================================================================

function labels = addExcursionPointers(graph, ids, typemap)
    
    %Create an empty list for the keys and values.
    values_excNum = {};
    keys_objIDs = {};
    
    %Return the excursion set maps.
    excursionSetMaps = typemap('nidm_ExcursionSetMap');
    
    %For each excursion set map backtrack through recording each object and
    %the excursions set map it was connected to.
    
    for(i = 1:length(excursionSetMaps))
        
        %Add in the excursion set map object.
        keys_objIDs{end+1} = excursionSetMaps{i}.x_id;
        values_excNum{end+1} = [i];      
        
        %Find the inference object connected to the excursionSetMap.
        inference = searchforID(excursionSetMaps{i}.prov_wasGeneratedBy.x_id, graph, ids);
        if(any(ismember(keys_objIDs, inference.x_id)))
            index = cellfun(@(y) strcmp(y, inference.x_id), keys_objIDs, 'UniformOutput', 1);
            index = find(index==1);
            values_excNum{index} = [values_excNum{index} i];
        else
            keys_objIDs{end+1} = inference.x_id;
            values_excNum{end+1} = [i];
        end 
        
        %Obtain the objects used by inference.
        used = inference.prov_used;
        statisticMap = [];
        
        %Obtain the nodes inference has used.
        for(j = 1:length(used))
            
            node = searchforID(used(j).x_id, graph, ids);
            
            %Add the nodes to the label list.
            if(any(ismember(keys_objIDs, node.x_id)))
                index = cellfun(@(y) strcmp(y, node.x_id), keys_objIDs, 'UniformOutput', 1);
                index = find(index==1);
                values_excNum{index} = [values_excNum{index} i];
            else
                keys_objIDs{end+1} = node.x_id;
                values_excNum{end+1} = [i];
            end 
            
            %Compute which is the statistic map.
            if(isfield(node, 'nidm_effectDegreesOfFreedom'))
                statisticMap = node;
            end
            
        end
        
        %Find the contrast estimate.
        conEst = searchforID(statisticMap.prov_wasGeneratedBy.x_id, graph, ids);
        if(any(ismember(keys_objIDs, conEst.x_id)))
            index = cellfun(@(y) strcmp(y, conEst.x_id), keys_objIDs, 'UniformOutput', 1);
            index = find(index==1);
            values_excNum{index} = [values_excNum{index} i];
        else
            keys_objIDs{end+1} = conEst.x_id;
            values_excNum{end+1} = [i];
        end 

        %Obtain the objects used by inference.
        used = conEst.prov_used;
        
        for(j = 1:length(used))
            
            node = searchforID(used(j).x_id,graph, ids);
            
            %Add the nodes to the label list.
            if(any(ismember(keys_objIDs, node.x_id)))
                index = cellfun(@(y) strcmp(y, node.x_id), keys_objIDs, 'UniformOutput', 1);
                index = find(index==1);
                values_excNum{index} = [values_excNum{index} i];
            else
                keys_objIDs{end+1} = node.x_id;
                values_excNum{end+1} = [i];
            end 
        end
        
    end
    
    %Now we check which searchSpaceMaskMap was derived from the same
    %inference as which excursionSetMap.
    searchSpaceMaskMaps = typemap('nidm_SearchSpaceMaskMap');
    
    for(i = 1:length(searchSpaceMaskMaps))
        for(j = 1:length(excursionSetMaps))
            if(strcmp(excursionSetMaps{j}.prov_wasGeneratedBy.x_id,...
                    searchSpaceMaskMaps{i}.prov_wasGeneratedBy.x_id))
                
                if(any(ismember(keys_objIDs, searchSpaceMaskMaps{i}.x_id)))
                    index = cellfun(@(y) strcmp(y, searchSpaceMaskMaps{i}.x_id), keys_objIDs, 'UniformOutput', 1);
                    index = find(index==1);
                    values_excNum{index} = [values_excNum{index} j];
                else
                    keys_objIDs{end+1} = searchSpaceMaskMaps{i}.x_id;
                    values_excNum{end+1} = [j];
                end 
                
            end
        end
    end
    
    %Account for keys listed multiple times.
    
    labels = containers.Map(keys_objIDs, values_excNum, 'UniformValues', false);
    
end