# =============================================================
# Análise de frequência de hashtags – Instagram
# =============================================================

# --- Pacotes -------------------------------------------------
# Instalar apenas na primeira execução
# install.packages(c("readxl", "dplyr", "tidyr", "stringr", "openxlsx"))

library(readxl)    # leitura de .xlsx (dados do TikTok)
library(dplyr)
library(tidyr)
library(stringr)
library(openxlsx)  # exportação para Excel

# --- Dados ---------------------------------------------------
# Base anonimizada do Instagram
dados_ig <- read.csv("data/dados_anonimizados_instagram.csv")

# TikTok (mesma análise):
# dados_tt <- read_excel("caminho/do/projeto/dataset consolidado tiktok.xlsx")

# --- Hashtags: uma por linha ---------------------------------
hashtags <- dados_ig %>%
  select(tags = hashtags) %>%
  separate_rows(tags, sep = ",") %>%
  mutate(tags = tolower(str_trim(tags))) %>%
  filter(!is.na(tags), tags != "")

# --- Frequência ----------------------------------------------
freq <- hashtags %>%
  count(tags, sort = TRUE)

print(freq, n = 100)  # 100 hashtags mais frequentes

# Nº de hashtags por frequência mínima
freq3  <- freq %>% filter(n >= 3);   nrow(freq3)    # IG: 963 | TT: 425
freq10 <- freq %>% filter(n >= 10);  nrow(freq10)   # IG: 291 | TT: 103
freq20 <- freq %>% filter(n >= 20);  nrow(freq20)   # IG: 138 | TT: 51

# --- Exportação ----------------------------------------------
write.xlsx(freq, "data/frequencias_instagram.xlsx", overwrite = TRUE)


