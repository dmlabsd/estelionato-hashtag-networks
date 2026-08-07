# =============================================================================
# 00_config.R — Configuração central do projeto
# -----------------------------------------------------------------------------
# Todos os caminhos, parâmetros e constantes ficam AQUI. Nenhum outro script
# deve conter caminho absoluto ou número mágico. Alterar um limiar significa
# alterar uma linha deste arquivo — e não caçar valores espalhados pelo código.
#
# Projeto: Redes de coocorrência de hashtags no ecossistema discursivo do
#          estelionato (Instagram e TikTok)
# =============================================================================

# --- Raiz do projeto ---------------------------------------------------------
# Assume execução a partir da raiz do repositório (use um projeto .Rproj ou
# setwd() para a raiz antes de executar).
PROJ_ROOT <- normalizePath(".", mustWork = FALSE)

# --- Diretórios --------------------------------------------------------------
DIR_RAW       <- file.path(PROJ_ROOT, "data", "raw")
DIR_PROCESSED <- file.path(PROJ_ROOT, "data", "processed")
DIR_NETWORK   <- file.path(PROJ_ROOT, "data", "network")
DIR_DICT      <- file.path(PROJ_ROOT, "dictionaries")
DIR_FIGURES   <- file.path(PROJ_ROOT, "figures")
DIR_DOCS      <- file.path(PROJ_ROOT, "docs")

for (d in c(DIR_RAW, DIR_PROCESSED, DIR_NETWORK, DIR_DICT, DIR_FIGURES, DIR_DOCS)) {
  if (!dir.exists(d)) dir.create(d, recursive = TRUE)
}

# --- Parâmetros analíticos ---------------------------------------------------
# Limiar de frequência para a codificação (ver README §3.4).
# Testados: 3, 10, 20. Adotado: 10.
LIMIAR_CODIFICACAO <- 10
LIMIARES_TESTADOS  <- c(3, 10, 20)

# Disparity filter (Serrano, Boguñá & Vespignani, 2009) — ver README §3.8.
# Usado APENAS para visualização; as métricas são calculadas na rede completa.
ALPHA_DISPARITY <- 0.10

# Corte adicional de peso aplicado SOMENTE ao Instagram, exclusivamente para
# legibilidade da figura. Impacto estrutural: -1 nó, -5 arestas. Ver README §3.8.
CORTE_PESO_FIGURA_IG <- 7

# Resolução do algoritmo de Modularity no Gephi (documentada, não executada aqui).
RESOLUCAO_MODULARITY <- 1.0

# --- Especificação das plataformas -------------------------------------------
# O índice/nome da coluna de hashtags é a ÚNICA diferença real entre os
# pipelines das duas plataformas (ver README §3.2).
PLATAFORMAS <- list(
  instagram = list(
    nome            = "instagram",
    rotulo          = "Instagram",
    arquivo_bruto   = "dataset_consolidado_instagram.xlsx",
    col_hashtags    = 19,          # coluna S
    col_legenda     = 7,           # coluna G
    dicionario      = "dicionario_instagram.xlsx",
    aplica_corte_fig = TRUE
  ),
  tiktok = list(
    nome            = "tiktok",
    rotulo          = "TikTok",
    arquivo_bruto   = "dataset_consolidado_tiktok.xlsx",
    col_hashtags    = "hashtags",  # coluna AD (referenciada por nome)
    col_legenda     = "body",      # coluna I
    dicionario      = "dicionario_tiktok_revisado.xlsx",
    aplica_corte_fig = FALSE
  )
)

# --- Valores esperados (regressão) -------------------------------------------
# Cifras reportadas no documento metodológico. Os scripts comparam os
# resultados obtidos com estes valores e emitem aviso em caso de divergência.
ESPERADO <- list(
  instagram = list(
    posts = 3611, posts_com_hashtag = 3126, posts_sem_hashtag = 485,
    ocorrencias_brutas = 21812, hashtags_distintas = 5048,
    freq3 = 963, freq10 = 291, freq20 = 138,
    nos = 111, arestas_unicas = 1569, peso_total = 22471,
    backbone_nos = 88, backbone_arestas = 273
  ),
  tiktok = list(
    posts = 1957, posts_com_hashtag = 1737, posts_sem_hashtag = 220,
    ocorrencias_brutas = 9149, hashtags_distintas = 2967,
    freq3 = 425, freq10 = 103, freq20 = 51,
    nos = 47, arestas_unicas = 430, peso_total = 4244,
    backbone_nos = 40, backbone_arestas = 86
  )
)

# --- Utilitário de verificação -----------------------------------------------
checar <- function(rotulo, obtido, esperado) {
  if (is.null(esperado)) return(invisible(NULL))
  if (identical(as.numeric(obtido), as.numeric(esperado))) {
    message(sprintf("  OK   %-28s %s", rotulo, obtido))
  } else {
    warning(sprintf("  DIVERGE  %-24s obtido=%s  esperado=%s",
                    rotulo, obtido, esperado), call. = FALSE)
  }
  invisible(NULL)
}

# --- Reprodutibilidade -------------------------------------------------------
set.seed(20250917)
options(stringsAsFactors = FALSE, scipen = 999)

message("00_config.R carregado. Raiz do projeto: ", PROJ_ROOT)
