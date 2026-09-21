# =============================================================
# Rede de coocorrência de hashtags – Instagram
# =============================================================
# Gera duas tabelas para o Gephi:
#   nodes = hashtags e sua frequência
#   edges = pares de hashtags no mesmo post (peso = nº de posts)

# --- Pacotes -------------------------------------------------
# Instalar apenas na primeira execução
# install.packages(c("dplyr", "tidyr", "stringr"))

library(dplyr)
library(tidyr)
library(stringr)

# --- Dados ---------------------------------------------------
# Base anonimizada do Instagram
dados_ig <- read.csv("data/dados_anonimizados_instagram.csv")

# --- Hashtags: uma por linha ---------------------------------
hashtags_limpas <- dados_ig %>%
  select(tags = hashtags_limpas) %>%
  separate_rows(tags, sep = ",") %>%
  mutate(tags = str_trim(tags)) %>%
  filter(tags != "")

# --- Nós: hashtags e frequência ------------------------------
nodes <- hashtags_limpas %>%
  count(tags, sort = TRUE) %>%
  mutate(Label = tags) %>%
  rename(Id = tags, Frequency = n)

# --- Arestas: pares de hashtags no mesmo post ----------------
posts <- dados_ig$hashtags_limpas
lista_edges <- list()

for (i in seq_along(posts)) {
  
  tags <- posts[i]
  if (is.na(tags) || tags == "") { next }
  
  # Separa, remove duplicadas e ordena (rede não direcionada)
  tags <- str_split(tags, ",")[[1]]
  tags <- unique(str_trim(tags))
  tags <- tags[tags != ""]
  
  # Posts com menos de 2 hashtags não geram pares
  if (length(tags) < 2) { next }
  
  # Todos os pares possíveis do post
  pares <- t(combn(tags, 2))
  lista_edges[[length(lista_edges) + 1]] <- as.data.frame(pares)
}

# Junta os pares de todos os posts
edges <- bind_rows(lista_edges)
names(edges) <- c("Source", "Target")

# Peso = nº de posts em que o par aparece junto
edges <- edges %>%
  count(Source, Target, name = "Weight") %>%
  arrange(desc(Weight))



# --- Filtro: hashtags com frequência mínima ------------------
limiar <- 10   # IG: 111 nós | TT: 47 nós

nodes <- nodes %>% filter(Frequency >= limiar)

# Mantém só arestas entre hashtags que ficaram na rede
edges <- edges %>%
  filter(Source %in% nodes$Id, Target %in% nodes$Id)

# Conferência final

cat("Nós:",     nrow(nodes), "\n")   # IG: 111  | TT: 47
cat("Arestas:", nrow(edges), "\n")   # IG: 2256 | TT: 430

# --- Exportação para o Gephi ---------------------------------
write.csv(nodes, "data/nodes_instagram.csv", row.names = FALSE)
write.csv(edges, "data/edges_instagram.csv", row.names = FALSE)





