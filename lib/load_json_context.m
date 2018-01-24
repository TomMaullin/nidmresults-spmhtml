%==========================================================================
% Read the @context in JSON-LD to link human labels to the corresponding 
% URIs. To avoid using URIs directly in the code, we also use human labels.
% The mapping that is done here is therefore:
% human-labels-from-code -> URI -> human-label-from-JSON
% Returned 'context' is a dictionnary mapping human labels used in the SPM
% viewer code (human-labels-from-code) with human labels found in the JSON
% context (human-label-from-JSON)
% This will ensure that if different labels are used in different documents
% the viewer will still be able to read them (based on the URIs - unique).
%
% Authors: Thomas Maullin, Camille Maumet.
%==========================================================================
function context = load_json_context(json)
    hkey_dict = human_key_dict();
    not_found = hkey_dict.values;
    
    hnms_dict = human_namespace_dict();

    context = containers.Map();
    
    if isstruct(json)
        json = {json};
    end
    
    for i = 1:numel(json)
        if isfield(json{i}, 'x_context')
            if isstruct(json{i}.x_context)
                json{i}.x_context = {json{i}.x_context};
            end
            for j = 1:numel(json{i}.x_context)
                if isstruct(json{i}.x_context{j})
                    fields = fieldnames(json{i}.x_context{j});
                    for m = 1:numel(fields)
                        if ~ismember(fields{m}, context.values)
                            [hkey, hkey_dict] = human_key(json{i}.x_context{j}.(fields{m}), hkey_dict, hnms_dict);
                            context(hkey) = fields{m};
                        end
                    end
                end
            end
        end
    end 

    % When not prefix was found replace URI by qname using predefined 
%   % prefixes    
    keys = hkey_dict.keys;
    values = hkey_dict.values;
    for i = 1:length(hkey_dict)       
        nm_keys = hnms_dict.keys;
        nm_values = hnms_dict.values;
        for j = 1:length(hnms_dict)
            keys{i} = strrep(keys{i}, nm_keys{j},nm_values{j});
        end
        
        context(values{i}) = keys{i};
    end
end

