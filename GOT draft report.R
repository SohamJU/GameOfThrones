library(igraph)
file=read.csv("stormofswords.csv")
file
graph=graph_from_data_frame(file,directed=FALSE)
plot(graph)
DG=degree(graph)
DG
head(sort(DG,decreasing=TRUE),10)
CC=closeness(graph)
CC
head(sort(CC,decreasing=TRUE),10)
BC=betweenness(graph)
BC
head(sort(BC,decreasing=TRUE),10)
avgclusco=transitivity(graph)
avgclusco
clus_co=transitivity(graph,type='local')
clus_co
clus_co[is.nan(clus_co)]='Inf'
clus_co
ecc=eccentricity(graph)
ecc
PR=page_rank(graph)
PR
PR=as.numeric(as.character(unlist(PR))) ## removing string from list to make it numeric
PR=PR[1:108] #last value is bogus
PR
combo=cbind(DG,CC,BC,ecc,clus_co,PR)
round(combo, digits=3)
colnames(combo)=c('Degree','Closeness Centrality', 'Betweenness Centrality','Eccentricity','Clustering Co-efficient','Page Rank')
combo

