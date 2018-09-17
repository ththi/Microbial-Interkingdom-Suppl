#### scripts and data required for fig1

data:

-  otu_tab_filter_xxx : OTU tables for the three datasets

- taxonomy_ref_xxx : taxonomic assignments for the datasets

- top_list_xxx: sorted list of most abundant OTUs from each dataset

- xxx_all_enr: result of enrichment tests

- bray_curtis_xxx: bray curtis distances between samples

- design_own_xxx: sample description


scripts:

NOTE: the scripts suite for all input files (fungi, bacteria, oomycetes), but according to the script you would need to change input files accordingly !

- enrichment_plots.sh : making stacked bar graph of enriched OTUs, based on their taxonomy
- stack_barplot.r : making stacked bar graph of relative abundances for different taxa
- pcoa.r : making pcoa plots for the different datasets
