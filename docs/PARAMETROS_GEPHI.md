# Parâmetros do Gephi — registro completo

Documento de replicação exata. Toda decisão de visualização registrada aqui é
uma decisão de método, não de estética, e deve ser reportada no artigo.

## 0. Regra que governa tudo o mais

> **A espinha dorsal é para VER. A rede completa é para MEDIR.**
>
> Todas as métricas reportadas (densidade, modularidade, grau, grau ponderado,
> centralidade) são calculadas sobre a **rede completa**. A espinha dorsal e o
> corte de peso servem exclusivamente à legibilidade das figuras.

## 1. Importação

| Passo | Configuração |
|---|---|
| Nodes Table | `data/network/nodes_<plataforma>_backbone.csv` |
| Edges Table | `data/network/edges_<plataforma>_backbone.csv` |
| Tipo de grafo | **Undirected** |
| Estratégia de arestas | Sum (irrelevante se os arquivos já são canônicos) |

O grafo é não-direcionado porque a coocorrência é simétrica por natureza: A
coocorre com B se e somente se B coocorre com A.

## 2. Extração da espinha dorsal

| Parâmetro | Valor |
|---|---|
| Método | Disparity filter (Serrano, Boguñá & Vespignani, 2009) |
| α | **0,10** |
| Critério de retenção | Aresta significativa para **pelo menos um** dos extremos |
| Pós-processamento | Manter apenas o componente principal |

Dois caminhos equivalentes:

- **R (recomendado, exato):** `scripts/06_disparity_filter.R`
- **Gephi:** plugin *Disparity* → `Statistics → Disparity`, depois
  `Filters → Edges → alpha < 0.10`

Checagem cruzada opcional: o pacote R `backbone` oferece `disparity()` com saída
equivalente.

### Corte adicional de peso — só Instagram

| Item | Valor |
|---|---|
| Filtro | `Edge Weight ≥ 7` |
| Aplicado a | **Instagram apenas** |
| Motivo | Emaranhado visual residual após o disparity filter |
| Impacto | −1 nó (`digital`), −5 arestas (de 88/273 para 87/268) |
| Afeta as métricas? | **Não.** Densidade, nº de comunidades e partição inalterados |

O TikTok, por ser menor, não exigiu esse passo. A assimetria decorre de diferença
real de tamanho entre os corpora, não de inconsistência de método — e é declarada
explicitamente no artigo e na legenda da figura.

## 3. ForceAtlas2

Layout dirigido por forças: nós que coocorrem com frequência (arestas de peso
alto) se atraem; nós sem ligação se repelem. O resultado espacial faz emergir
visualmente os agrupamentos.

| Parâmetro | Instagram | TikTok | Por quê |
|---|---|---|---|
| **LinLog mode** | ✅ | ✅ | Acentua a separação entre comunidades |
| **Dissuade Hubs** | ✅ | ✅ | Evita que os hubs onipresentes dominem o centro |
| **Prevent Overlap** | ✅ | ✅ | Impede sobreposição de nós |
| **Edge Weights invertidos** | ✅ | ✅ | Impede que as arestas mais pesadas colapsem o grafo |
| Scaling | 20 | 50 | Ajustado ao tamanho de cada rede |
| Gravity | 0,8 | 1,0 | Coesão do grafo |
| Barnes-Hut θ | 0,5 | 1,2 | Precisão vs. velocidade da aproximação |
| Approximate Repulsion | ✅ | — | Necessário só na rede maior |

**Critério de parada:** deixar convergir até a **estabilização visual dos nós** —
não há número fixo de iterações. Registre o tempo aproximado de convergência ao
reportar.

## 4. Estatísticas

| Métrica | Configuração |
|---|---|
| Modularity | Resolução **1,0** |
| Average Degree | padrão |
| Average Weighted Degree | padrão |
| Network Diameter | opcional |

**Nota sobre estabilidade.** O algoritmo de Modularity é estocástico e o número
de comunidades é sensível à resolução. Com resolução 1,0 e execuções repetidas, a
partição em **3 comunidades mostrou-se estável em ambas as redes**. O script
`07_metricas_rede.R` executa 20 repetições e reporta média, desvio-padrão e
amplitude do nº de comunidades — reporte esses valores no artigo.

## 5. Aparência

| Elemento | Codificação | Justificativa |
|---|---|---|
| Tamanho do nó | Ranking por `Frequency` | Comunica de imediato as hashtags dominantes |
| Cor do nó | Partition por `Modularity Class` | Torna visível a segmentação temática |
| Espessura da aresta | Ranking por `Weight` | Destaca as associações mais sistemáticas |
| **Rótulos** | **Tamanho uniforme** | Para que o vocabulário técnico-jurídico de baixa frequência (`pix`, `golpedopix`, `consultavel`, `advocaciacriminal`) permaneça legível e seu cluster não seja visualmente apagado |

A decisão sobre os rótulos é substantiva, não cosmética: rótulos proporcionais ao
nó tornariam invisível justamente o vocabulário mais especializado do golpe — o
que produziria uma leitura empobrecida da rede.

## 6. Convenção de cores

**Redes individuais** — cor = comunidade temática:

| Cor | Eixo |
|---|---|
| 🟠 Laranja | Criminal-jurídico-financeiro |
| 🟣 Roxo | Viralização |
| 🟢 Verde | Estilo de vida / enriquecimento |

**Rede combinada** — cor = origem do nó:

| Cor | Origem |
|---|---|
| 🔵 Azul-claro | Presente em ambas |
| ⚪ Cinza | Só Instagram |
| 🟢 Verde | Só TikTok |

⚠️ O verde muda de sentido entre os dois esquemas. Cada figura precisa de legenda
própria.

## 7. Exportação

| Formato | Uso | Configuração |
|---|---|---|
| `.svg` / `.pdf` | Submissão a journal | Preview → Export |
| `.png` | Rascunho e apresentações | ≥ 600 dpi |
| `.gephi` | Reabrir e reeditar | salvar em `figures/gephi/` |

No painel **Preview**: ativar `Show Labels`, `Proportional size` **desligado**
para os rótulos, opacidade das arestas ~60% para não obscurecer os nós.

## 8. Valores de referência para conferência

| Rede | Nós (completa) | Arestas (completa) | Densidade | Nós (backbone) | Arestas (backbone) | Comunidades | Q |
|---|---|---|---|---|---|---|---|
| Instagram | 111 | 1.569¹ | 0,262 | 88 (87)² | 273 (268)² | 3 | 0,329 |
| TikTok | 47 | 430 | 0,415 | 40 | 86 | 3 | 0,148 |
| Combinada | 117 | 1.690 | — | n/a³ | n/a³ | — | — |

¹ Pares não-direcionados únicos; o arquivo histórico tem 2.256 linhas por
duplicação recíproca.
² Entre parênteses, após o corte adicional de peso ≥ 7 aplicado só ao Instagram.
³ A rede combinada não usa backbone: seu propósito é mapear sobreposição de
vocabulário, não extrair espinha dorsal.
