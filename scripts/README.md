# `/scripts` — Pipeline em R

Implementação de referência do pipeline, do dado bruto aos arquivos do Gephi.
Deriva do Apêndice B do documento metodológico, modularizado e com duas
correções documentadas (ver [CHANGELOG](../CHANGELOG.md)).

## Ordem de execução

```r
# a partir da raiz do repositório
source("scripts/run_all.R")
```

| Script | Faz | Entrada | Saída | Apêndice B |
|---|---|---|---|---|
| `00_config.R` | Caminhos, parâmetros, valores esperados | — | constantes | — |
| `01_setup.R` | Instala e carrega pacotes | — | — | B.1 |
| `02_extracao_frequencias.R` | Desmembra, normaliza e conta hashtags | `data/raw/*.xlsx` | `frequencias_*.xlsx` | B.2–B.6, B.15 |
| `03_cortes_frequencia.R` | Aplica limiares ≥3/≥10/≥20 e gera a planilha de codificação | frequências | `hashtags_freq*.csv` | B.5 |
| **(humano)** | **Codificação M/U/R** | `hashtags_freq10_*.csv` | `dictionaries/dicionario_*.xlsx` | — |
| `04_aplicar_dicionario.R` | Remove R, substitui U, mantém M, deduplica | base + dicionário | `*_limpo.xlsx` | B.7–B.9 |
| `05_construir_rede.R` | Gera nós e arestas | base limpa | `nodes_*.csv`, `edges_*.csv` | B.10–B.14 |
| `06_disparity_filter.R` | Extrai a espinha dorsal | nós + arestas | `*_backbone.csv` | B.16–B.17 |
| `07_metricas_rede.R` | Métricas da **rede completa** | nós + arestas | `metricas_*.csv` | — |
| `08_rede_combinada.R` | Une as duas redes com rótulo de origem | ambas as redes | `*_rede_combinada.csv` | — |
| `99_anonimizar.R` | Remove identificadores antes de publicar | `data/raw/*.xlsx` | `*_anon.xlsx` | — |

## Todos os parâmetros vivem em `00_config.R`

Nenhum outro script contém caminho absoluto ou número mágico. Para mudar um
limiar, altere **uma linha** de `00_config.R`:

```r
LIMIAR_CODIFICACAO   <- 10     # corte para a codificação M/U/R
ALPHA_DISPARITY      <- 0.10   # limiar do disparity filter
CORTE_PESO_FIGURA_IG <- 7      # corte de legibilidade, só Instagram
RESOLUCAO_MODULARITY <- 1.0    # resolução do algoritmo de comunidades
```

`00_config.R` também guarda os **valores esperados** de cada etapa (nº de posts,
ocorrências, nós, arestas, backbone). Os scripts comparam o resultado obtido com
esses valores e emitem `OK` ou `DIVERGE` — funcionando como teste de regressão
do pipeline.

## Duas correções em relação ao Apêndice B

**1. Ordenação do par antes do `combn` (`05_construir_rede.R`).** O script
original chamava `combn(tags, 2)` sem ordenar as tags, o que fez o arquivo do
Instagram registrar a mesma relação não-direcionada em duas linhas — 2.256 linhas
para 1.569 pares únicos. A correção é a recomendada pelo próprio documento
metodológico (§8.3). Como o grafo é não-direcionado, a leitura analítica não se
altera: no Gephi os pares recíprocos seriam fundidos de qualquer modo.

Para auditar a equivalência com o arquivo histórico:

```r
edges_original <- gerar_arestas(posts, vocab, canonizar = FALSE)  # 2.256 linhas
edges_corrigido <- gerar_arestas(posts, vocab, canonizar = TRUE)  # 1.569 linhas
```

**2. Lookup em hash em vez de `filter()` no laço (`04_aplicar_dicionario.R`).**
A implementação original filtrava o dicionário inteiro para cada hashtag de cada
post — O(n·m). A versão atual resolve por ambiente hash. Resultado idêntico,
execução ordens de grandeza mais rápida.

## Requisitos

R ≥ 4.2 · `readxl`, `dplyr`, `tidyr`, `stringr`, `purrr`, `igraph`, `writexl`,
`openxlsx`

Registre a saída de `sessionInfo()` (impressa ao final de `run_all.R`) junto com
os resultados publicados.
