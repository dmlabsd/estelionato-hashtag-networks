# =============================================================================
# 07_metricas_rede.R — Métricas estruturais da REDE COMPLETA
# Ver README §3.7 e §5.
#
# Todas as métricas reportadas no artigo e no capítulo vêm DESTE script, que
# opera sobre a rede completa — nunca sobre a espinha dorsal nem sobre a rede
# pós-corte de figura.
#
# A detecção de comunidades no documento foi feita no Gephi (algoritmo de
# Modularity, resolução 1,0). Aqui usamos cluster_louvain(), que implementa o
# mesmo algoritmo (Blondel et al., 2008). Por ser estocástico, executamos
# N_REPETICOES vezes e reportamos a estabilidade da partição.
# =============================================================================

source("scripts/00_config.R")
source("scripts/01_setup.R")

N_REPETICOES <- 20

metricas_da_rede <- function(g, rotulo) {
  set.seed(20250917)

  qs <- numeric(N_REPETICOES)
  ks <- integer(N_REPETICOES)
  for (i in seq_len(N_REPETICOES)) {
    cl    <- igraph::cluster_louvain(g, weights = igraph::E(g)$Weight,
                                     resolution = RESOLUCAO_MODULARITY)
    qs[i] <- igraph::modularity(cl)
    ks[i] <- length(unique(igraph::membership(cl)))
  }
  cl_final <- igraph::cluster_louvain(g, weights = igraph::E(g)$Weight,
                                      resolution = RESOLUCAO_MODULARITY)

  data.frame(
    rede               = rotulo,
    nos                = igraph::vcount(g),
    arestas            = igraph::ecount(g),
    peso_total         = sum(igraph::E(g)$Weight),
    densidade          = round(igraph::edge_density(g), 3),
    grau_medio         = round(mean(igraph::degree(g)), 1),
    comunidades_moda   = as.integer(names(sort(table(ks), decreasing = TRUE))[1]),
    comunidades_min    = min(ks),
    comunidades_max    = max(ks),
    modularidade_media = round(mean(qs), 3),
    modularidade_dp    = round(stats::sd(qs), 4),
    stringsAsFactors   = FALSE
  ) -> resumo

  atributos <- data.frame(
    Id              = igraph::V(g)$name,
    Frequency       = igraph::V(g)$Frequency,
    Degree          = igraph::degree(g),
    WeightedDegree  = igraph::strength(g, weights = igraph::E(g)$Weight),
    ModularityClass = as.integer(igraph::membership(cl_final)),
    stringsAsFactors = FALSE
  )
  atributos <- atributos[order(-atributos$WeightedDegree), ]

  # % de nós com os quais cada hub coocorre (usado no README §3.8)
  atributos$PctVizinhos <- round(atributos$Degree / (igraph::vcount(g) - 1), 3)

  list(resumo = resumo, atributos = atributos)
}

processar_plataforma <- function(spec) {
  message("\n=== ", spec$rotulo, " (rede completa) ===")

  f_nodes <- file.path(DIR_NETWORK, paste0("nodes_", spec$nome, ".csv"))
  f_edges <- file.path(DIR_NETWORK, paste0("edges_", spec$nome, ".csv"))
  if (!file.exists(f_nodes)) {
    warning("Execute 05_construir_rede.R primeiro.", call. = FALSE)
    return(invisible(NULL))
  }

  nodes <- utils::read.csv(f_nodes, stringsAsFactors = FALSE, encoding = "UTF-8")
  edges <- utils::read.csv(f_edges, stringsAsFactors = FALSE, encoding = "UTF-8")

  g <- igraph::graph_from_data_frame(
    d = edges[, c("Source", "Target", "Weight")],
    directed = FALSE,
    vertices = nodes[, c("Id", "Label", "Frequency")]
  )

  res <- metricas_da_rede(g, spec$rotulo)
  print(res$resumo)

  message("\nTop 10 por Weighted Degree:")
  print(utils::head(res$atributos[, c("Id", "Frequency", "Degree", "WeightedDegree")], 10))

  utils::write.csv(res$resumo,
    file.path(DIR_PROCESSED, paste0("metricas_rede_", spec$nome, ".csv")),
    row.names = FALSE, fileEncoding = "UTF-8")
  utils::write.csv(res$atributos,
    file.path(DIR_PROCESSED, paste0("metricas_nos_", spec$nome, ".csv")),
    row.names = FALSE, fileEncoding = "UTF-8")

  invisible(res)
}

metricas <- lapply(PLATAFORMAS, processar_plataforma)
