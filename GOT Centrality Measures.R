library(igraph)
file=read.csv("OverSeries.csv")
View(file)
graph=graph_from_data_frame(file,directed=FALSE)
plot(graph)
DG=degree(graph)
DG
head(sort(DG,decreasing=TRUE),10)
EG=eigen_centrality(graph)
EG=EG$vector#only numeric part of list is needed
head(sort(EG,decreasing=TRUE),10)
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
ecc=eccentricity(graph)
ecc
PR=page_rank(graph)
PR=PR$vector #only numeric part of list is needed
combo=cbind(DG,CC,BC,ecc,clus_co,PR,EG)
colnames(combo)=c('Degree','Closeness Centrality', 'Betweenness Centrality','Eccentricity','Clustering Co-efficient','Page Rank','Eigen Value Centrality')
combo=as.data.frame(combo) 
write.csv(combo,'prediciton.csv')
#Small World Phenomenon
mean(combo$Eccentricity)
# Power law fit for Degree Distribution
fit_power_law(DG)

