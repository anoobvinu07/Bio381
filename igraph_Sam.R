# igraph
# December 05, 2018
# Sam

library(igraph)
library(igraphdata)
data(igraphdata)
data(foodwebs)

g <- make_empty_graph(directed = FALSE)
g <- g + vertices('Bio', 'Eco', 'CS', 'Soc','Psych', 'Econ')
plot(g, vertex.label.dist=3)

g <- g + edges(c('CS', 'Bio',  'CS','Econ', 'CS', 'Soc', 'CS', 'Psych'))
plot(g, vertex.label.dist=3)

g <- g + edges(c('Bio', 'Eco', 'Eco','Econ','Soc', 'Psych', 'Soc', 'Econ'))
plot(g, vertex.label.dist=3)

edgeList <- matrix(c('CS', 'Bio',  'CS','Econ', 'CS', 'Soc', 'CS', 'Psych','Bio', 'Eco', 'Eco','Econ','Soc', 'Psych', 'Soc', 'Econ'), nc = 2, byrow = 2)
print(edgeList)

edgeList2 <- as.edgelist(g, names = TRUE)
print(edgeList2)

gEdgeList <- graph_from_edgelist(edgeList, directed = FALSE)
plot(gEdgeList, vertex.label.dist = 3)

adjMatG <- as_adjacency_matrix(g) # get the adjacency matrix of g
print(adjMatG)

gAdjMat <- graph_from_adjacency_matrix(adjMatG, mode = 'undirected')
plot(gAdjMat, vertex.label,dist=3)

# Directed Networks
adjMat <- matrix(data = 0, nrow = 7, ncol = 7)
species <- c('coyote', 'vulture','snake','grass','bug','hawk', 'mouse')
rownames(adjMat) <- colnames(adjMat) <- species
print(adjMat)

adjMat["grass","hawk"] <- 1
adjMat["bug","hawk"] <- 1
adjMat["grass","mouse"] <- 1
adjMat["mouse","hawk"] <- 1
adjMat["mouse","coyote"] <- 1
adjMat["mouse","snake"] <- 1
adjMat["mouse","vulture"] <- 1
adjMat["hawk","coyote"] <- 1
adjMat["coyote","vulture"] <- 1
adjMat["snake","vulture"] <- 1

print(adjMat)
foodWeb <- graph_from_adjacency_matrix(adjMat)
plot(foodWeb, vertex.label.dist = 3)

is_weighted(foodWeb)

adjMat["grass","hawk"] <- 0.2
adjMat["bug","hawk"] <- 1
adjMat["grass","mouse"] <- 0.8
adjMat["mouse","hawk"] <- 0.2
adjMat["mouse","coyote"] <- 0.2
adjMat["mouse","snake"] <- 0.2
adjMat["mouse","vulture"] <- 0.4
adjMat["hawk","coyote"] <- 1
adjMat["coyote","vulture"] <- 1
adjMat["snake","vulture"] <- 1

print(adjMat)
foodWeb <- graph_from_adjacency_matrix(adjMat, weighted = TRUE)
plot(foodWeb, vertex.label.dist = 3)

is.weighted(foodWeb)

# Label the edges with weights
plot(foodWeb, vertex.label.dist = 3, edge.label = E(foodWeb)$weight) #E gives the attributes of the edges

# map edge weights to the widths of plotted edges
E(foodWeb)$width <- E(foodWeb)$weight*4 # 4 indicates the width
plot(foodWeb, vertex.label.dist = 3)

# Working with existing data
fwc <- foodwebs$CrystalC

plot(fwc, layout = layout_as_tree, vertex.label.dist=1.5)