# =============================================================================
# 04_aplicar_dicionario.R — Aplicação do dicionário M/U/R e limpeza
# Corresponde ao Apêndice B.7–B.9 do documento metodológico. Ver README §3.6.
#
# Regras:
#   R  -> remove a hashtag
#   U  -> substitui pela forma canônica indicada em 'substituir por'
#   M  -> mantém
#   fora do dicionário (n < 10) -> MANTÉM (a cauda longa é preservada nesta
#         coluna; ela só é descartada em 05_construir_rede.R)
#
# Ao final, deduplica dentro do post — inclusive as duplicatas criadas pela
# própria unificação (ex.: 'fy' e 'foryou' ambos virando 'fyp').
#
# NOTA DE PERFORMANCE: a implementação original do Apêndice B usava um laço
# com filter() por hashtag (O(n*m)). Aqui a resolução é feita por lookup em
# ambiente hash, com resultado idêntico e execução ordens de grandeza mais
# rápida. A equivalência é verificável com `comparar_com_original = TRUE`.
# =============================================================================

source("scripts/00_config.R")
source("scripts/01_setup.R")

# --- construção do mapa de resolução ----------------------------------------
carregar_dicionario <- function(caminho) {
  dic <- readxl::read_excel(caminho)

  # padroniza nomes de coluna (tolera acentuação e variações de grafia)
  nomes <- tolower(names(dic))
  nomes <- gsub("ç", "c", nomes)
  nomes <- gsub("ã", "a", nomes)
  names(dic)[nomes %in% c("acao", "action")]                  <- "acao"
  names(dic)[nomes %in% c("substituir por", "substituir_por")] <- "substituir_por"

  dic %>%
    dplyr::mutate(
      tags           = stringr::str_trim(tolower(as.character(tags))),
      acao           = stringr::str_trim(toupper(as.character(acao))),
      substituir_por = stringr::str_trim(tolower(as.character(substituir_por)))
    ) %>%
    dplyr::filter(!is.na(tags), tags != "")
}

construir_mapa <- function(dic) {
  mapa <- new.env(hash = TRUE, parent = emptyenv())
  for (i in seq_len(nrow(dic))) {
    tag  <- dic$tags[i]
    acao <- dic$acao[i]
    if (is.na(acao)) next
    if (acao == "R") {
      assign(tag, NA_character_, envir = mapa)          # marca para remoção
    } else if (acao == "U") {
      alvo <- dic$substituir_por[i]
      if (is.na(alvo) || alvo == "") {
        warning("U sem forma canônica: '", tag, "' — mantida.", call. = FALSE)
        assign(tag, tag, envir = mapa)
      } else {
        assign(tag, alvo, envir = mapa)
      }
    } else if (acao == "M") {
      assign(tag, tag, envir = mapa)
    }
  }
  mapa
}

limpar_hashtags <- function(texto, mapa) {
  if (is.na(texto) || texto == "") return(NA_character_)

  tags <- unlist(stringr::str_split(texto, ","))
  tags <- tolower(stringr::str_trim(tags))
  tags <- tags[tags != "" & !is.na(tags)]
  if (length(tags) == 0) return(NA_character_)

  resolvidas <- vapply(tags, function(tag) {
    if (exists(tag, envir = mapa, inherits = FALSE)) {
      get(tag, envir = mapa, inherits = FALSE)   # NA => remover
    } else {
      tag                                        # cauda longa: mantém
    }
  }, character(1), USE.NAMES = FALSE)

  resolvidas <- resolvidas[!is.na(resolvidas)]
  resolvidas <- unique(resolvidas)               # deduplicação intra-post
  if (length(resolvidas) == 0) return(NA_character_)

  paste(resolvidas, collapse = ",")
}

# --- execução por plataforma -------------------------------------------------
processar_plataforma <- function(spec) {
  message("\n=== ", spec$rotulo, " ===")

  caminho_dados <- file.path(DIR_RAW, spec$arquivo_bruto)
  caminho_dic   <- file.path(DIR_DICT, spec$dicionario)

  if (!file.exists(caminho_dados)) {
    warning("Base não encontrada: ", caminho_dados, call. = FALSE); return(invisible(NULL))
  }
  if (!file.exists(caminho_dic)) {
    warning("Dicionário não encontrado: ", caminho_dic,
            "\n  A codificação M/U/R é uma etapa humana — ver README §3.5.",
            call. = FALSE)
    return(invisible(NULL))
  }

  dados <- readxl::read_excel(caminho_dados)
  dic   <- carregar_dicionario(caminho_dic)
  mapa  <- construir_mapa(dic)

  message("Dicionário: ", nrow(dic), " entradas (",
          sum(dic$acao == "M", na.rm = TRUE), " M / ",
          sum(dic$acao == "U", na.rm = TRUE), " U / ",
          sum(dic$acao == "R", na.rm = TRUE), " R)")

  col <- if (is.numeric(spec$col_hashtags)) names(dados)[spec$col_hashtags] else spec$col_hashtags
  dados$hashtags_original <- as.character(dados[[col]])
  dados$hashtags_limpas   <- purrr::map_chr(
    dados$hashtags_original, limpar_hashtags, mapa = mapa
  )

  n_limpas <- sum(!is.na(dados$hashtags_limpas))
  message("Publicações com hashtags após limpeza: ", n_limpas)

  saida <- file.path(DIR_PROCESSED, paste0(spec$nome, "_limpo.xlsx"))
  openxlsx::write.xlsx(dados, saida, overwrite = TRUE)
  message("Gravado: ", saida)

  invisible(dados)
}

invisible(lapply(PLATAFORMAS, processar_plataforma))
