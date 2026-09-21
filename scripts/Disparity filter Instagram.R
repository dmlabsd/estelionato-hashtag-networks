# =============================================================
# Espinha dorsal da rede (disparity filter) – Instagram
# =============================================================
# Aplica o disparity filter (Serrano, Boguñá & Vespignani, 2009)
# à rede de coocorrência de hashtags.
# Mantém a aresta se ela for significativa (alpha < limiar)
# para pelo menos um dos seus extremos.
# Entrada: nodes/edges gerados pelo script da rede.
# Saída: nodes/edges da espinha dorsal para o Gephi.

# --- Pacotes -------------------------------------------------
# Instalar apenas na primeira execução
# install.packages("igraph")

library(igraph)

# --- Dados ---------------------------------------------------
nodes <- read.csv("data/nodes_instagram.csv")
edges <- read.csv("data/edges_instagram.csv")

# --- Grafo ---------------------------------------------------
# Não direcionado e ponderado pelo número de coocorrências
g <- graph_from_data_frame(
  d        = edges[, c("Source", "Target", "Weight")],
  directed = FALSE,
  vertices = nodes[, c("Id", "Label", "Frequency")]
)

# --- Função: disparity filter --------------------------------
disparity_backbone <- function(g, alpha = 0.10) {
  
  w   <- E(g)$Weight
  el  <- ends(g, E(g), names = FALSE)   # extremos de cada aresta
  str <- strength(g, weights = w)       # força: soma dos pesos por nó
  deg <- degree(g)                      # grau: nº de vizinhos por nó
  
  # Significância da aresta vista de um extremo: alpha = (1 - p)^(k - 1)
  alpha_de <- function(node, w_e) {
    k <- deg[node]; s <- str[node]
    if (k <= 1 || s == 0) return(1)     # nós de grau 1 não filtram
    p <- w_e / s
    (1 - p)^(k - 1)
  }
  
  a_i <- mapply(alpha_de, el[, 1], w)
  a_j <- mapply(alpha_de, el[, 2], w)
  
  # Mantém se for significativa em ao menos um extremo
  keep <- pmin(a_i, a_j) < alpha
  
  h <- subgraph.edges(g, E(g)[keep], delete.vertices = TRUE)
  
  # Mantém apenas o componente principal
  comp <- components(h)
  h <- induced_subgraph(h, which(comp$membership == which.max(comp$csize)))
  h
}

# --- Aplicação -----------------------------------------------
bb <- disparity_backbone(g, alpha = 0.10)

cat("Backbone:", vcount(bb), "nós,", ecount(bb), "arestas,",
    "densidade", round(edge_density(bb), 3), "\n")
# IG (alpha < 0.10): (atualizar)

# --- Exportação para o Gephi ---------------------------------
bb_nodes <- data.frame(
  Id        = V(bb)$name,
  Label     = V(bb)$name,
  Frequency = V(bb)$Frequency
)


bb_edges <- igraph::as_data_frame(bb, what = "edges")
names(bb_edges)[1:2] <- c("Source", "Target")
bb_edges$Type <- "Undirected"

write.csv(bb_nodes, "data/nodes_instagram_backbone.csv", row.names = FALSE)
write.csv(bb_edges, "data/edges_instagram_backbone.csv", row.names = FALSE)
