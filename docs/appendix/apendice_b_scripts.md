# Apêndice B — Scripts em R (implementação original)

> **Nota.** Este apêndice preserva a implementação original tal como descrita no
> documento metodológico, para fins de auditoria e de comparação. Os scripts
> **em uso** estão em [`../../scripts/`](../../scripts/), modularizados e com
> duas correções documentadas no [CHANGELOG](../../CHANGELOG.md):
>
> 1. **`sort()` aplicado ao par antes de `combn()`** (B.11), eliminando a
>    duplicação recíproca de arestas — 2.256 linhas para 1.569 pares únicos no
>    arquivo do Instagram. A correção é recomendada pelo próprio documento
>    metodológico (§8.3).
> 2. **Resolução do dicionário por lookup em ambiente hash** em vez de `filter()`
>    dentro do laço (B.8) — resultado idêntico, execução ordens de grandeza mais
>    rápida.
>
> Os caminhos de pasta foram anonimizados para `caminho/do/projeto/`; na versão
> versionada todos os caminhos vêm de `scripts/00_config.R`.

---

Implementação de referência do pipeline, do dado bruto aos arquivos do Gephi. O código abaixo é o do Instagram; o TikTok seguiu exatamente os mesmos princípios e funções, alterando-se apenas (i) o arquivo de entrada e (ii) o índice da coluna de hashtags — coluna AD no TikTok, em vez da coluna S (índice 19) do Instagram. Os caminhos de pasta foram anonimizados para `caminho/do/projeto/`.

### B.1 — Instalação e carregamento dos pacotes

```r
install.packages(c(
  "readxl", "dplyr", "tidyr", "stringr",
  "purrr", "igraph", "writexl", "openxlsx"
))
 
library(readxl);  library(dplyr);   library(tidyr)
library(stringr); library(purrr);   library(igraph)
library(writexl); library(openxlsx)
```

### B.2 — Abrir a planilha mestra

```r
dados <- read_excel(
  "caminho/do/projeto/dataset consolidado instagram.xlsx"
)
# TikTok: "caminho/do/projeto/dataset consolidado tiktok.xlsx"
```

### B.3 — Extrair todas as hashtags (coluna S = índice 19; no TikTok, a coluna AD)

```r
hashtags <- dados %>%
  select(tags = 19) %>%
  separate_rows(tags, sep = ",") %>%
  mutate(
    tags = str_trim(tags),
    tags = tolower(tags)
  ) %>%
  filter(!is.na(tags), tags != "")
```

### B.4 — Frequência das hashtags (contagem sobre ocorrências brutas)

```r
freq <- hashtags %>%
  count(tags, sort = TRUE)
 
print(freq, n = 100)
```

### B.5 — Cortes de frequência (≥ 3, ≥ 10, ≥ 20)

```r
freq3  <- freq %>% filter(n >= 3);   nrow(freq3)    # IG: 963   | TT: 425
freq10 <- freq %>% filter(n >= 10);  nrow(freq10)   # IG: 291   | TT: 103
freq20 <- freq %>% filter(n >= 20);  nrow(freq20)   # IG: 138   | TT: 51
```

### B.6 — Exportar frequências

```r
write.xlsx(
  freq,
  "caminho/do/projeto/frequencias_instagram.xlsx",
  overwrite = TRUE
)
```

### B.7 — Ler e padronizar o dicionário

```r
dic <- read_excel(
  "caminho/do/projeto/dicionario_instagram.xlsx"
)
 
dic <- dic %>%
  mutate(
    tags = str_trim(tolower(tags)),
    ação = str_trim(toupper(ação))
  )
```

### B.8 — Função de limpeza (remove R, substitui U, mantém M; deduplica por post)

```r
limpar_hashtags <- function(texto){
 
  if (is.na(texto) || texto == "") {
    return(NA_character_)
  }
 
  tags <- unlist(str_split(texto, ","))
  tags <- tags %>% str_trim() %>% tolower()
 
  resultado <- c()
 
  for (tag in tags) {
 
    linha <- dic %>% filter(tags == tag)
 
    # hashtag fora do dicionário: mantém (cauda longa)
    if (nrow(linha) == 0) {
      resultado <- c(resultado, tag); next
    }
 
    acao <- linha$ação[1]
 
    if (acao == "R") { next }                       # remove
    if (acao == "M") { resultado <- c(resultado, tag); next }  # mantém
    if (acao == "U") {                              # unifica
      resultado <- c(resultado, linha$`substituir por`[1])
    }
  }
 
  resultado <- unique(resultado)                    # deduplica por post
  paste(resultado, collapse = ",")
}
```

### B.9 — Criar a coluna de hashtags limpas e exportar a base limpa

```r
dados$hashtags_limpas <- map_chr(dados[[19]], limpar_hashtags)
 
write.xlsx(
  dados,
  "caminho/do/projeto/instagram_limpo.xlsx",
  overwrite = TRUE
)
```

### B.10 — Construção dos nós (a partir da coluna limpa)

```r
hashtags_limpas <- dados %>%
  select(tags = hashtags_limpas) %>%
  separate_rows(tags, sep = ",") %>%
  mutate(tags = str_trim(tags)) %>%
  filter(tags != "")
 
nodes <- hashtags_limpas %>%
  count(tags, sort = TRUE) %>%
  rename(Id = tags, Label = tags, Frequency = n)
```

### B.11 — Construção das arestas (coocorrência por par, com deduplicação por post)