function hkey_dict = human_key_dict()
    hkey_dict = containers.Map();
    hkey_dict('http://purl.obolibrary.org/obo/BFO_0000179') = 'obo_BFOOWLSpecificationLabel';
    hkey_dict('http://purl.obolibrary.org/obo/BFO_0000180') = 'obo_BFOCLIFSpecificationLabel';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000002') = 'obo_ExampleToBeEventuallyRemoved';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000111') = 'obo_editorPreferredTerm';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000111') = 'obo_editorPreferredTerm';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000111') = 'obo_editorPreferredTerm';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000112') = 'obo_exampleOfUsage';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000114') = 'obo_hasCurationStatus';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000115') = 'obo_definition';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000115') = 'obo_definition';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000115') = 'obo_definition';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000115') = 'obo_definition';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000116') = 'obo_editorNote';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000117') = 'obo_termEditor';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000118') = 'obo_alternativeTerm';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000119') = 'obo_definitionSource';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000120') = 'obo_MetadataComplete';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000121') = 'obo_OrganizationalTerm';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000122') = 'obo_ReadyForRelease';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000123') = 'obo_MetadataIncomplete';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000124') = 'obo_Uncurated';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000125') = 'obo_PendingFinalVetting';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000136') = 'obo_IsAbout';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000232') = 'obo_curatorNote';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000412') = 'obo_importedFrom';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000423') = 'obo_ToBeReplacedWithExternalOntologyTerm';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000428') = 'obo_RequiresDiscussion';
    hkey_dict('http://purl.obolibrary.org/obo/IAO_0000600') = 'obo_elucidation';
    hkey_dict('http://purl.obolibrary.org/obo/OBI_0000251') = 'obo_Cluster';
    hkey_dict('http://purl.obolibrary.org/obo/OBI_0001265') = 'obo_FWERAdjustedPValue';
    hkey_dict('http://purl.obolibrary.org/obo/OBI_0001442') = 'obo_QValue';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000030') = 'obo_ChiSquaredStatistic';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000039') = 'obo_Statistic';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000051') = 'obo_PoissonDistribution';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000067') = 'obo_ContinuousProbabilityDistribution';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000117') = 'obo_DiscreteProbabilityDistribution';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000119') = 'obo_ModelParameterEstimation';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000129') = 'obo_HasValue';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000176') = 'obo_TStatistic';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000193') = 'obo_StudyGroupPopulation';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000225') = 'obo_ProbabilityDistribution';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000227') = 'obo_NormalDistribution';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000276') = 'obo_BinomialDistribution';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000282') = 'obo_FStatistic';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000323') = 'obo_ContrastWeightMatrix';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000346') = 'obo_CovarianceStructure';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000357') = 'obo_ToeplitzCovarianceStructure';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000362') = 'obo_CompoundSymmetryCovarianceStructure';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000370') = 'obo_OrdinaryLeastSquaresEstimation';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000371') = 'obo_WeightedLeastSquaresEstimation';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000372') = 'obo_GeneralizedLeastSquaresEstimation';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000373') = 'obo_IterativelyReweightedLeastSquaresEstimation';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000374') = 'obo_FeasibleGeneralizedLeastSquaresEstimation';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000376') = 'obo_ZStatistic';
    hkey_dict('http://purl.obolibrary.org/obo/STATO_0000405') = 'obo_UnstructuredCovarianceStructure';
    hkey_dict('http://purl.obolibrary.org/obo/iao/2015-02-23/iao.owl') = 'iao_IAORelease20150223';
    hkey_dict('http://purl.org/dc/elements/1.1/contributor') = 'dc_contributor';
    hkey_dict('http://purl.org/dc/elements/1.1/creator') = 'dc_creator';
    hkey_dict('http://purl.org/dc/elements/1.1/date') = 'dc_date';
    hkey_dict('http://purl.org/dc/elements/1.1/date') = 'dc_date';
    hkey_dict('http://purl.org/dc/elements/1.1/description') = 'dc_description';
    hkey_dict('http://purl.org/dc/elements/1.1/title') = 'dc_title';
    hkey_dict('http://purl.org/nidash/afni#GammaHRF') = 'afni_AFNIsGammaHRF';
    hkey_dict('http://purl.org/nidash/afni#LegendrePolynomialDriftModel') = 'afni_AFNIsLegendrePolinomialDriftModel';
    hkey_dict('http://purl.org/nidash/fsl#FSL_0000001') = 'fsl_FSLsGammaDifferenceHRF';
    hkey_dict('http://purl.org/nidash/fsl#FSL_0000002') = 'fsl_GaussianRunningLineDriftModel';
    hkey_dict('http://purl.org/nidash/fsl#FSL_0000003') = 'fsl_FSLsTemporalDerivative';
    hkey_dict('http://purl.org/nidash/fsl#FSL_0000004') = 'fsl_driftCutoffPeriod';
    hkey_dict('http://purl.org/nidash/fsl#FSL_0000005') = 'fsl_featVersion';
    hkey_dict('http://purl.org/nidash/fsl#FSL_0000006') = 'fsl_FSLsGammaHRF';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000001') = 'nidm_ContrastEstimation';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000002') = 'nidm_ContrastMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000004') = 'nidm_BinaryMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000007') = 'nidm_ClusterDefinitionCriteria';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000008') = 'nidm_ClusterLabelsMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000009') = 'nidm_Colin27CoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000011') = 'nidm_ConjunctionInference';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000012') = 'nidm_ConnectivityCriterion';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000013') = 'nidm_ContrastStandardErrorMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000014') = 'nidm_LegendrePolynomialOrder';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000015') = 'nidm_Coordinate';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000016') = 'nidm_CoordinateSpace';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000017') = 'nidm_CustomCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000019') = 'nidm_DesignMatrix';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000020') = 'nidm_DisplayMaskMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000021') = 'nidm_regressorNames';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000023') = 'nidm_ErrorModel';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000024') = 'nidm_ExchangeableError';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000025') = 'nidm_ExcursionSetMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000026') = 'nidm_ExtentThreshold';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000027') = 'nidm_NIDMResults';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000028') = 'nidm_FiniteImpulseResponseBasisSet';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000029') = 'nidm_GammaDifferenceHRF';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000030') = 'nidm_GammaBasisSet';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000031') = 'nidm_GammaHRF';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000033') = 'nidm_GrandMeanMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000034') = 'nidm_HeightThreshold';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000035') = 'nidm_HemodynamicResponseFunction';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000036') = 'nidm_ConvolutionBasisSet';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000037') = 'nidm_HemodynamicResponseFunctionDerivative';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000038') = 'nidm_Icbm452AirCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000039') = 'nidm_Icbm452Warp5CoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000040') = 'nidm_IcbmMni152LinearCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000041') = 'nidm_IcbmMni152NonLinear2009aAsymmetricCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000042') = 'nidm_IcbmMni152NonLinear2009aSymmetricCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000043') = 'nidm_IcbmMni152NonLinear2009bAsymmetricCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000044') = 'nidm_IcbmMni152NonLinear2009bSymmetricCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000045') = 'nidm_IcbmMni152NonLinear2009cAsymmetricCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000046') = 'nidm_IcbmMni152NonLinear2009cSymmetricCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000047') = 'nidm_IcbmMni152NonLinear6thGenerationCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000048') = 'nidm_IndependentError';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000049') = 'nidm_Inference';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000050') = 'nidm_Ixi549CoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000051') = 'nidm_MNICoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000052') = 'nidm_Map';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000053') = 'nidm_MapHeader';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000054') = 'nidm_MaskMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000055') = 'nidm_Mni305CoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000056') = 'nidm_ModelParameterEstimation';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000057') = 'nidm_NIDMObjectModel';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000059') = 'nidm_NonParametricSymmetricDistribution';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000060') = 'nidm_OneTailedTest';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000061') = 'nidm_ParameterEstimateMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000062') = 'nidm_Peak';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000063') = 'nidm_PeakDefinitionCriteria';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000064') = 'nidm_PixelConnectivityCriterion';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000066') = 'nidm_ResidualMeanSquaresMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000067') = 'nidm_CustomBasisSet';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000068') = 'nidm_SearchSpaceMaskMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000069') = 'nidm_FourierBasisSet';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000070') = 'nidm_SupraThresholdCluster';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000071') = 'nidm_ErrorParameterMapWiseDependence';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000072') = 'nidm_ConstantParameter';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000073') = 'nidm_IndependentParameter';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000074') = 'nidm_RegularizedParameter';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000075') = 'nidm_StandardizedCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000076') = 'nidm_StatisticMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000077') = 'nidm_SubjectCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000078') = 'nidm_TalairachCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000079') = 'nidm_TwoTailedTest';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000080') = 'nidm_VoxelConnectivityCriterion';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000081') = 'nidm_WorldCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000082') = 'nidm_clusterLabelId';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000083') = 'nidm_clusterSizeInVertices';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000084') = 'nidm_clusterSizeInVoxels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000085') = 'nidm_contrastName';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000086') = 'nidm_coordinateVector';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000087') = 'nidm_DriftModel';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000088') = 'nidm_hasDriftModel';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000089') = 'nidm_dependenceMapWiseDependence';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000090') = 'nidm_dimensionsInVoxels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000091') = 'nidm_effectDegreesOfFreedom';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000092') = 'nidm_equivalentZStatistic';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000093') = 'nidm_errorDegreesOfFreedom';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000094') = 'nidm_errorVarianceHomogeneous';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000096') = 'nidm_grandMeanScaling';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000097') = 'nidm_hasAlternativeHypothesis';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000098') = 'nidm_hasClusterLabelsMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000099') = 'nidm_hasConnectivityCriterion';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000100') = 'nidm_hasErrorDependence';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000101') = 'nidm_hasErrorDistribution';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000102') = 'nidm_hasHRFBasis';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000103') = 'nidm_hasMapHeader';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000104') = 'nidm_inCoordinateSpace';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000105') = 'nidm_inWorldCoordinateSystem';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000106') = 'nidm_isUserDefined';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000107') = 'nidm_maskedMedian';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000108') = 'nidm_maxNumberOfPeaksPerCluster';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000109') = 'nidm_minDistanceBetweenPeaks';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000110') = 'nidm_GaussianHRF';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000111') = 'nidm_numberOfSupraThresholdClusters';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000112') = 'nidm_numberOfDimensions';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000113') = 'nidm_objectModel';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000114') = 'nidm_pValue';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000115') = 'nidm_pValueFWER';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000116') = 'nidm_pValueUncorrected';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000117') = 'nidm_pixel4connected';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000118') = 'nidm_pixel8connected';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000119') = 'nidm_qValueFDR';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000120') = 'nidm_randomFieldStationarity';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000121') = 'nidm_searchVolumeInVoxels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000122') = 'nidm_softwareVersion';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000123') = 'nidm_statisticType';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000124') = 'nidm_targetIntensity';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000126') = 'nidm_varianceMapWiseDependence';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000127') = 'nidm_version';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000128') = 'nidm_voxel18connected';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000129') = 'nidm_voxel26connected';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000130') = 'nidm_voxel6connected';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000131') = 'nidm_voxelSize';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000132') = 'nidm_voxelToWorldMapping';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000133') = 'nidm_voxelUnits';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000134') = 'nidm_withEstimationMethod';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000135') = 'nidm_ContrastVarianceMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000136') = 'nidm_searchVolumeInUnits';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000137') = 'nidm_searchVolumeInVertices';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000138') = 'nidm_hasMaximumIntensityProjection';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000139') = 'nidm_coordinateVectorInVoxels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000140') = 'nidm_ClusterCenterOfGravity';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000141') = 'nidm_expectedNumberOfClusters';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000142') = 'nidm_expectedNumberOfVerticesPerCluster';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000143') = 'nidm_expectedNumberOfVoxelsPerCluster';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000144') = 'nidm_ReselsPerVoxelMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000145') = 'nidm_noiseRoughnessInVoxels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000146') = 'nidm_heightCriticalThresholdFDR05';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000147') = 'nidm_heightCriticalThresholdFWE05';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000148') = 'nidm_reselSizeInVoxels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000149') = 'nidm_searchVolumeInResels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000150') = 'nidm_LinearSplineBasisSet';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000151') = 'nidm_SineBasisSet';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000156') = 'nidm_clusterSizeInResels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000157') = 'nidm_noiseFWHMInUnits';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000158') = 'nidm_noiseFWHMInVertices';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000159') = 'nidm_noiseFWHMInVoxels';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000160') = 'nidm_PValueUncorrected';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000161') = 'nidm_equivalentThreshold';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000162') = 'nidm_Threshold';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000163') = 'nidm_ContrastExplainedMeanSquareMap';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000164') = 'nidm_NeuroimagingAnalysisSoftware';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000165') = 'nidm_NIDMResultsExporter';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000166') = 'nidm_NIDMResultsExport';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000167') = 'nidm_nidmfsl';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000168') = 'nidm_spm_results_nidm';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000169') = 'nidm_Data';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000170') = 'nidm_groupName';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000171') = 'nidm_numberOfSubjects';
    hkey_dict('http://purl.org/nidash/nidm#NIDM_0000172') = 'nidm_hasMRIProtocol';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000001') = 'spm_SPMsDriftCutoffPeriod';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000002') = 'spm_DiscreteCosineTransformbasisDriftModel';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000003') = 'spm_SPMsDispersionDerivative';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000004') = 'spm_SPMsCanonicalHRF';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000005') = 'spm_PartialConjunctionInference';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000006') = 'spm_SPMsTemporalDerivative';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000010') = 'spm_searchVolumeReselsGeometry';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000011') = 'spm_smallestSignificantClusterSizeInVerticesFDR05';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000012') = 'spm_smallestSignificantClusterSizeInVerticesFWE05';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000013') = 'spm_smallestSignificantClusterSizeInVoxelsFDR05';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000014') = 'spm_smallestSignificantClusterSizeInVoxelsFWE05';
    hkey_dict('http://purl.org/nidash/spm#SPM_0000015') = 'spm_partialConjunctionDegree';
    hkey_dict('http://purl.org/ontology/prv/core#PropertyReification') = 'prv_PropertyReification';
    hkey_dict('http://purl.org/ontology/prv/core#object_property') = 'prv_hasObjectProperty';
    hkey_dict('http://purl.org/ontology/prv/core#reification_class') = 'prv_hasReificationClass';
    hkey_dict('http://purl.org/ontology/prv/core#shortcut') = 'prv_hasShortcut';
    hkey_dict('http://purl.org/ontology/prv/core#shortcut_property') = 'prv_hasShortcutProperty';
    hkey_dict('http://purl.org/ontology/prv/core#subject_property') = 'prv_hasSubjectProperty';
    hkey_dict('http://scicrunch.org/resolver/SCR_002823') = 'scr_FSL';
    hkey_dict('http://scicrunch.org/resolver/SCR_007037') = 'scr_SPM';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/birnlex_2094') = 'nlx_ImagingInstrument';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/birnlex_2100') = 'nlx_MagneticResonanceImagingScanner';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/birnlex_2177') = 'nlx_MRIProtocol';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/birnlex_2250') = 'nlx_FunctionalMRIProtocol';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/birnlex_2251') = 'nlx_StructuralMRIProtocol';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/ixl_0050000') = 'nlx_PositronEmissionTomographyScanner';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/ixl_0050001') = 'nlx_SinglePhotonEmissionComputedTomographyScanner';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/ixl_0050002') = 'nlx_MagnetoencephalographyMachine';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/ixl_0050003') = 'nlx_ElectroencephalographyMachine';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/ixl_0050004') = 'nlx_AnatomicalMRIProtocol';
    hkey_dict('http://uri.neuinfo.org/nif/nifstd/nlx_inv_20090249') = 'nlx_DiffusionWeightedImagingProtocol';
