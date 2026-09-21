# =============================================================
# Limpeza de hashtags com dicionário – TikTok
# =============================================================
# Aplica o dicionário a cada post:
#   R = remove | M = mantém | U = unifica (substitui por outra forma)
# Hashtags fora do dicionário são mantidas (cauda longa).
# Requer o objeto dados_tt já carregado.

# --- Pacotes -------------------------------------------------
library(readxl)
library(dplyr)
library(stringr)
library(purrr)     # map_chr()
library(openxlsx)  # exportação para Excel

# --- Dicionário ----------------------------------------------
dic_tt <- read_excel("data/dicionario_tiktok.xlsx")


names(dic_tt)[4] <- "ação"             # ação_final
names(dic_tt)[5] <- "substituir por"   # substituir_por

# Padroniza tags e ações (minúsculas / maiúsculas, sem espaços)
dic_tt <- dic_tt %>%
  mutate(
    tags = str_trim(tolower(tags)),
    ação = str_trim(toupper(ação))
  )

# --- Função de limpeza ---------------------------------------
limpar_hashtags_tt <- function(texto) {
  
  # Post sem hashtags
  if (is.na(texto) || texto == "") {
    return(NA_character_)
  }
  
  # Separa e padroniza as hashtags do post
  tags <- unlist(str_split(texto, ","))
  tags <- tags %>% str_trim() %>% tolower()
  
  resultado <- c()
  
  for (tag in tags) {
    
    linha <- dic_tt %>% filter(tags == tag)
    
    # Fora do dicionário: mantém
    if (nrow(linha) == 0) {
      resultado <- c(resultado, tag)
      next
    }
    
    acao <- linha$ação[1]
    
    if (acao == "R") {                  # remove
      next
    }
    if (acao == "M") {                  # mantém
      resultado <- c(resultado, tag)
      next
    }
    if (acao == "U") {                  # unifica
      resultado <- c(resultado, linha$`substituir por`[1])
    }
  }
  
  # Remove duplicadas dentro do mesmo post
  resultado <- unique(resultado)
  paste(resultado, collapse = ",")
}

# --- Aplicação -----------------------------------------------
dados_anon_tt$hashtags_limpas <- map_chr(dados_anon_tt$hashtags, limpar_hashtags_tt)

# --- Exportação ----------------------------------------------
write.xlsx(dados_anon_tt, "data/tiktok_limpo.xlsx", overwrite = TRUE)
