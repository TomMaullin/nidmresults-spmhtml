# nidmresults-spmhtml

Import mass-univariate neuroimaging results computed in SPM as NIDM-Results packs.

Usage

1. Add the filepath to the nidmresults-spmhtml directory in Matlab;

e.g. In matlab enter:

```
addpath(<full path to nidmresults-spmhtml>)
```

2. Add the filepath to SPM in Matlab;


e.g. In matlab enter:

```
addpath(<full path to matlab>)
```

3. Download the updated spm_jsonread files and add the path to them in matlab.


e.g. In matlab enter:

```
addpath(<full path to new spm json reader>)
```

4. Run the following:

```
nidm_results_display(<full path to nidm json file you wish to view>)
```

(where <full path to nidm json file you wish to view> is replace with the full path to the nidm json file you wish to view)