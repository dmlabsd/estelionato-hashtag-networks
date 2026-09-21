# =============================================================
# Rede de coocorrência de hashtags – TikTok
# =============================================================
# Gera duas tabelas para o Gephi:
#   nodes = hashtags e sua frequência
#   edges = pares de hashtags no mesmo post (peso = nº de posts)

# --- Pacotes -------------------------------------------------
# Instalar apenas na primeira execução
# install.packages(c("readxl", "dplyr", "tidyr", "stringr"))

library(readxl)    # leitura de .xlsx
library(dplyr)
library(tidyr)
library(stringr)

# --- Dados ---------------------------------------------------
# Base anonimizada do TikTok
dados_tt <- read_xlsx("data/dados_anonimizados_tiktok.xlsx")

# --- Hashtags: uma por linha ---------------------------------
hashtags_limpas_tt <- dados_tt %>%
  select(tags = hashtags_limpas) %>%
  separate_rows(tags, sep = ",") %>%
  mutate(tags = str_trim(tags)) %>%
  filter(!is.na(tags), tags != "")

# --- Nós: hashtags e frequência ------------------------------
nodes_tt <- hashtags_limpas_tt %>%
  count(tags, sort = TRUE) %>%
  mutate(Label = tags) %>%
  rename(Id = tags, Frequency = n)

# --- Arestas: pares de hashtags no mesmo post ----------------
posts_tt <- dados_tt$hashtags_limpas
lista_edges_tt <- list()

for (i in seq_along(posts_tt)) {
  
  tags <- posts_tt[i]
  if (is.na(tags) || tags == "") { next }
  
  # Separa, remove duplicadas e ordena (rede não direcionada:
  # o par A–B é contado junto com B–A)
  tags <- str_split(tags, ",")[[1]]
  tags <- sort(unique(str_trim(tags)))
  tags <- tags[tags != ""]
  
  # Posts com menos de 2 hashtags não geram pares
  if (length(tags) < 2) { next }
  
  # Todos os pares possíveis do post
  pares <- t(combn(tags, 2))
  lista_edges_tt[[length(lista_edges_tt) + 1]] <- as.data.frame(pares)
}

# Junta os pares de todos os posts
edges_tt <- bind_rows(lista_edges_tt)
names(edges_tt) <- c("Source", "Target")

# Peso = nº de posts em que o par aparece junto
edges_tt <- edges_tt %>%
  count(Source, Target, name = "Weight") %>%
  arrange(desc(Weight))

# --- Filtro: hashtags com frequência mínima ------------------
limiar <- 10

nodes_tt <- nodes_tt %>% filter(Frequency >= limiar)

# Mantém só arestas entre hashtags que ficaram na rede
edges_tt <- edges_tt %>%
  filter(Source %in% nodes_tt$Id, Target %in% nodes_tt$Id)

# --- Tamanho da rede -----------------------------------------
cat("Nós:",     nrow(nodes_tt), "\n")   # TT: 47
cat("Arestas:", nrow(edges_tt), "\n")   # TT: TT: 430

# --- Exportação para o Gephi ---------------------------------
write.csv(nodes_tt, "data/nodes_tiktok.csv", row.names = FALSE)
write.csv(edges_tt, "data/edges_tiktok.csv", row.names = FALSE)
