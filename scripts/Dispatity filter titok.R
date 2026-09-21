# =============================================================
# Espinha dorsal da rede (disparity filter) – TikTok
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
nodes_tt <- read.csv("data/nodes_tiktok.csv")
edges_tt <- read.csv("data/edges_tiktok.csv")

# --- Grafo ---------------------------------------------------
# Não direcionado e ponderado pelo número de coocorrências
g_tt <- graph_from_data_frame(
  d        = edges_tt[, c("Source", "Target", "Weight")],
  directed = FALSE,
  vertices = nodes_tt[, c("Id", "Label", "Frequency")]
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
bb_tt <- disparity_backbone(g_tt, alpha = 0.10)

cat("Backbone:", vcount(bb_tt), "nós,", ecount(bb_tt), "arestas,",
    "densidade", round(edge_density(bb_tt), 3), "\n")
# TT (alpha < 0.10): (atualizar)

# --- Exportação para o Gephi ---------------------------------
bb_nodes_tt <- data.frame(
  Id        = V(bb_tt)$name,
  Label     = V(bb_tt)$name,
  Frequency = V(bb_tt)$Frequency
)

bb_edges_tt <- igraph::as_data_frame(bb_tt, what = "edges")
names(bb_edges_tt)[1:2] <- c("Source", "Target")
bb_edges_tt$Type <- "Undirected"

write.csv(bb_nodes_tt, "data/nodes_tiktok_backbone.csv", row.names = FALSE)
write.csv(bb_edges_tt, "data/edges_tiktok_backbone.csv", row.names = FALSE)