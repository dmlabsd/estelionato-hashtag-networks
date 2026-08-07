# =============================================================================
# 02_extracao_frequencias.R — Extração de hashtags e contagem de frequências
# Corresponde ao Apêndice B.2–B.6 e B.15 do documento metodológico.
# Ver README §3.4.
#
# ATENÇÃO METODOLÓGICA
# A contagem desta etapa é por OCORRÊNCIA BRUTA, não por presença no post.
# Uma hashtag repetida dentro do mesmo post é contada mais de uma vez.
# A deduplicação intra-post ocorre apenas em 04_aplicar_dicionario.R e em
# 05_construir_rede.R. É por isso que a frequência na tabela é, em geral,
# ligeiramente superior à frequência do nó correspondente na rede.
# =============================================================================

source("scripts/00_config.R")
source("scripts/01_setup.R")

extrair_hashtags <- function(dados, col_hashtags) {
  col <- if (is.numeric(col_hashtags)) names(dados)[col_hashtags] else col_hashtags
  dados %>%
    dplyr::select(tags = dplyr::all_of(col)) %>%
    dplyr::mutate(tags = as.character(tags)) %>%
    tidyr::separate_rows(tags, sep = ",") %>%
    dplyr::mutate(
      tags = stringr::str_trim(tags),
      tags = tolower(tags)
    ) %>%
    dplyr::filter(!is.na(tags), tags != "")
}

processar_plataforma <- function(spec) {
  message("\n=== ", spec$rotulo, " ===")

  caminho <- file.path(DIR_RAW, spec$arquivo_bruto)
  if (!file.exists(caminho)) {
    warning("Arquivo não encontrado: ", caminho,
            "\n  Copie a base mestra para data/raw/ antes de executar.",
            call. = FALSE)
    return(invisible(NULL))
  }

  dados <- readxl::read_excel(caminho)

  # --- estatísticas descritivas do corpus (B.15) -----------------------------
  col <- if (is.numeric(spec$col_hashtags)) names(dados)[spec$col_hashtags] else spec$col_hashtags
  vetor_hashtags <- as.character(dados[[col]])

  n_posts       <- nrow(dados)
  n_com_hashtag <- sum(!is.na(vetor_hashtags) & vetor_hashtags != "")
  n_sem_hashtag <- n_posts - n_com_hashtag

  # --- extração e contagem ---------------------------------------------------
  hashtags <- extrair_hashtags(dados, spec$col_hashtags)
  freq     <- hashtags %>% dplyr::count(tags, sort = TRUE)

  esp <- ESPERADO[[spec$nome]]
  message("Conferência contra os valores do documento metodológico:")
  checar("publicações",         n_posts,       esp$posts)
  checar("com hashtag",         n_com_hashtag, esp$posts_com_hashtag)
  checar("sem hashtag",         n_sem_hashtag, esp$posts_sem_hashtag)
  checar("ocorrências brutas",  nrow(hashtags), esp$ocorrencias_brutas)
  checar("hashtags distintas",  nrow(freq),     esp$hashtags_distintas)

  # --- exportação ------------------------------------------------------------
  saida <- file.path(DIR_PROCESSED, paste0("frequencias_", spec$nome, ".xlsx"))
  openxlsx::write.xlsx(freq, saida, overwrite = TRUE)
  message("Gravado: ", saida)

  resumo <- data.frame(
    plataforma         = spec$rotulo,
    publicacoes        = n_posts,
    com_hashtag        = n_com_hashtag,
    sem_hashtag        = n_sem_hashtag,
    ocorrencias_brutas = nrow(hashtags),
    hashtags_distintas = nrow(freq)
  )
  utils::write.csv(
    resumo,
    file.path(DIR_PROCESSED, paste0("resumo_corpus_", spec$nome, ".csv")),
    row.names = FALSE
  )

  invisible(freq)
}

frequencias <- lapply(PLATAFORMAS, processar_plataforma)