end

function hnms_dict = human_namespace_dict()
    hnms_dict = containers.Map();
    hnms_dict('http://purl.org/nidash/nidm#') = 'nidm:';
    hnms_dict('http://iri.nidash.org/') = 'niiri:';
    hnms_dict('http://purl.org/nidash/spm#') = 'spm:';
    hnms_dict('http://purl.org/nidash/fsl#') = 'fsl:';
    hnms_dict('http://purl.org/nidash/afni#') = 'afni:';
    hnms_dict('http://neurolex.org/wiki/') = 'nlx:';
    hnms_dict('http://id.loc.gov/vocabulary/preservation/cryptographicHashFunctions#') = 'crypto:';
    hnms_dict('http://id.loc.gov/vocabulary/preservation/cryptographicHashFunctions/') = 'crypto:';
    hnms_dict('http://purl.org/dc/terms/') = 'dcterms:';
    hnms_dict('http://purl.org/dc/dcmitype/') = 'dctype:';
    hnms_dict('http://purl.org/dc/elements/1.1/') = 'dc:';
    hnms_dict('http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#') = 'nfo:';
    hnms_dict('http://purl.obolibrary.org/obo/') = 'obo:';
    hnms_dict('http://www.w3.org/2000/01/rdf-schema#') = 'rdfs:';
    hnms_dict('http://uri.neuinfo.org/nif/nifstd/') = 'nif:';
    hnms_dict('http://www.w3.org/ns/prov#') = 'prov:';
    hnms_dict('http://scicrunch.org/resolver/') = 'scr:';
    hnms_dict('http://www.w3.org/2001/XMLSchema-instance') = 'xsd:';
end

function [hkey, hkey_dict] = human_key(key, hkey_dict, hnms_dict)   
    if isKey(hkey_dict, key)
        hkey = hkey_dict(key);
        remove(hkey_dict, key);
    elseif isKey(hnms_dict, key)
        hkey = hnms_dict(key);
    else
        warning(['No human key found for ' key])
        hkey = key;
    end
end