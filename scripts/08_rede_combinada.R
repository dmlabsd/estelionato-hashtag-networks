# =============================================================================
# 08_rede_combinada.R — Rede combinada Instagram + TikTok
# Ver README §3.9.
#
# PROPÓSITO DISTINTO das redes individuais: aqui não se extrai espinha dorsal.
# O objetivo é mapear o COMPARTILHAMENTO DE VOCABULÁRIO entre as plataformas,
# atribuindo a cada nó e a cada aresta um rótulo de origem:
#   ambas | instagram | tiktok
#
# NORMALIZAÇÃO — ponto crítico. Os corpora têm tamanhos muito diferentes
# (3.126 vs 1.737 publicações com hashtag). Somar pesos em bruto faria o
# Instagram dominar o grafo por puro volume — um artefato de coleta. Por isso:
#   - coocorrências: normalizadas por 1.000 publicações de cada base;
#   - frequências:   percentual das publicações de cada base;
#   - valor de um elemento presente em ambas: MÉDIA das duas métricas relativas.
# =============================================================================

source("scripts/00_config.R")
source("scripts/01_setup.R")

# Base de normalização: publicações COM hashtag em cada plataforma.
BASE_NORM <- list(instagram = 3126, tiktok = 1737)

carregar_rede <- function(nome) {
  list(
    nodes = utils::read.csv(file.path(DIR_NETWORK, paste0("nodes_", nome, ".csv")),
                            stringsAsFactors = FALSE, encoding = "UTF-8"),
    edges = utils::read.csv(file.path(DIR_NETWORK, paste0("edges_", nome, ".csv")),
                            stringsAsFactors = FALSE, encoding = "UTF-8")
  )
}

chave_aresta <- function(source, target) {
  # canoniza a ordem do par (a rede é não-direcionada)
  paste(pmin(source, target), pmax(source, target), sep = "||")
}

construir_combinada <- function() {
  ig <- carregar_rede("instagram")
  tt <- carregar_rede("tiktok")

  # --- NÓS -------------------------------------------------------------------
  ig_n <- ig$nodes %>%
    dplyr::mutate(freq_rel_ig = Frequency / BASE_NORM$instagram * 100) %>%
    dplyr::select(Id, freq_ig = Frequency, freq_rel_ig)

  tt_n <- tt$nodes %>%
    dplyr::mutate(freq_rel_tt = Frequency / BASE_NORM$tiktok * 100) %>%
    dplyr::select(Id, freq_tt = Frequency, freq_rel_tt)

  nodes <- dplyr::full_join(ig_n, tt_n, by = "Id") %>%
    dplyr::mutate(
      origem = dplyr::case_when(
        !is.na(freq_ig) & !is.na(freq_tt) ~ "ambas",
        !is.na(freq_ig)                   ~ "instagram",
        TRUE                              ~ "tiktok"
      ),
      # média das métricas RELATIVAS quando presente nas duas plataformas
      Frequency = dplyr::case_when(
        origem == "ambas"     ~ (freq_rel_ig + freq_rel_tt) / 2,
        origem == "instagram" ~ freq_rel_ig,
        TRUE                  ~ freq_rel_tt
      ),
      Label = Id
    ) %>%
    dplyr::select(Id, Label, Frequency, origem,
                  freq_ig, freq_tt, freq_rel_ig, freq_rel_tt) %>%
    dplyr::arrange(dplyr::desc(Frequency))

  # --- ARESTAS ---------------------------------------------------------------
  ig_e <- ig$edges %>%
    dplyr::mutate(
      chave = chave_aresta(Source, Target),
      w_rel_ig = Weight / BASE_NORM$instagram * 1000
    ) %>%
    dplyr::select(chave, Source, Target, w_ig = Weight, w_rel_ig)

  tt_e <- tt$edges %>%
    dplyr::mutate(
      chave = chave_aresta(Source, Target),
      w_rel_tt = Weight / BASE_NORM$tiktok * 1000
    ) %>%
    dplyr::select(chave, w_tt = Weight, w_rel_tt,
                  Source_tt = Source, Target_tt = Target)

  edges <- dplyr::full_join(ig_e, tt_e, by = "chave") %>%
    dplyr::mutate(
      Source = dplyr::coalesce(Source, Source_tt),
      Target = dplyr::coalesce(Target, Target_tt),
      origem = dplyr::case_when(
        !is.na(w_ig) & !is.na(w_tt) ~ "ambas",
        !is.na(w_ig)                ~ "instagram",
        TRUE                        ~ "tiktok"
      ),
      Weight = dplyr::case_when(
        origem == "ambas"     ~ (w_rel_ig + w_rel_tt) / 2,
        origem == "instagram" ~ w_rel_ig,
        TRUE                  ~ w_rel_tt
      ),
      Type = "Undirected"
    ) %>%
    dplyr::select(Source, Target, Weight, Type, origem, w_ig, w_tt,
                  w_rel_ig, w_rel_tt) %>%
    dplyr::arrange(dplyr::desc(Weight))

  list(nodes = nodes, edges = edges)
}

# --- execução ----------------------------------------------------------------
if (!file.exists(file.path(DIR_NETWORK, "nodes_instagram.csv")) ||
    !file.exists(file.path(DIR_NETWORK, "nodes_tiktok.csv"))) {
  warning("Execute 05_construir_rede.R para as duas plataformas primeiro.",
          call. = FALSE)
} else {

  comb <- construir_combinada()

  # --- sobreposição (Jaccard) ------------------------------------------------
  tab_nos <- table(comb$nodes$origem)
  tab_arestas <- table(comb$edges$origem)

  jaccard <- function(tab) {
    ambas <- ifelse("ambas" %in% names(tab), tab[["ambas"]], 0)
    round(ambas / sum(tab) * 100, 1)
  }

  message("\n=== REDE COMBINADA ===")
  message("Nós:     ", nrow(comb$nodes), " total")
  message("  ambas: ", tab_nos[["ambas"]],
          " | só IG: ", tab_nos[["instagram"]],
          " | só TT: ", tab_nos[["tiktok"]],
          "  -> Jaccard ", jaccard(tab_nos), "%   (esperado: 41/70/6 = 35%)")
  message("Arestas: ", nrow(comb$edges), " total")
  message("  ambas: ", tab_arestas[["ambas"]],
          " | só IG: ", tab_arestas[["instagram"]],
          " | só TT: ", tab_arestas[["tiktok"]],
          "  -> Jaccard ", jaccard(tab_arestas), "%  (esperado: 309/1260/121 = 18%)")

  checar("nós (combinada)",     nrow(comb$nodes), 117)
  checar("arestas (combinada)", nrow(comb$edges), 1690)

  utils::write.csv(comb$nodes,
    file.path(DIR_NETWORK, "nodes_rede_combinada.csv"),
    row.names = FALSE, fileEncoding = "UTF-8")
  utils::write.csv(comb$edges,
    file.path(DIR_NETWORK, "edges_rede_combinada.csv"),
    row.names = FALSE, fileEncoding = "UTF-8")

  message("\nGravado: data/network/nodes_rede_combinada.csv e edges_rede_combinada.csv")
  message("No Gephi: colorir por 'origem' — azul-claro=ambas, cinza=só IG, verde=só TT.")
  message("ATENÇÃO: nesta figura o verde significa PLATAFORMA, não tema (README §3.8).")
}
