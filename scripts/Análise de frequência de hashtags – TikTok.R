# =============================================================
# Análise de frequência de hashtags – TikTok
# =============================================================

# --- Pacotes -------------------------------------------------
# Instalar apenas na primeira execução
# install.packages(c("readxl", "dplyr", "tidyr", "stringr", "openxlsx"))

library(readxl)    # leitura de .xlsx
library(dplyr)
library(tidyr)
library(stringr)
library(openxlsx)  # exportação para Excel

# --- Dados ---------------------------------------------------
# Base anonimizada do TikTok
dados_anon_tt <- read_xlsx("data/dados_anonimizados_tiktok.xlsx")

# --- Hashtags: uma por linha ---------------------------------
hashtags_tt <- dados_anon_tt %>%
  select(tags = hashtags) %>%
  separate_rows(tags, sep = ",") %>%
  mutate(tags = tolower(str_trim(tags))) %>%
  filter(!is.na(tags), tags != "")

# --- Frequência ----------------------------------------------
freq_tt <- hashtags_tt %>%
  count(tags, sort = TRUE)

print(freq_tt, n = 100)  # 100 hashtags mais frequentes

# Nº de hashtags por frequência mínima (IG incluído para comparação)
freq3_tt  <- freq_tt %>% filter(n >= 3);   nrow(freq3_tt)    # IG: 963 | TT: 425
freq10_tt <- freq_tt %>% filter(n >= 10);  nrow(freq10_tt)   # IG: 291 | TT: 103
freq20_tt <- freq_tt %>% filter(n >= 20);  nrow(freq20_tt)   # IG: 138 | TT: 51

# --- Exportação ----------------------------------------------
write.xlsx(freq_tt, "data/frequencias_tiktok.xlsx", overwrite = TRUE)