```r
posts <- dados$hashtags_limpas
lista_edges <- list()
 
for (i in seq_along(posts)) {
 
  tags <- posts[i]
  if (is.na(tags) || tags == "") { next }
 
  tags <- str_split(tags, ",")[[1]]
  tags <- str_trim(tags)
  tags <- unique(tags)                 # deduplica por post
 
  if (length(tags) < 2) { next }
 
  pares <- t(combn(tags, 2))           # todos os pares
  lista_edges[[length(lista_edges) + 1]] <- as.data.frame(pares)
}
```

### B.12 — Consolidar arestas e pesos

```r
edges <- bind_rows(lista_edges)
names(edges) <- c("Source", "Target")
 
edges <- edges %>%
  count(Source, Target, name = "Weight") %>%
  arrange(desc(Weight))
```

### B.13 — Exportar arquivos do Gephi

```r
write.csv(nodes, "caminho/do/projeto/nodes_instagram.csv", row.names = FALSE)
write.csv(edges, "caminho/do/projeto/edges_instagram.csv", row.names = FALSE)
```

### B.14 — Conferência final

```r
cat("Nós:",     nrow(nodes), "\n")   # IG: 111  | TT: 47
cat("Arestas:", nrow(edges), "\n")   # IG: 2256 | TT: 430
```

### B.15 — Estatísticas descritivas do corpus (para a metodologia)

```r
# total de ocorrências de hashtags (brutas)
total_hashtags <- dados %>%
  select(hashtags = 19) %>%
  separate_rows(hashtags, sep = ",") %>%
  mutate(hashtags = str_trim(hashtags)) %>%
  filter(!is.na(hashtags), hashtags != "") %>%
  nrow()
total_hashtags                       # IG: 21812 | TT: 9149
 
# posts com e sem hashtags
dados %>%
  summarise(
    total_posts = n(),
    com_hashtag = sum(!is.na(.[[19]]) & .[[19]] != ""),
    sem_hashtag = sum( is.na(.[[19]]) | .[[19]] == "")
  )                                  # IG: 3611 / 3126 / 485 | TT: 1957 / 1737 / 220
```

### B.16 — Disparity filter (espinha dorsal da rede para visualização)

```r
Implementação direta do disparity filter (Serrano, Boguñá & Vespignani, 2009) com igraph, a partir do nodes/edges já gerados (B.10–B.12). Mantém a aresta se ela for significativa (α < limiar) para pelo menos um dos extremos.
library(igraph)
 
# grafo não-direcionado ponderado a partir das arestas canônicas
g <- graph_from_data_frame(
  d = edges[, c("Source", "Target", "Weight")],
  directed = FALSE,
  vertices = nodes[, c("Id", "Label", "Frequency")]
)
 
disparity_backbone <- function(g, alpha = 0.10) {
  w   <- E(g)$Weight
  el  <- ends(g, E(g), names = FALSE)        # índices dos extremos de cada aresta
  str <- strength(g, weights = w)            # força (soma de pesos) por nó
  deg <- degree(g)                           # grau (nº de vizinhos) por nó
 
  # significância da aresta vista de cada extremo: alpha = (1 - p)^(k - 1)
  alpha_de <- function(node, w_e) {
    k <- deg[node]; s <- str[node]
    if (k <= 1 || s == 0) return(1)          # nós de grau 1 não filtram
    p <- w_e / s
    (1 - p)^(k - 1)
  }
 
  a_i <- mapply(alpha_de, el[, 1], w)
  a_j <- mapply(alpha_de, el[, 2], w)
  keep <- pmin(a_i, a_j) < alpha             # união: significativa em ao menos 1 extremo
 
  h <- subgraph.edges(g, E(g)[keep], delete.vertices = TRUE)
 
  # manter apenas o componente principal
  comp <- components(h)
  h <- induced_subgraph(h, which(comp$membership == which.max(comp$csize)))
  h
}
 
bb <- disparity_backbone(g, alpha = 0.10)
cat("Backbone:", vcount(bb), "nós,", ecount(bb), "arestas,",
    "densidade", round(edge_density(bb), 3), "\n")
# IG (alpha<0.10): 88 nós, 273 arestas, densidade 0.071
```

### B.17 — Exportar a espinha dorsal para o Gephi

```r
bb_nodes <- data.frame(
  Id        = V(bb)$name,
  Label     = V(bb)$name,
  Frequency = V(bb)$Frequency
)
bb_edges <- as_data_frame(bb, what = "edges")
names(bb_edges)[1:2] <- c("Source", "Target")
bb_edges$Type <- "Undirected"
 
write.csv(bb_nodes, "caminho/do/projeto/nodes_instagram_backbone.csv", row.names = FALSE)
write.csv(bb_edges, "caminho/do/projeto/edges_instagram_backbone.csv", row.names = FALSE)
```

**Alternativa sem código:** o mesmo resultado é obtido no Gephi pelo plugin Disparity (menu Statistics → Disparity), seguido de um filtro alpha < 0.10 em Filters → Edges. Para reprodutibilidade exata, recomenda-se o script acima. Alternativa em R com pacote pronto: o pacote backbone oferece disparity() com saída equivalente — útil para checagem cruzada da implementação manual.

---

**Referência do método de backbone:** Serrano, M. Á., Boguñá, M., & Vespignani, A. (2009). Extracting the multiscale backbone of complex weighted networks. Proceedings of the National Academy of Sciences, 106(16), 6483–6488.

