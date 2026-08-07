# Apêndice A — Inventário de arquivos do estudo

## Coleta (ambas as plataformas)

Zeeschuimer + 4CAT · contas novas criadas para a coleta · sementes
`estelionato`, `estelionatario`, `raul`, `happynation`, `tropado7`, `171` · sem
filtro de data · `Notas_metodológicas.docx`.

## Dimensão etnográfica

Acervo de **130 publicações** salvas do Instagram (maio–setembro de 2025):
81 estelionato · 30 furto simples · 19 roubo mediante violência ou grave ameaça.

Observação não participante via conta sem histórico, a partir da aba "Explorar";
nomes de usuário e IDs anonimizados/omitidos.

## Instagram

| Arquivo | Conteúdo |
|---|---|
| `dataset_consolidado_instagram.xlsx` | Base mestra, 3.611 publicações |
| `frequencia3_instagram.csv` | Tabela de frequência completa (5.048 tags) |
| `hashtags_freq10.csv` | Candidatas à codificação (291) |
| `hashtags_freq20.csv` | Corte ≥ 20 (138) |
| `dicionario_instagram.xlsx` | Dicionário M/U/R codificado manualmente |
| `dataset_consolidado_instagram_limpo.csv` | Base com hashtags limpas |
| `nodes_instagram.csv` | 111 nós |
| `edges_instagram.csv` | 2.256 linhas / 1.569 pares únicos |

## TikTok

| Arquivo | Conteúdo |
|---|---|
| `dataset_consolidado_tiktok.xlsx` | Base mestra, 1.957 publicações, 36 colunas |
| `frequencias_tiktok.xlsx` | Tabela de frequência completa (2.967 tags) |
| `dicionario_tiktok_preliminar.xlsx` | Codificação semiautomática |
| `dicionario_tiktok_revisado.xlsx` | Após validação humana |
| `tiktok_limpo.xlsx` | Base com hashtags limpas |
| `nodes_tiktok.csv` | 47 nós |
| `edges_tiktok.csv` | 430 arestas |

## Rede combinada

`rede_combinada_instagram_tiktok.xlsx` — documenta o procedimento de união e
normalização por corpus (117 nós, 1.690 arestas).

## Código

Apêndice B: scripts em R — instalação → leitura → frequências → dicionário →
limpeza → nós/arestas → exportação Gephi → disparity filter/backbone.

## Nota de reprodutibilidade

A tabela de frequências e os cortes (≥3/≥10/≥20) são contados sobre **ocorrências
brutas** (sem deduplicação intra-post), como no script R. A deduplicação por post
é aplicada apenas na limpeza e na rede, de modo que a frequência dos nós e as
arestas refletem **presença-por-post**.

As redes operam sobre o vocabulário codificado (n ≥ 10) após M/U/R. As arestas
são não-direcionadas — recomenda-se ordenar o par antes do `combn` para evitar a
duplicação recíproca observada no arquivo do Instagram (correção já aplicada em
`scripts/05_construir_rede.R`).

Os caminhos de pasta nos scripts originais foram anonimizados
(`caminho/do/projeto/`); na versão versionada, todos os caminhos vêm de
`scripts/00_config.R`.
