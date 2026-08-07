# =============================================================================
# run_all.R — Executa o pipeline completo, do dado bruto aos arquivos do Gephi
#
# Uso (a partir da raiz do repositório):
#   source("scripts/run_all.R")
#
# A etapa de codificação M/U/R (README §3.5) é HUMANA e não entra neste
# pipeline: os dicionários já codificados estão versionados em dictionaries/,
# de modo que o pipeline roda de ponta a ponta sem repetir a codificação.
# =============================================================================

message(strrep("=", 78))
message("PIPELINE — Redes de coocorrência de hashtags (Instagram / TikTok)")
message("Início: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
message(strrep("=", 78))

etapas <- c(
  "scripts/01_setup.R",
  "scripts/02_extracao_frequencias.R",
  "scripts/03_cortes_frequencia.R",
  "scripts/04_aplicar_dicionario.R",
  "scripts/05_construir_rede.R",
  "scripts/06_disparity_filter.R",
  "scripts/07_metricas_rede.R",
  "scripts/08_rede_combinada.R"
)

for (etapa in etapas) {
  message("\n", strrep("-", 78))
  message(">>> ", etapa)
  message(strrep("-", 78))
  t0 <- Sys.time()
  source(etapa, echo = FALSE)
  message("    concluído em ", round(difftime(Sys.time(), t0, units = "secs"), 1), "s")
}

message("\n", strrep("=", 78))
message("PIPELINE CONCLUÍDO — ", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
message(strrep("=", 78))
message("
Próximos passos (manuais, no Gephi — ver README §4):
  1. Importar data/network/nodes_<plat>_backbone.csv e edges_<plat>_backbone.csv
  2. Definir o grafo como Undirected
  3. Statistics -> Modularity (resolução 1,0) e Average Degree
  4. Layout -> ForceAtlas2 (LinLog, Dissuade Hubs, Prevent Overlap,
     Edge Weights invertidos; parâmetros em docs/PARAMETROS_GEPHI.md)
  5. Aparência: tamanho por Frequency, cor por Modularity Class,
     espessura por Weight, rótulos em tamanho uniforme
  6. Instagram apenas: filtro adicional Edge Weight >= 7 (só legibilidade)
  7. Exportar as figuras para figures/

Registre sessionInfo() junto com os resultados.
")

print(sessionInfo())
