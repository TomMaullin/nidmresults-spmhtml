%==========================================================================
% This is the run function for the NIDM-Results display toolbox. It takes
% in one argument.
%
% job - the job provided by the matlab batch spm window.
%
% Author: Tom Maullin (06/11/2017)
%==========================================================================

function nidmhtml = tbx_run_NIDM_display(job)
    
    %Retrieve the NIDM-Results pack from the batch job.
    nidmpath = job.nidmpack{1};
    
    %Retrieve the output directory from the batch job.
    outdir = job.dir{1};
    
    %Display the NIDM-Results pack.
    nidmhtml = nidm_results_display(nidmpath, 'Man', outdir);
    
end