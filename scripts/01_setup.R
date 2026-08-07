# =============================================================================
# 01_setup.R — Instalação e carregamento dos pacotes
# Corresponde ao Apêndice B.1 do documento metodológico.
# =============================================================================

pacotes <- c(
  "readxl",    # leitura de .xlsx
  "dplyr",     # manipulação de data frames
  "tidyr",     # separate_rows()
  "stringr",   # str_trim(), str_split()
  "purrr",     # map_chr()
  "igraph",    # grafos e disparity filter
  "writexl",   # escrita de .xlsx
  "openxlsx"   # escrita de .xlsx com opções
)

faltantes <- pacotes[!(pacotes %in% installed.packages()[, "Package"])]
if (length(faltantes) > 0) {
  message("Instalando: ", paste(faltantes, collapse = ", "))
  install.packages(faltantes, repos = "https://cloud.r-project.org")
}

invisible(lapply(pacotes, library, character.only = TRUE))

message("Pacotes carregados. R ", getRversion())
message("Registre a saída de sessionInfo() ao publicar resultados.")
