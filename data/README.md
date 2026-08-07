# `/data` — Dados e proveniência

> ⚠️ **Antes de commitar qualquer coisa aqui, leia [ETHICS.md](../ETHICS.md) e
> execute `scripts/99_anonimizar.R`.** Dado publicado por engano permanece no
> histórico do Git.

## Organização

| Subpasta | Conteúdo | Gerado por |
|---|---|---|
| `raw/` | Bases mestras consolidadas (6 planilhas → 1 por plataforma) | Coleta (Zeeschuimer + 4CAT) + consolidação manual |
| `processed/` | Frequências, cortes, bases limpas, métricas | `02`, `03`, `04`, `07` |
| `network/` | Nós e arestas para o Gephi | `05`, `06`, `08` |

## Arquivos esperados

### `raw/`

| Arquivo | Descrição | Linhas |
|---|---|---|
| `dataset_consolidado_instagram.xlsx` | Base mestra do Instagram; legenda na coluna G, hashtags na coluna S | 3.611 |
| `dataset_consolidado_tiktok.xlsx` | Base mestra do TikTok; legenda na coluna I (`body`), hashtags na coluna AD (`hashtags`), 36 colunas de metadados | 1.957 |

**Proveniência.** Cada base resulta da consolidação de **6 planilhas de entrada**,
uma por hashtag-semente (`estelionato`, `estelionatario`, `raul`, `happynation`,
`tropado7`, `171`), coletadas com Zeeschuimer + 4CAT a partir de contas novas,
sem filtro de datas. Ver README §3.1–3.2.

### `processed/`

| Arquivo | Descrição |
|---|---|
| `frequencias_<plataforma>.xlsx` | Contagem por **ocorrência bruta** (sem deduplicação intra-post) |
| `hashtags_freq{3,10,20}_<plataforma>.csv` | Recortes por limiar de frequência |
| `resumo_corpus_<plataforma>.csv` | Estatísticas descritivas do corpus |
| `<plataforma>_limpo.xlsx` | Base com `hashtags_original` preservada e `hashtags_limpas` criada |
| `metricas_rede_<plataforma>.csv` | Indicadores da rede completa |
| `metricas_nos_<plataforma>.csv` | Degree, Weighted Degree, Modularity Class por nó |

### `network/`

| Arquivo | Descrição |
|---|---|
| `nodes_<plataforma>.csv` | Nós da rede completa |
| `edges_<plataforma>.csv` | Arestas da rede completa (canônicas e únicas) |
| `nodes_<plataforma>_backbone.csv` | Nós da espinha dorsal (disparity filter α < 0,10) |
| `edges_<plataforma>_backbone.csv` | Arestas da espinha dorsal |
| `nodes_instagram_figura.csv` | Backbone + corte de peso ≥ 7 (**só Instagram, só renderização**) |
| `edges_instagram_figura.csv` | idem |
| `nodes_rede_combinada.csv` | Rede combinada com atributo `origem` |
| `edges_rede_combinada.csv` | idem |
| `legacy/edges_instagram_2256linhas.csv` | Arquivo histórico com duplicação recíproca, para auditoria |

## Esquemas

### `nodes_<plataforma>.csv`

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | string | Hashtag na forma canônica. **Chave primária.** |
| `Label` | string | Idêntico a `Id`; rótulo exibido no Gephi |
| `Frequency` | int | Nº de publicações em que a hashtag aparece (**presença-por-post**, não ocorrência bruta) |

### `edges_<plataforma>.csv`

| Coluna | Tipo | Descrição |
|---|---|---|
| `Source` | string | Hashtag A → referencia `nodes.Id` |
| `Target` | string | Hashtag B → referencia `nodes.Id` |
| `Weight` | int | Nº de publicações em que A e B coocorrem |
| `Type` | string | Sempre `Undirected` |

### `nodes_rede_combinada.csv` / `edges_rede_combinada.csv`

Colunas adicionais:

| Coluna | Descrição |
|---|---|
| `origem` | `ambas` · `instagram` · `tiktok` — governa a cor da figura |
| `freq_ig`, `freq_tt` | Frequências absolutas em cada plataforma |
| `freq_rel_ig`, `freq_rel_tt` | Frequências como % das publicações de cada base |
| `w_ig`, `w_tt` | Pesos absolutos em cada plataforma |
| `w_rel_ig`, `w_rel_tt` | Coocorrências por 1.000 publicações de cada base |
| `Weight` / `Frequency` | Média das métricas **relativas** (ver README §3.9) |

## Três armadilhas de leitura

**1. Frequência bruta ≠ frequência do nó.** A tabela de frequências conta
ocorrências brutas; o atributo `Frequency` do nó conta presença-por-post e
incorpora as unificações. Por isso `fyp` como nó agrega `fy`, `foryou`, `fypシ`,
`foryourpage` etc., e os números divergem. Ver README §3.4.

**2. A coluna limpa preserva a cauda longa; a rede não.** `hashtags_limpas`
mantém hashtags com n < 10 que não constam do dicionário. A restrição ao
vocabulário codificado ocorre só na construção da rede. Ver README §3.6.

**3. Métricas vêm da rede completa, figuras vêm do backbone.** Nunca reporte
densidade, modularidade ou centralidade a partir dos arquivos `_backbone` ou
`_figura`. Ver README §3.8.
