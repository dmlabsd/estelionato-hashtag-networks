# =============================================================================
# 06_disparity_filter.R — Extração da espinha dorsal (backbone) das redes
# Corresponde ao Apêndice B.16–B.17 do documento metodológico. Ver README §3.8.
#
# Método: disparity filter (Serrano, Boguñá & Vespignani, 2009, PNAS 106(16)).
# Para cada nó i de grau k, cada aresta incidente recebe peso normalizado
#   p_ij = w_ij / s_i
# e significância
#   alpha_ij = (1 - p_ij)^(k - 1)
# Mantém-se a aresta se ela for significativa (alpha < limiar) para PELO MENOS
# UM dos seus extremos — o que preserva as conexões localmente relevantes dos
# nós pequenos, que de outro modo seriam apagados pelos hubs.
#
# >>> REGRA DECISIVA DE INTERPRETAÇÃO <<<
# A espinha dorsal serve APENAS à visualização e à leitura dos clusters.
# TODAS as métricas estruturais reportadas (centralidade, modularidade,
# densidade, grau ponderado) são calculadas sobre a REDE COMPLETA — ver
# 07_metricas_rede.R.
# =============================================================================

source("scripts/00_config.R")
source("scripts/01_setup.R")

disparity_backbone <- function(g, alpha = ALPHA_DISPARITY) {
  w   <- igraph::E(g)$Weight
  el  <- igraph::ends(g, igraph::E(g), names = FALSE)
  frc <- igraph::strength(g, weights = w)   # força: soma dos pesos por nó
  deg <- igraph::degree(g)                  # grau: nº de vizinhos

  alpha_de <- function(no, w_e) {
    k <- deg[no]; s <- frc[no]
    if (k <= 1 || s == 0) return(1)         # nós de grau 1 não filtram
    p <- w_e / s
    (1 - p)^(k - 1)
  }

  a_i <- mapply(alpha_de, el[, 1], w)
  a_j <- mapply(alpha_de, el[, 2], w)
  manter <- pmin(a_i, a_j) < alpha          # união: significativa em >= 1 extremo

  h <- igraph::subgraph.edges(g, igraph::E(g)[manter], delete.vertices = TRUE)

  # manter apenas o componente principal
  comp <- igraph::components(h)
  igraph::induced_subgraph(h, which(comp$membership == which.max(comp$csize)))
}

processar_plataforma <- function(spec) {
  message("\n=== ", spec$rotulo, " ===")

  f_nodes <- file.path(DIR_NETWORK, paste0("nodes_", spec$nome, ".csv"))
  f_edges <- file.path(DIR_NETWORK, paste0("edges_", spec$nome, ".csv"))
  if (!file.exists(f_nodes) || !file.exists(f_edges)) {
    warning("Execute 05_construir_rede.R primeiro.", call. = FALSE)
    return(invisible(NULL))
  }

  nodes <- utils::read.csv(f_nodes, stringsAsFactors = FALSE, encoding = "UTF-8")
  edges <- utils::read.csv(f_edges, stringsAsFactors = FALSE, encoding = "UTF-8")

  g <- igraph::graph_from_data_frame(
    d        = edges[, c("Source", "Target", "Weight")],
    directed = FALSE,
    vertices = nodes[, c("Id", "Label", "Frequency")]
  )

  message("Rede completa: ", igraph::vcount(g), " nós, ", igraph::ecount(g),
          " arestas, densidade ", round(igraph::edge_density(g), 3))

  bb <- disparity_backbone(g, alpha = ALPHA_DISPARITY)

  esp <- ESPERADO[[spec$nome]]
  message("Backbone (alpha < ", ALPHA_DISPARITY, "):")
  checar("nós no backbone",     igraph::vcount(bb), esp$backbone_nos)
  checar("arestas no backbone", igraph::ecount(bb), esp$backbone_arestas)
  message("  densidade do backbone: ", round(igraph::edge_density(bb), 3))

  bb_nodes <- data.frame(
    Id        = igraph::V(bb)$name,
    Label     = igraph::V(bb)$name,
    Frequency = igraph::V(bb)$Frequency,
    stringsAsFactors = FALSE
  )
  bb_edges <- igraph::as_data_frame(bb, what = "edges")
  names(bb_edges)[1:2] <- c("Source", "Target")
  bb_edges$Type <- "Undirected"

  utils::write.csv(bb_nodes,
    file.path(DIR_NETWORK, paste0("nodes_", spec$nome, "_backbone.csv")),
    row.names = FALSE, fileEncoding = "UTF-8")
  utils::write.csv(bb_edges,
    file.path(DIR_NETWORK, paste0("edges_", spec$nome, "_backbone.csv")),
    row.names = FALSE, fileEncoding = "UTF-8")

  # --- corte adicional de peso, SOMENTE para legibilidade da figura ----------
  # Aplicado apenas ao Instagram. Impacto estrutural declarado no README §3.8:
  # remove 1 nó (digital) e 5 arestas de baixo peso; densidade, número de
  # comunidades e partição permanecem inalterados.
  if (isTRUE(spec$aplica_corte_fig)) {
    bb_fig <- igraph::subgraph.edges(
      bb, igraph::E(bb)[igraph::E(bb)$Weight >= CORTE_PESO_FIGURA_IG],
      delete.vertices = TRUE
    )
    message("Backbone p/ figura (peso >= ", CORTE_PESO_FIGURA_IG, "): ",
            igraph::vcount(bb_fig), " nós, ", igraph::ecount(bb_fig), " arestas")
    message("  (esperado: 87 nós / 268 arestas — apenas renderização)")

    fig_nodes <- data.frame(
      Id = igraph::V(bb_fig)$name, Label = igraph::V(bb_fig)$name,
      Frequency = igraph::V(bb_fig)$Frequency, stringsAsFactors = FALSE
    )
    fig_edges <- igraph::as_data_frame(bb_fig, what = "edges")
    names(fig_edges)[1:2] <- c("Source", "Target")
    fig_edges$Type <- "Undirected"

    utils::write.csv(fig_nodes,
      file.path(DIR_NETWORK, paste0("nodes_", spec$nome, "_figura.csv")),
      row.names = FALSE, fileEncoding = "UTF-8")
    utils::write.csv(fig_edges,
      file.path(DIR_NETWORK, paste0("edges_", spec$nome, "_figura.csv")),
      row.names = FALSE, fileEncoding = "UTF-8")
  }

  invisible(bb)
}

backbones <- lapply(PLATAFORMAS, processar_plataforma)
