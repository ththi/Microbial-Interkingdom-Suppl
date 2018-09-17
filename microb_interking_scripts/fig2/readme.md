#### scripts and data required for fig2

data:

- neg_centrality_xxx : Betweenness-centrality between (negatively) connected bacterial and fungal OTUs
- selected_cor_xxx : network files received by SparCC
- taxonomy_xxx : taxonomy files for bacteria and fungi

scripts:

NOTE: there is no file to directly recover the cytoscape network but someone could do this easily with the network files.

- prop_edges.sh : gives a bargraph showing the edge proportions (input need to be changed for different networks, root/soil/rhizosphere)

- boxplot.sh : making boxplot counting the inter-kingdom connections for bacterial and fungal families (input need to be changed for different networks, root/soil/rhizosphere)

- neg_deg_vs_neg_cen.sh :  making plot of negative degree vs negative betw.centrality (input need to be changed for different networks, root/soil/rhizosphere)
