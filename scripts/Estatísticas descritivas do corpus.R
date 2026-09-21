# =============================================================
# Descrição das hashtags – Instagram
# =============================================================
# Conta o total de ocorrências de hashtags (brutas) e
# quantos posts têm ou não hashtags.

# --- Pacotes -------------------------------------------------
library(dplyr)
library(tidyr)
library(stringr)

# --- Dados ---------------------------------------------------
# Base anonimizada do Instagram
dados_ig <- read.csv("data/dados_anonimizados_instagram.csv")

# --- Total de ocorrências de hashtags (brutas) ---------------
# Uma hashtag por linha; conta todas as ocorrências
total_hashtags <- dados_ig %>%
  select(hashtags = 19) %>%
  separate_rows(hashtags, sep = ",") %>%
  mutate(hashtags = str_trim(hashtags)) %>%
  filter(!is.na(hashtags), hashtags != "") %>%
  nrow()

total_hashtags                       # IG: 21812

# --- Posts com e sem hashtags --------------------------------
dados_ig %>%
  summarise(
    total_posts = n(),
    com_hashtag = sum(!is.na(.[[19]]) & .[[19]] != ""),
    sem_hashtag = sum( is.na(.[[19]]) | .[[19]] == "")
  )                                  # IG: 3611 / 3126 / 485



#======================================

# =============================================================
# Descrição das hashtags – TikTok
# =============================================================
# Conta o total de ocorrências de hashtags (brutas) e
# quantos posts têm ou não hashtags.

# --- Pacotes -------------------------------------------------
library(readxl)    # leitura de .xlsx
library(dplyr)
library(tidyr)
library(stringr)

# --- Dados ---------------------------------------------------
# Base anonimizada do TikTok
dados_tt <- read_xlsx("data/dados_anonimizados_tiktok.xlsx")

# --- Total de ocorrências de hashtags (brutas) ---------------
total_hashtags_tt <- dados_tt %>%
  select(hashtags = hashtags) %>%
  separate_rows(hashtags, sep = ",") %>%
  mutate(hashtags = str_trim(hashtags)) %>%
  filter(!is.na(hashtags), hashtags != "") %>%
  nrow()

total_hashtags_tt                    # TT: 9149

# --- Posts com e sem hashtags --------------------------------
dados_tt %>%
  summarise(
    total_posts = n(),
    com_hashtag = sum(!is.na(hashtags) & hashtags != ""),
    sem_hashtag = sum( is.na(hashtags) | hashtags == "")
  )                   

# TT: 1957 / 1737 / 220
