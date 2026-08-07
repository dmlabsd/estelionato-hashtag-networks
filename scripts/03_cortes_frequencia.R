# =============================================================================
# 03_cortes_frequencia.R — Cortes de frequência e exportação para codificação
# Corresponde ao Apêndice B.5 do documento metodológico. Ver README §3.4.
#
# Justificativa do limiar n >= 10 (README §3.4):
#   (a) preserva a diversidade temática;
#   (b) elimina a cauda longa de ruído e ocorrências únicas;
#   (c) mantém um conjunto administrável para a codificação manual.
# =============================================================================

source("scripts/00_config.R")
source("scripts/01_setup.R")

aplicar_cortes <- function(spec) {
  message("\n=== ", spec$rotulo, " ===")

  caminho <- file.path(DIR_PROCESSED, paste0("frequencias_", spec$nome, ".xlsx"))
  if (!file.exists(caminho)) {
    warning("Execute 02_extracao_frequencias.R primeiro.", call. = FALSE)
    return(invisible(NULL))
  }

  freq <- readxl::read_excel(caminho)
  esp  <- ESPERADO[[spec$nome]]

  for (lim in LIMIARES_TESTADOS) {
    subconjunto <- dplyr::filter(freq, n >= lim)
    checar(paste0("hashtags n >= ", lim), nrow(subconjunto), esp[[paste0("freq", lim)]])

    saida <- file.path(
      DIR_PROCESSED,
      sprintf("hashtags_freq%d_%s.csv", lim, spec$nome)
    )
    utils::write.csv(subconjunto, saida, row.names = FALSE, fileEncoding = "UTF-8")
  }

  # Planilha de trabalho para a codificação manual M/U/R (etapa humana).
  candidatas <- freq %>%
    dplyr::filter(n >= LIMIAR_CODIFICACAO) %>%
    dplyr::mutate(
      `ação`          = NA_character_,   # M | U | R
      `substituir por` = NA_character_,
      justificativa   = NA_character_,
      ambiguo         = FALSE
    )

  modelo <- file.path(
    DIR_DICT,
    sprintf("MODELO_dicionario_%s_a_codificar.xlsx", spec$nome)
  )
  openxlsx::write.xlsx(candidatas, modelo, overwrite = TRUE)
  message("Planilha de codificação gerada: ", modelo)
  message("  -> Etapa humana: preencher 'ação' (M/U/R) e 'substituir por'.")

  invisible(candidatas)
}

invisible(lapply(PLATAFORMAS, aplicar_cortes))
