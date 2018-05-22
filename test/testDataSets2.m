%==========================================================================
%Unit tests for testing whether datasets run in the viewer. To run the
%below run the runTest function. The html files generated can be found in
%the corresponding folders after the test has been run.
%
%Authors: Thomas Maullin, Camille Maumet. (Adapted from the testDataSets
%matlab unittest function).
%==========================================================================

function test_suite=testDataSets2
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

%Function for deleting any HTML generated previously by the viewer
function delete_html_file(data_path)
    index = fullfile(data_path,'index.html');
    if exist(index, 'file')
       delete(index);
    else
        for(i = 1:8)
            index = fullfile(data_path,['index', num2str(i), '.html']);
            if exist(index, 'file')
                delete(index);
            end
        end
    end
end

%Test viewer displays ex_spm_HRF_informed_basis.nidm
function test_ex_spm_HRF_informed_basis()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_HRF_informed_basis.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_HRF_informed_basis.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_HRF_informed_basis.nidm'), 'all');
end

%Test viewer displays ex_spm_conjunction.nidm
function test_ex_spm_conjunction()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_conjunction.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_conjunction.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_conjunction.nidm'), 'all');
end

%Test viewer displays ex_spm_contrast_mask.nidm
function test_ex_spm_contrast_mask()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_contrast_mask.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_contrast_mask.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_contrast_mask.nidm'), 'all');
end

%Test viewer displays ex_spm_default.nidm
function test_ex_spm_default()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_default.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_default.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_default.nidm'), 'all');
end

%Test viewer displays ex_spm_full_example001.nidm
function test_ex_spm_full_example001()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_full_example001.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_full_example001.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_full_example001.nidm'), 'all');
end

%Test viewer displays ex_spm_group_ols.nidm
function test_ex_spm_group_ols()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_group_ols.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_group_ols.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_group_ols.nidm'), 'all');
end

%Test viewer displays ex_spm_group_wls.nidm
function test_ex_spm_group_wls()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_group_wls.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_group_wls.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_group_wls.nidm'), 'all');
end

%Test viewer displays ex_spm_partial_conjunction.nidm
function test_ex_spm_partial_conjunction()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_partial_conjunction.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_partial_conjunction.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_partial_conjunction.nidm'), 'all');
end

%Test viewer displays ex_spm_temporal_derivative.nidm
function test_ex_spm_temporal_derivative()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_temporal_derivative.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_temporal_derivative.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_temporal_derivative.nidm'), 'all');
end

%Test viewer displays ex_spm_thr_clustfwep05.nidm
function test_ex_spm_thr_clustfwep05()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_thr_clustfwep05.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_thr_clustfwep05.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_thr_clustfwep05.nidm'), 'all');
end

%Test viewer displays ex_spm_thr_clustunck10.nidm
function test_ex_spm_thr_clustunck10()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_thr_clustunck10.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_thr_clustunck10.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_thr_clustunck10.nidm'), 'all');
end

%Test viewer displays ex_spm_thr_voxelfdrp05.nidm
function test_ex_spm_thr_voxelfdrp05()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_thr_voxelfdrp05.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_thr_voxelfdrp05.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_thr_voxelfdrp05.nidm'), 'all');
end

%Test viewer displays ex_spm_thr_voxelfwep05.nidm
function test_ex_spm_thr_voxelfwep05()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_thr_voxelfwep05.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_thr_voxelfwep05.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_thr_voxelfwep05.nidm'), 'all');
end

%Test viewer displays ex_spm_thr_voxelunct4.nidm
function test_ex_spm_thr_voxelunct4()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','ex_spm_thr_voxelunct4.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/ex_spm_thr_voxelunct4.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','ex_spm_thr_voxelunct4.nidm'), 'all');
end

%Test viewer displays fsl_con_f_130.nidm
function test_fsl_con_f_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_con_f_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_con_f_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_con_f_130.nidm'), 'all');
end

%Test viewer displays fsl_contrast_mask_130.nidm
function test_fsl_contrast_mask_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_contrast_mask_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_contrast_mask_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_contrast_mask_130.nidm'), 'all');
end

%Test viewer displays fsl_default_130.nidm
function test_fsl_default_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_default_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_default_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_default_130.nidm'), 'all');
end

%Test viewer displays fsl_full_examples001_130.nidm
function test_fsl_full_examples001_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_full_examples001_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_full_examples001_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_full_examples001_130.nidm'), 'all');
end

%Test viewer displays fsl_gamma_basis_130.nidm
function test_fsl_gamma_basis_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_gamma_basis_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_gamma_basis_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_gamma_basis_130.nidm'), 'all');
end

%Test viewer displays fsl_gaussian_130.nidm
function test_fsl_gaussian_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_gaussian_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_gaussian_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_gaussian_130.nidm'), 'all');
end

%Test viewer displays fsl_group_btw_130.nidm
function test_fsl_group_btw_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_group_btw_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_group_btw_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_group_btw_130.nidm'), 'all');
end

%Test viewer displays fsl_group_ols_130.nidm
function test_fsl_group_ols_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_group_ols_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_group_ols_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_group_ols_130.nidm'), 'all');
end

%Test viewer displays fsl_group_wls_130.nidm
function test_fsl_group_wls_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_group_wls_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_group_wls_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_group_wls_130.nidm'), 'all');
end

%Test viewer displays fsl_hrf_fir_130.nidm
function test_fsl_hrf_fir_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_hrf_fir_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_hrf_fir_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_hrf_fir_130.nidm'), 'all');
end

%Test viewer displays fsl_hrf_gammadiff_130.nidm
function test_fsl_hrf_gammadiff_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_hrf_gammadiff_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_hrf_gammadiff_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_hrf_gammadiff_130.nidm'), 'all');
end

%Test viewer displays fsl_thr_clustfwep05_130.nidm
function test_fsl_thr_clustfwep05_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_thr_clustfwep05_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_thr_clustfwep05_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_thr_clustfwep05_130.nidm'), 'all');
end

%Test viewer displays fsl_thr_voxelfwep05_130.nidm
function test_fsl_thr_voxelfwep05_130()
    data_path = fullfile(fileparts(mfilename('fullpath')),'..','test','data','fsl_thr_voxelfwep05_130.nidm');
    if(~exist(data_path, 'dir'))
        mkdir(data_path);
        websave([data_path, filesep, 'temp.zip'], 'http://neurovault.org/collections/2210/fsl_thr_voxelfwep05_130.nidm.zip');
        unzip([data_path, filesep, 'temp.zip'], [data_path, filesep]);
    end
    delete_html_file(data_path);
    nidm_results_display(fullfile(fileparts(mfilename('fullpath')), '..', 'test','data','fsl_thr_voxelfwep05_130.nidm'), 'all');
end
