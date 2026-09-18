# Redes de coocorrência de hashtags no ecossistema discursivo do estelionato

**Instagram e TikTok · mapeamento comparado do discurso do crime financeiro digital**

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)


> 🇬🇧 An English version of this README is available at **[README.en.md](README.en.md)**.

Este repositório é o ambiente de versionamento, documentação e reprodução da pesquisa que mapeia e compara os ecossistemas discursivos associados ao estelionato, aos golpes financeiros, à monetização ilícita e às estratégias de viralização no **Instagram** e no **TikTok**, por meio de **redes de coocorrência de hashtags**.

Ele reúne os dados, os scripts em R, os dicionários de codificação, as figuras e a memória metodológica completa que sustentam o artigo internacional e o capítulo de livro derivados do projeto.

---

## Sumário

- [1. O que este repositório contém](#1-o-que-este-repositório-contém)
- [2. Estrutura de diretórios](#2-estrutura-de-diretórios)
- [3. Fluxo metodológico](#3-fluxo-metodológico)
  - [3.1 Coleta](#31-coleta)
  - [3.2 Consolidação](#32-consolidação)
  - [3.3 Inspeção e auditoria](#33-inspeção-e-auditoria)
  - [3.4 Extração e frequências](#34-extração-e-frequências)
  - [3.5 Dicionários analíticos (M/U/R)](#35-dicionários-analíticos-mur)
  - [3.6 Limpeza](#36-limpeza)
  - [3.7 Construção das redes](#37-construção-das-redes)
  - [3.8 Espinha dorsal e visualização](#38-espinha-dorsal-e-visualização)
  - [3.9 Rede combinada](#39-rede-combinada)
- [4. Como reproduzir](#4-como-reproduzir)
- [5. Resultados principais](#5-resultados-principais)
- [6. Dimensão etnográfica complementar](#6-dimensão-etnográfica-complementar)
- [7. Limitações e ressalvas](#7-limitações-e-ressalvas)
- [8. Ética e proteção de dados](#8-ética-e-proteção-de-dados)
- [9. Dicionário de dados](#9-dicionário-de-dados)
- [10. Como citar](#10-como-citar)
- [11. Referências](#11-referências)
- [12. Equipe e contato](#12-equipe-e-contato)

---

## 1. O que este repositório contém

| Componente | Onde está | Estado |
|---|---|---|
| Documentação metodológica completa | [`docs/documento_metodologico_integrado.md`](docs/) | ✅ |
| Scripts em R do pipeline (bruto → Gephi) | [`scripts/`](scripts/) | ✅ |
| Dicionários de codificação M/U/R | [`dictionaries/`](dictionaries/) | ⬜ a depositar |
| Bases mestras e planilhas intermediárias | [`data/`](data/) | ⬜ a depositar |
| Arquivos de nós e arestas para o Gephi | [`data/network/`](data/network/) | ⬜ a depositar |
| Figuras das redes (Gephi) | [`figures/`](figures/) | ⬜ a depositar |

> ⬜ = diretório e documentação já preparados; os arquivos devem ser copiados pela equipe. Cada pasta tem um `README.md` local com a lista exata dos arquivos esperados e seus nomes canônicos.

**Princípio orientador:** todo número reportado no artigo e no capítulo deve ser rastreável até um arquivo deste repositório e até a linha de script que o produziu.

---

## 2. Estrutura de diretórios

```
.
├── README.md                  ← este arquivo (fluxo metodológico completo)
├── README.en.md               ← versão em inglês
├── CITATION.cff               ← metadados de citação (lidos pelo GitHub e pelo Zenodo)
├── .zenodo.json               ← metadados do depósito Zenodo (DOI por release)
├── LICENSE                    ← licença (a definir)
├── ETHICS.md                  ← protocolo ético e de anonimização
├── CHANGELOG.md               ← histórico de versões / releases
├── .gitignore
│
├── data/
│   ├── README.md              ← dicionário de dados e proveniência
│   ├── raw/                   ← bases mestras consolidadas (6 planilhas → 1 por plataforma)
│   ├── processed/             ← frequências, cortes, bases limpas
│   └── network/               ← nodes_*.csv / edges_*.csv (entrada do Gephi)
│
├── scripts/
│   ├── README.md              ← ordem de execução e dependências
│   ├── 00_config.R            ← caminhos, parâmetros e constantes do projeto
│   ├── 01_setup.R             ← instalação e carregamento de pacotes
│   ├── 02_extracao_frequencias.R
│   ├── 03_cortes_frequencia.R
│   ├── 04_aplicar_dicionario.R
│   ├── 05_construir_rede.R
│   ├── 06_disparity_filter.R
│   ├── 07_metricas_rede.R
│   ├── 08_rede_combinada.R
│   ├── 99_anonimizar.R        ← remoção de autoria/IDs antes de publicar dados
│   └── run_all.R              ← executa o pipeline completo end-to-end
│
├── dictionaries/
│   ├── README.md              ← esquema das colunas e critérios de codificação
│   ├── dicionario_instagram.xlsx
│   ├── dicionario_tiktok_preliminar.xlsx
│   └── dicionario_tiktok_revisado.xlsx
│
├── figures/
│   ├── README.md              ← legendas, convenções de cor e parâmetros do Gephi
│   ├── fig01_rede_instagram_backbone.png
│   ├── fig02_rede_tiktok_backbone.png
│   ├── fig03_rede_combinada.png
│   └── gephi/                 ← projetos .gephi para reabrir as visualizações
│
└── docs/
    ├── documento_metodologico_integrado.md   ← memória metodológica (12 seções)
    ├── documento_metodologico_integrado.pdf  ← versão para depósito no Zenodo
    ├── PARAMETROS_GEPHI.md                   ← todos os parâmetros de layout e filtro
    └── appendix/
        ├── apendice_a_inventario_arquivos.md
        └── apendice_b_scripts.md
```

---

## 3. Fluxo metodológico

O desenho é **espelhado**: o procedimento desenvolvido para o Instagram foi reproduzido integralmente para o TikTok — mesmos limiares, mesmas categorias de codificação, mesma lógica de construção de rede — ajustando-se apenas o que era estritamente imposto pelas diferenças de estrutura das bases. Isso garante que as diferenças observadas entre as redes finais reflitam diferenças reais entre as plataformas, e não artefatos de método.

```
┌─────────────┐   ┌───────────────┐   ┌──────────┐   ┌────────────┐
│  1. Coleta  │ → │2. Consolidação│ → │3. Inspeção│ → │4. Extração │
│ Zeeschuimer │   │ 6 planilhas → │   │ auditoria │   │ + contagem │
│   + 4CAT    │   │  base mestra  │   │ de sujeira│   │ de frequên.│
└─────────────┘   └───────────────┘   └──────────┘   └─────┬──────┘
                                                            │
        ┌───────────────────────────────────────────────────┘
        ▼
┌──────────────┐   ┌────────────┐   ┌──────────────┐   ┌──────────────┐
│ 5. Corte n≥10│ → │6. Dicionár.│ → │  7. Limpeza  │ → │ 8. Rede      │
│              │   │   M/U/R    │   │  R/U/M+dedup │   │ nós+arestas  │
└──────────────┘   └────────────┘   └──────────────┘   └──────┬───────┘
                                                              │
        ┌─────────────────────────────────────────────────────┘
        ▼
┌──────────────────────┐   ┌───────────────────┐   ┌──────────────────┐
│ 9. Disparity filter  │ → │ 10. Gephi         │ → │ 11. Comparação   │
│  backbone (α < 0,10) │   │ ForceAtlas2 +     │   │  + rede combinada│
│  só para visualizar  │   │ Modularity + grau │   │                  │
└──────────────────────┘   └───────────────────┘   └──────────────────┘
```

### 3.1 Coleta

Instrumentação **idêntica** nas duas plataformas — condição da comparabilidade.

- **Ferramenta:** extensão [Zeeschuimer](https://github.com/digitalmethodsinitiative/zeeschuimer) conectada ao [4CAT](https://github.com/digitalmethodsinitiative/4cat) (Capture and Analysis Toolkit), capturando as publicações diretamente da navegação.
- **Contas:** criadas **novas** no TikTok e no Instagram especificamente para a coleta, para evitar personalização algorítmica do feed por históricos preexistentes.
- **Hashtags-semente (6, comuns às duas plataformas):**
  `#estelionato` · `#estelionatario` · `#raul` · `#happynation` · `#tropado7` · `#171`
- **Filtro de datas:** nenhum. As plataformas não permitem essa opção na busca por hashtag. O corpus é, portanto, um recorte do material disponível no momento da captura, **sem janela temporal controlada**.
- **Exclusão deliberada:** `#bigode` foi retirada do conjunto de sementes — os posts recuperados por ela se afastavam do objeto (referiam-se majoritariamente a pelos faciais). Note-se que `bigode` **permanece como nó** nas redes finais, não como semente, mas como hashtag interna às publicações, onde designa a persona "Raul Bigode".
- **Meta:** ~500 posts por hashtag. **Atingida no Instagram; não atingida no TikTok**, por restrições de paginação/raspagem da plataforma. Essa é a origem direta da assimetria de tamanho entre os corpora (ver [§7](#7-limitações-e-ressalvas)).

### 3.2 Consolidação

As **6 planilhas de entrada** (uma por semente) foram consolidadas, em cada plataforma, em uma **base mestra única**, eliminando a fragmentação por hashtag de busca.

| Dimensão | Instagram | TikTok |
|---|---|---|
| Ferramenta de coleta | Zeeschuimer + 4CAT | Zeeschuimer + 4CAT |
| Contas utilizadas | novas, criadas para a coleta | novas, criadas para a coleta |
| Hashtags-semente | as 6 sementes | as mesmas 6 sementes |
| Filtro de datas | nenhum (não permitido) | nenhum (não permitido) |
| Meta por hashtag | ~500 posts (**atingida**) | ~500 posts (**não atingida**) |
| Planilhas de entrada | 6 (uma por semente) | 6 (uma por semente) |
| Base mestra | `dataset_consolidado_instagram.xlsx` | `dataset_consolidado_tiktok.xlsx` |
| **Publicações totais** | **3.611** | **1.957** |
| Coluna de legenda | G | I (`body`) |
| Coluna de hashtags | S (índice 19) | AD (`hashtags`) |

### 3.3 Inspeção e auditoria

Em ambas as plataformas as hashtags estão armazenadas como **lista separada por vírgulas dentro de uma única célula por publicação**, predominantemente em minúsculas e sem o caractere `#`. Essa convergência de formato é o que torna o tratamento espelhado viável.

Problemas identificados e seu tratamento:

| Problema | Ocorrência | Tratamento | Etapa |
|---|---|---|---|
| Publicações sem hashtag | IG: 485 / TT: 220 (11,2%) | Mantidos no corpus; excluídos da rede | Extração |
| Duplicação interna | TT: 62 posts (ex.: `viral,viral,paineldo7`) | Deduplicação por presença dentro do post | Extração |
| Emojis anexados | TT: 164 posts (`fypシ`, `dinheiroonline💰`) | Unificação à forma textual limpa | Dicionário (U) |
| Maiúsculas | TT: 5 posts | Conversão a minúsculas (`tolower()`) | Normalização |
| Variantes ortográficas/idiomáticas | `dinheiro`/`money`, `fouryou` | Unificação a forma canônica | Dicionário (U) |
| Alongamentos | `fyppppppppppppppppppppppp` (39×), `paratiiii…` (21×) | Unificação à forma base | Dicionário (U) |

> **Achado desta etapa:** os dois corpora compartilham os mesmos modos de "sujeira". Isso é, em si, um resultado — as práticas de etiquetagem nas duas plataformas seguem gramáticas semelhantes de viralização (alongar `fyp`, decorar com emojis, repetir o apelo ao algoritmo).

### 3.4 Extração e frequências

Script: [`scripts/02_extracao_frequencias.R`](scripts/02_extracao_frequencias.R)

1. Seleciona a coluna de hashtags e a desmembra com `separate_rows(sep = ",")` — uma linha por ocorrência.
2. Normaliza: `str_trim()` + `tolower()`.
3. Descarta tokens vazios ou `NA`.
4. Conta com `count(tags)`.

> ⚠️ **Ponto metodológico essencial.** Nesta etapa a frequência é contada por **ocorrência bruta**, não por presença no post: uma hashtag repetida dentro do mesmo post é contada mais de uma vez. A deduplicação intra-post só ocorre depois, em dois momentos — (i) na função de limpeza (`unique()` sobre as hashtags resolvidas de cada post) e (ii) na construção da rede (`unique()` antes de gerar os pares). **Por isso a frequência de uma hashtag na tabela de frequências é, em geral, ligeiramente superior à sua frequência como nó.**

| Métrica | Instagram | TikTok |
|---|---|---|
| Ocorrências brutas (contagem oficial) | 21.812 | 9.149 |
| Hashtags distintas | 5.048 | 2.967 |
| Publicações **com** hashtag | 3.126 | 1.737 |
| Publicações **sem** hashtag | 485 | 220 |
| Hashtags com n ≥ 3 | 963 | 425 |
| **Hashtags com n ≥ 10** | **291** | **103** |
| Hashtags com n ≥ 20 | 138 | 51 |

Topo das distribuições:

| # | Instagram (n) | TikTok (n) |
|---|---|---|
| 1 | `raul` (816) | `fyp` (520) |
| 2 | `estelionato` (576) | `estelionato` (349) |
| 3 | `happynation` (540) | `viral` (251) |
| 4 | `tropado7` (493) | `happynation` (240) |
| 5 | `171` (430) | `raul` (237) |

**Justificativa do limiar n ≥ 10.** Foram testados três pontos de corte (≥3, ≥10, ≥20). O limiar n ≥ 10 foi escolhido porque: (a) **preserva a diversidade temática** — não descarta campos semânticos relevantes de frequência moderada; (b) **elimina muito ruído** — remove a cauda longa de hashtags idiossincráticas, erros e termos de ocorrência única; (c) **mantém um conjunto administrável** — viabiliza a codificação manual, inviável com as 963/425 hashtags do corte ≥3. O efeito é comparável: o Instagram passa de 5.048 para 291 candidatas (5,8% do vocabulário) e o TikTok de 2.967 para 103 (3,5%).

### 3.5 Dicionários analíticos (M/U/R)

Diretório: [`dictionaries/`](dictionaries/)

As hashtags com n ≥ 10 foram exportadas e codificadas. No **Instagram**, a codificação foi **manual**, item a item. No **TikTok**, foi **semiautomática**: cada hashtag recebeu classificação preliminar gerada a partir dos critérios e do dicionário do Instagram como modelo analítico (matching direto de equivalentes, detecção de variantes, aplicação das regras temáticas), seguida de revisão e explicitação dos casos ambíguos para validação humana.

**As três categorias:**

| Cat. | Nome | Definição |
|---|---|---|
| **M** | Manter | A hashtag integra o objeto da pesquisa e é preservada como nó da rede. |
| **U** | Unificar | A hashtag é variante de outra forma; é substituída pela forma canônica indicada em `substituir por`. |
| **R** | Remover | A hashtag é ruído sem relação temática e é eliminada. |

**Critérios aplicados:**

- **Manter (M)** — estelionato, fraude, golpes, criminalidade, segurança, monetização, empreendedorismo, enriquecimento, marketing digital, plataformas, viralização, circulação de conteúdo e personas centrais.
  *Ex.:* `estelionato`, `dinheiro`, `golpe`, `171`, `cc`, `cartaoclonado`, `raul`, `tropado7`, `happynation`, `fyp`, `viral`.
- **Remover (R)** — fandoms, celebridades, futebol, música/personagens sem relação, memes sem vínculo temático, hashtags estrangeiras irrelevantes, spam, ruído algorítmico.
  *IG:* `realmadrid`, `snowman`, `gato`, a constelação de `asensio`, `airmaxtn`. *TT:* `gta`, `games`, `house`, `edit`, `lyrics`, `tipografia`, `capcut`, `rj`, `carros`.
- **Unificar (U)** — variações ortográficas, singular/plural, acentuação, equivalentes idiomáticos, versões com emoji, variantes de viralização.
  *IG:* `dinheirofácil` → `dinheiroextra`, `rendaextra` → `dinheiroextra`, `fy` → `fyp`, `reelsinstagram` → `reels`. *TT:* `money` → `dinheiro`, `foryou` → `fyp`, `viralvideos` → `viral`, `luxury` → `luxo`.

**Núcleos canônicos de unificação:**

| Núcleo | Absorve |
|---|---|
| `fyp` (viralização algorítmica) | `fy`, `foryou`, `foryoupage`, `fouryou`, `fypage`, `fypシ`, `fypp`, todos os alongamentos, `vaiprofycaramba`; no TT também `parati` e elongações; no IG coexiste com `explore`, `reels` e `feed` (este também unificado a `fyp`) |
| `viral` (circulação) | `viraliza`, `viralvideo(s)`, `viraltiktok`, `videoviral`, `viral_video`; `trend` → `trending` |
| `dinheiro` (núcleo financeiro) | `money`; no IG o feixe de renda (`rendaextra`, `rendafixa`, `dinheirofácil`, `viradadesaldo`) converge para `dinheiroextra` |
| `marketingdigital` | IG: `market`, `marketing`, `mktdigital` |
| `estilo` (estilo de vida) | `estilodevida` (IG), `lifestyle` (TT) |
| `luxo` (ostentação) | `luxury`, `luxurylife`, `luxurylifestyle`, `mansion` (TT) |
| `musica` (entretenimento) | `music`, `song`, `songs`, `slowed`, `slowedsongs`, `phonk` (TT) |
| Códigos do grupo | `tropado777`/`tropadosete` → `tropado7`; `happy` → `happynation`; mantidos `171`, `7`, `77`, `777` |

> **Decisão deliberada:** a camada de entretenimento (`musica`, `funk`, `humor`, `meme`) foi mantida como **M**, não removida. Ela não é ruído — é o **invólucro cultural em que o discurso criminal é distribuído**. Trata-se de um achado analítico, não de um descarte.

**Regra hierárquica para casos ambíguos:** `U` quando há equivalência semântica clara com uma forma canônica; `R` quando a hashtag pertence inequivocamente a um campo externo (gaming, edição de vídeo, fandom); `M` quando integra um dos eixos da pesquisa **ou quando o Instagram já a havia codificado como M** (prioridade à comparabilidade).

Casos sinalizados para validação humana estão documentados na coluna `justificativa` do dicionário do TikTok: `ninoabravanel`/`nino`, `aceofbase`, `ruyter`, `mckelvinho`, `entregatiktok`, `status`, `casa`, `trabalhecomartistas`, `house`, `mansion`, `phonk`.

**Distribuição da codificação:**

| Categoria | Instagram (n=291) | TikTok (n=103) |
|---|---|---|
| M (manter) | 107 (36,8%) | 43 (41,7%) |
| U (unificar) | 87 (29,9%) | 51 (49,5%) |
| R (remover) | 97 (33,3%) | 9 (8,7%) |

> **Achados da codificação.** (i) A proporção de **U é muito maior no TikTok** (≈50% vs 30%): o vocabulário do TikTok é mais redundante, dominado por variantes de viralização que se multiplicam em formas alongadas e decoradas. (ii) A proporção de **R é muito menor no TikTok** (≈9% vs 33%): o Instagram trouxe muito mais ruído de fandom/futebol/marcas, ao passo que o TikTok se concentra mais estreitamente no campo temático. (iii) Em ambos, **o núcleo M é estável e quase idêntico em conteúdo** — primeira evidência forte de que as duas plataformas hospedam o mesmo ecossistema discursivo.

### 3.6 Limpeza

Script: [`scripts/04_aplicar_dicionario.R`](scripts/04_aplicar_dicionario.R)

Para cada hashtag de cada publicação: se **R**, remove; se **U**, substitui pela forma canônica; se **M**, mantém. Ao final, elimina duplicatas dentro do mesmo post — **incluindo as que surgem após a unificação** (p. ex. `fy` e `foryou` ambos virando `fyp`).

> **Diferença de escopo — ponto técnico importante para replicação.** A coluna de hashtags limpas **preserva a cauda longa**: hashtags com n < 10 que não constam do dicionário passam adiante sem alteração, pois não são nem R nem U. A restrição ao vocabulário codificado ocorre **apenas na etapa seguinte**, na construção da rede. É essa lógica que leva o Instagram de 291 candidatas a 111 nós.

Exemplo real de transformação (TikTok):

```
antes:  171, estelionato, estelionatario, 7, raul, viral, fyp, foryou, golpe, dinheiro
depois: 171, estelionato, estelionatario, 7, raul, viral, fyp, golpe, dinheiro
```
(`foryou` unificado a `fyp`, que já estava presente; a duplicata resultante foi eliminada.)

### 3.7 Construção das redes

Script: [`scripts/05_construir_rede.R`](scripts/05_construir_rede.R)

**Definições formais:**

| Termo | Definição |
|---|---|
| **Nó** | Uma hashtag na forma canônica, após limpeza. |
| **Aresta** | Ligação entre duas hashtags que aparecem juntas no mesmo post (coocorrência). |
| **Weight** | Número de publicações em que aquele par coocorre. Define a espessura da aresta. |
| **Frequency** | Atributo do nó: número de publicações em que a hashtag canônica aparece. Define o tamanho do nó. |
| **Coocorrência** | Mecanismo gerador das arestas. Para um post com A, B, C, geram-se A–B, A–C, B–C. |

**Passo a passo:** (1) seleção do vocabulário codificado (n ≥ 10, após remover R e aplicar U — a cauda longa fica fora da rede); (2) geração dos nós, com `Frequency` recontada sobre os dados limpos; (3) geração das arestas por `combn(tags, 2)`; (4) cálculo dos pesos; (5) exportação de `nodes_*.csv` (Id, Label, Frequency) e `edges_*.csv` (Source, Target, Weight).

> ⚠️ **Nota de replicação sobre as arestas.** O arquivo de arestas do Instagram contém **2.256 linhas, mas apenas 1.569 pares não-direcionados únicos**: a geração original usa `combn(tags, 2)` **sem ordenar previamente o par**, de modo que a mesma relação aparece em duas linhas (p. ex. `viral→fyp` com peso 145 e `fyp→viral` com peso 147). Ao importar como rede **não-direcionada** no Gephi, esses pares recíprocos são fundidos e a leitura analítica não se altera. No TikTok o pipeline já canoniza a ordem, produzindo 430 arestas únicas.
>
> **Neste repositório, [`scripts/05_construir_rede.R`](scripts/05_construir_rede.R) aplica `sort()` ao par antes do `combn`**, produzindo diretamente arestas canônicas e únicas. Os arquivos históricos do Instagram (2.256 linhas) são preservados em `data/network/legacy/` para auditoria da equivalência.

**Indicadores das redes:**

| Indicador | Instagram | TikTok |
|---|---|---|
| Nós | 111 | 47 |
| Arestas (linhas no CSV) | 2.256 | 430 |
| **Pares não-direcionados únicos** | **1.569** | **430** |
| Peso total das arestas | 22.471 | 4.244 |
| Densidade | 0,262 | **0,415** |
| Grau médio | 28,3 | 18,3 |
| Comunidades (Modularity, res. 1,0) | 3 | 3 |
| Modularidade (Q) | **0,329** | 0,148 |

> **Achado.** Apesar de menor, a rede do TikTok é **mais densa** (0,415 vs 0,262): seus poucos nós estão mais interligados, refletindo a concentração em torno do eixo de viralização. Ambas têm 3 comunidades, mas a **modularidade mais alta do Instagram** (Q = 0,329 vs 0,148) indica comunidades mais nitidamente separadas, enquanto no TikTok os blocos temáticos estão fundidos pelo núcleo `fyp`/`viral`.

### 3.8 Espinha dorsal e visualização

Scripts: [`scripts/06_disparity_filter.R`](scripts/06_disparity_filter.R) · parâmetros completos em [`docs/PARAMETROS_GEPHI.md`](docs/PARAMETROS_GEPHI.md)

**O problema.** As redes de coocorrência são densas e dominadas por hubs onipresentes. No Instagram, `viral` coocorre com 83% dos nós, `fyp` com 81%, `estelionato` com 75%; mais de um terço das arestas representa coocorrências triviais (peso ≤ 2). Sob essas condições nenhum layout dirigido por forças separa os agrupamentos: o resultado é um **hairball** ilegível, em que a estrutura de comunidades existe nas métricas mas não é visualmente comunicável.

**A solução — disparity filter** (Serrano, Boguñá & Vespignani, 2009). Para cada nó *i* de grau *k*, cada aresta incidente recebe peso normalizado `p_ij = w_ij / s_i` (fração da força total do nó que passa por aquela aresta), e calcula-se

```
α_ij = (1 − p_ij)^(k − 1)
```

— a probabilidade de que um peso ao menos tão concentrado surgisse de uma distribuição aleatória uniforme. Mantêm-se as arestas significativas (α abaixo do limiar) **para pelo menos um dos extremos**, o que preserva as conexões localmente relevantes de cada nó, inclusive as dos nós pequenos, que de outro modo seriam apagados pelos hubs.

**Limiar adotado: α < 0,10.** No Instagram, a rede passa de 1.569 para 273 arestas e a densidade cai de 0,262 para 0,071, preservando 88 nós no componente principal.

> 🔴 **Regra decisiva de interpretação.** A espinha dorsal é usada **exclusivamente para a visualização e leitura dos clusters**. Todas as métricas estruturais reportadas (centralidade, modularidade, grau ponderado, densidade) continuam sendo calculadas **sobre a rede completa**, para não descartar informação.

**Assimetria de tratamento entre plataformas (declarada).** A rede do Instagram, substancialmente maior e mais densa (1.569 vs 430 pares), reteve emaranhado visual residual mesmo após o disparity filter. Aplicou-se a ela um **corte adicional de peso de aresta (≥ 7), exclusivamente para legibilidade da figura**. O TikTok não exigiu esse passo. O impacto estrutural é desprezível: o corte remove apenas **1 nó (`digital`) e 5 arestas de baixo peso** (de 88/273 para 87/268), mantendo inalterados densidade, número de comunidades e partição. A assimetria decorre de uma diferença real de tamanho entre os corpora, não de inconsistência de método.

**Parâmetros do ForceAtlas2:**

| Parâmetro | Instagram | TikTok |
|---|---|---|
| LinLog mode | ligado | ligado |
| Dissuade Hubs | ligado | ligado |
| Prevent Overlap | ligado | ligado |
| Edge Weights invertidos | ligado | ligado |
| Escala (scaling) | 20 | 50 |
| Gravidade | 0,8 | 1,0 |
| Barnes-Hut θ | 0,5 | 1,2 |
| Approximate Repulsion | ligado | — |

**Ajustes visuais e sua justificativa:**

- **Tamanho dos nós** → Ranking por `Frequency`. Comunica de imediato as hashtags dominantes.
- **Cor dos nós** → Partition por `Modularity Class`. Torna visível a segmentação temática.
- **Espessura das arestas** → Ranking por `Weight`. Destaca as associações mais sistemáticas.
- **Rótulos** → tamanho **uniforme**, não proporcional ao nó. Para que o vocabulário técnico-jurídico de baixa frequência (`pix`, `golpedopix`, `consultavel`, `advocaciacriminal`) permaneça legível e seu cluster não seja visualmente apagado.

> ⚠️ **Convenção de cor — atenção na leitura conjunta das figuras.**
> Nas **redes individuais** a cor codifica a **comunidade temática**: 🟠 laranja = eixo criminal-jurídico-financeiro · 🟣 roxo = eixo de viralização · 🟢 verde = eixo de estilo de vida / enriquecimento.
> Na **rede combinada** a cor codifica a **origem do nó**: 🔵 azul-claro = presente em ambas · ⚪ cinza = só Instagram · 🟢 verde = só TikTok.
> Como o verde assume sentidos diferentes entre os dois tipos de figura, **cada figura traz legenda própria** explicitando o que a cor representa.

### 3.9 Rede combinada

Script: [`scripts/08_rede_combinada.R`](scripts/08_rede_combinada.R)

A rede combinada une o vocabulário das duas plataformas num único grafo, atribuindo a cada nó e a cada aresta um rótulo de **origem** — presente em ambas, só no Instagram, ou só no TikTok.

**Método distinto das redes individuais.** Ela **não aplica o disparity filter**, porque seu propósito não é extrair espinha dorsal para leitura de clusters, mas **mapear o compartilhamento de vocabulário**. É construída pela união dos conjuntos de nós e arestas. Como os corpora têm tamanhos muito diferentes (3.126 vs 1.737 publicações com hashtag), **os pesos não são somados em bruto** — isso faria o Instagram dominar o grafo por puro volume, um artefato de coleta. Em vez disso:

- coocorrências normalizadas **por 1.000 publicações** de cada base;
- frequências como **percentual das publicações** de cada base;
- o valor de um nó/aresta presente em ambas é a **média das duas métricas relativas**.

**Resultado — a sobreposição é assimétrica entre os dois níveis:**

| Nível | Em ambas | Só Instagram | Só TikTok | Sobreposição (Jaccard) |
|---|---|---|---|---|
| Vocabulário (nós) | 41 | 70 | 6 | **35%** |
| Relações (arestas) | 309 | 1.260 | 121 | **18%** |

Total: 117 nós e 1.690 arestas.

> 🎯 **Este é o achado que sustenta empiricamente a tese central.** Existe um núcleo discursivo compartilhado — 35% do vocabulário aparece nas duas plataformas, incluindo as hashtags centrais do estelionato (`estelionato`, `171`, `golpe`, `cc`, `cartaoclonado`), da viralização (`fyp`, `viral`) e do enriquecimento (`happynation`, `dinheiro`). Mas a **sobreposição de relações (18%) é metade da de vocabulário (35%)**: as mesmas hashtags se combinam de formas diferentes em cada plataforma.
>
> **Estrutura de conteúdo comum, gramática de visibilidade distinta:** o léxico do ecossistema é largamente partilhado, mas a *sintaxe* das coocorrências — quais termos se ligam a quais — é específica de cada ambiente.

---

## 4. Como reproduzir

### Requisitos

- **R ≥ 4.2** com os pacotes: `readxl`, `dplyr`, `tidyr`, `stringr`, `purrr`, `igraph`, `writexl`, `openxlsx`
- **Gephi ≥ 0.10** (para as visualizações), opcionalmente com o plugin **Disparity/Backbone**

### Instalação

```bash
git clone https://github.com/<ORG>/estelionato-hashtag-networks.git
cd estelionato-hashtag-networks
```

```r
source("scripts/01_setup.R")   # instala e carrega os pacotes
```

### Execução do pipeline completo

```r
source("scripts/run_all.R")
```

Ou passo a passo:

| Ordem | Script | Entrada | Saída |
|---|---|---|---|
| 0 | `00_config.R` | — | caminhos e parâmetros do projeto |
| 1 | `01_setup.R` | — | pacotes instalados e carregados |
| 2 | `02_extracao_frequencias.R` | `data/raw/dataset_consolidado_*.xlsx` | `data/processed/frequencias_*.xlsx` |
| 3 | `03_cortes_frequencia.R` | frequências | `data/processed/hashtags_freq{3,10,20}_*.csv` |
| 4 | *(codificação manual/semiautomática)* | `hashtags_freq10_*.csv` | `dictionaries/dicionario_*.xlsx` |
| 5 | `04_aplicar_dicionario.R` | base mestra + dicionário | `data/processed/*_limpo.xlsx` |
| 6 | `05_construir_rede.R` | base limpa | `data/network/nodes_*.csv`, `edges_*.csv` |
| 7 | `06_disparity_filter.R` | nós + arestas | `data/network/*_backbone.csv` |
| 8 | `07_metricas_rede.R` | rede completa | `data/processed/metricas_rede_*.csv` |
| 9 | `08_rede_combinada.R` | ambas as redes | `data/network/rede_combinada_*.csv` |

> A **etapa 4 é humana e não automatizável**: é o momento da codificação M/U/R. Os dicionários resultantes estão versionados em `dictionaries/`, de modo que o pipeline é reproduzível de ponta a ponta sem repetir a codificação.

### Reprodução das figuras no Gephi

1. Importar `nodes_*_backbone.csv` como **Nodes Table** e `edges_*_backbone.csv` como **Edges Table**.
2. Definir o grafo como **Undirected** — coerente com a natureza simétrica da coocorrência (A coocorre com B se e somente se B coocorre com A).
3. Rodar **Statistics → Modularity** (resolução 1,0) e **Average Degree**.
4. Aplicar **ForceAtlas2** com os parâmetros da tabela em [§3.8](#38-espinha-dorsal-e-visualização); deixar convergir até estabilização visual.
5. Aplicar os ajustes visuais (tamanho por `Frequency`, cor por `Modularity Class`, espessura por `Weight`, rótulos uniformes).
6. Instagram apenas: aplicar o filtro adicional **Edge Weight ≥ 7**.

> **Nota sobre estabilidade:** o algoritmo de Modularity é estocástico e o número de comunidades é sensível à resolução. Com resolução 1,0 e execuções repetidas, a partição em 3 comunidades mostrou-se estável em ambas as redes.

---

## 5. Resultados principais

### 5.1 Instagram

**Estrutura.** 111 nós, 1.569 pares de coocorrência, densidade 0,262, 3 comunidades, Q = 0,329 — comunidades nitidamente separadas, organizadas como um forte núcleo central circundado por blocos temáticos distintos.

**Centralidade (Weighted Degree).** `fyp` (1.223), `viral` (1.210), `estelionato` (861), `raul` (855), `explore` (781), `dinheiro` (724), `estelionatario` (691), `171` (578), `tropado7` (521), `reels` (515). Em frequência, `raul` (809) lidera, seguido de `fyp` (715) e `viral` (591). **Aresta mais forte: `viral`–`fyp`.**

**As três comunidades:**

- 🟠 **Núcleo criminal-financeiro-jurídico** — léxico do estelionato (`estelionato`, `estelionatario`, `golpe`, `fraude`, `golpedopix`, `171`, `roubo`, `cc`, `cartaoclonado`, `lavagemdedinheiro`, `laranja`), léxico financeiro (`dinheiro`, `dinheiroextra`, `dinheiroonline`) e vocabulário jurídico-policial (`advocacia`, `advocaciacriminal`, `direito`, `falsoadvogado`, `policia`, `policiacivil`, `segurança`, `prisão`). **No Instagram, `dinheiro` ancora-se neste bloco.**
- 🟣 **Viralização e personas** — `fyp`, `viral`, `explore`, `reels`, `trending`, a camada de entretenimento (`funk`, `humor`, `meme`, `musica`) e — característica importante do Instagram — as personas `raul`, `tropado7`, `bigode`, `buzeira`, `ninoabravanel`.
- 🟢 **Enriquecimento e estilo de vida** — `happynation`, `marketingdigital`, `sucesso`, `lifestyle`, `mindset`, `empreendedorismo`, `oldmoney`, `milionario`, `rico`, `bilionario`, `carro`, `brasil` e os códigos numéricos `77`/`333`/`777`.

### 5.2 TikTok

**Estrutura.** 47 nós, 430 arestas, densidade 0,415 — **mais densa** que a do Instagram. 3 comunidades, mas Q = 0,148: os blocos são bem mais fundidos em torno do eixo de viralização.

**Centralidade (Weighted Degree).** `fyp` (1.511), `viral` (818), `estelionato` (756), `raul` (519), `dinheiro` (484), `happynation` (433), `171` (407), `7` (353), `estelionatario` (324), `tropado7` (287). Em frequência, `fyp` (896) domina com folga. **Arestas mais fortes: `fyp`–`viral` (239) e `estelionato`–`fyp` (172).**

**As três comunidades:**

- 🟠 **Núcleo criminal** — `estelionato`, `estelionatario`, `171`, `7`, `777`, `golpe`, `crime`, `cc`, `cartaoclonado`, `laranja`, `bigode`, `frases`, `mckelvinho`, `meme`, `explore` e — **diferentemente do Instagram** — as personas `raul` e `tropado7`.
- 🟣 **Viralização e entretenimento** — `fyp`, `viral`, `happynation`, `funk`, `musica`, `humor`, `trending`, `tiktok`, `status`, `motivational`, `ninoabravanel`, `mulherdepreso`, `brasil`, `policia`, `sucesso`.
- 🟢 **Estilo de vida / enriquecimento** — `dinheiro`, `luxo`, `milionario`, `rico`, `ruyter`. Bloco menor e mais enxuto que o equivalente do Instagram. **Note-se que `dinheiro`, que no Instagram ancora o núcleo criminal-financeiro, no TikTok desloca-se para o eixo de estilo de vida.**

### 5.3 Comparação

**Semelhanças estruturais.** As duas redes reproduzem a **mesma arquitetura tripartite**: (1) núcleo criminal-financeiro (`estelionato` + `dinheiro`), (2) núcleo de viralização (`fyp`/`viral`) e (3) camada aspiracional/ostentatória (luxo/riqueza), costurados por **personas-âncora** (sobretudo `raul`). Em ambas, a aresta mais forte liga `fyp` e `viral`, e o núcleo do estelionato conecta-se diretamente ao de viralização. O vocabulário M é quase idêntico e várias personas são compartilhadas (`raul`, `ruyter`, `ninoabravanel`, `aceofbase`, `happynation`, `tropado7`, `buzeira`, `bigode`).

**Diferenças estruturais:**

| Aspecto | Instagram | TikTok |
|---|---|---|
| Tamanho | maior (111 nós) | menor (47 nós) |
| Densidade | menor (0,262) | maior (0,415) |
| Modularidade (Q) | maior (0,329) | menor (0,148) |
| Comunidades | 3, mais separadas | 3, mais fundidas |
| Centralidade do topo | dividida (`fyp` ≈ `viral` ≈ `raul`) | concentrada em `fyp` |

**Diferenças de vocabulário.** O Instagram carrega vocabulário mais **diversificado e mercantil**: marcas de luxo (`armani`, `nike`, `lacoste`, `lv`), `oldmoney`, `dropshipping`, `marketingdigital`, `bitcoin`, `blackhat`, e repertório jurídico-securitário extenso. O TikTok tem vocabulário mais **enxuto e algorítmico**, dominado por variantes de viralização e por camada de entretenimento musical (`musica`, `funk`, `phonk`, `slowed`), com elementos próprios como `mulherdepreso` e `tiktokshop`.

**Mecanismos de visibilidade — a distinção mais nítida:**

- **Instagram → identidade de grupo + descoberta.** A visibilidade se ancora em `explore`, `reels` e `feed`, combinados a marcadores de pertencimento (`happynation`, `tropado7`, personas). O alcance é negociado tanto pelo algoritmo de descoberta quanto pela filiação a uma comunidade identificável.
- **TikTok → viralização algorítmica pura.** A visibilidade se ancora em `fyp` e `parati` — apelos diretos ao algoritmo. A elongação massiva (`fyppppp…`, `paratiiiii…`) e a decoração com emojis (`fypシ`) são performances de apelo algorítmico muito mais intensas.

**Articulação crime–monetização–entretenimento.** Em ambas as plataformas, **o crime não circula sozinho**: vem embalado em entretenimento (`funk`, `humor`, `meme`, `musica` — todos mantidos como M justamente porque são o veículo) e vendido como promessa de enriquecimento (`luxo`, `riqueza`, `sucesso`). A diferença é de ênfase: no Instagram o eixo monetização-empreendedorismo é mais elaborado, sugerindo discurso mais próximo do **mercado**; no TikTok o eixo entretenimento-viralização é dominante, sugerindo discurso mais próximo do **espetáculo** e do alcance algorítmico.

### 5.4 Achado central

> **É o mesmo ecossistema discursivo — com qualificação.**
>
> **Sim:** as duas plataformas hospedam o mesmo ecossistema — mesmo léxico criminal-financeiro nuclear, mesma lógica de acoplar crime à viralização, mesmas personas-âncora circulando entre os ambientes, mesma arquitetura tripartite.
>
> **Com qualificação:** cada plataforma modula esse ecossistema segundo sua própria economia de visibilidade — o Instagram o organiza em torno de **identidade de grupo e mercado**; o TikTok, em torno de **viralização algorítmica e espetáculo**.
>
> **O ecossistema é um só; as gramáticas de visibilidade são duas.**

---

## 6. Dimensão etnográfica complementar

**A lacuna.** A coleta automatizada captura metadados estruturados, mas **não captura o conteúdo audiovisual dos vídeos**. Em plataformas como Instagram e TikTok o vídeo é o elemento central da publicação, e boa parte do sentido do objeto pesquisado — a performance do golpe, a encenação da riqueza, os códigos visuais do grupo — só é acessível pela observação direta da peça audiovisual.

**O procedimento**, informado por Hine (2015):

1. Conta no Instagram **sem publicações, sem seguidores e sem perfis seguidos** — perfil "limpo", sem histórico capaz de enviesar a curadoria algorítmica.
2. Partida do **primeiro vídeo sobre o objeto exibido na aba "Explorar"**, deixando a navegação subsequente ser conduzida pela recomendação da própria plataforma.
3. **Nenhuma curtida, nenhum comentário** — sem interferência no campo e sem rastro de interação.
4. Interação observacional limitada a **abrir comentários e salvar vídeos** pelo recurso nativo da plataforma.

Essa rotina preserva a posição de **observação não participante**: a conta não emite sinais de engajamento que realimentem o algoritmo ou sejam percebidos pelos perfis observados, e o material é arquivado por mecanismo já previsto pela plataforma, sem extração externa do vídeo.

**Acervo produzido** — publicações selecionadas no Instagram entre **maio e setembro de 2025**:

| Categoria (tipo penal de referência) | Publicações | % |
|---|---|---|
| Estelionato | 81 | 62,3% |
| Furto simples | 30 | 23,1% |
| Roubo mediante violência ou grave ameaça | 19 | 14,6% |
| **Total** | **130** | **100%** |

Esse acervo é **complementar, e não substitutivo**, ao corpus quantitativo: a base estruturada mapeia o vocabulário em escala (3.611 e 1.957 publicações); o acervo etnográfico examina em profundidade uma amostra menor e curada, ancorando a leitura estrutural das redes em observação direta do conteúdo audiovisual.

---

## 7. Limitações e ressalvas

Estas ressalvas são parte do desenho da pesquisa e devem acompanhar qualquer citação dos resultados.

**1. A assimetria de tamanho é, em parte, artefato de coleta.** O corpus do Instagram é ~1,8× maior (3.611 vs 1.957), mas isso **não reflete necessariamente um ecossistema discursivo menor no TikTok** — decorre sobretudo do teto de raspagem imposto pela plataforma. Em consequência, todos os indicadores **absolutos** (nº de nós, arestas, peso total) devem ser lidos com cautela, privilegiando-se a **estrutura relativa** (proporções, posições, densidade, modularidade) sobre as magnitudes brutas.

**2. Efeito de seleção das sementes (reflexividade amostral).** Como o corpus foi construído a partir de seis hashtags-semente, **essas mesmas hashtags tendem a ser, por construção, as mais frequentes e mais centrais**. A centralidade de `estelionato`, `estelionatario`, `raul`, `happynation`, `tropado7` e `171` deve ser interpretada como **parcialmente induzida pelo desenho amostral**, não como achado emergente. O valor analítico das redes está (i) no que **coocorre** com as sementes — o vocabulário associado que não foi buscado diretamente — e (ii) nas **comparações entre plataformas**, em que o desenho amostral é idêntico e, portanto, se cancela.

**3. Sem janela temporal controlada.** As plataformas não permitem filtro de datas na busca por hashtag. O corpus é um recorte do disponível no momento da captura.

**4. Assimetria no tratamento visual.** O corte adicional de peso ≥ 7 aplicado apenas ao Instagram afeta **apenas a renderização**, não a análise: impacto de 1 nó e 5 arestas, com densidade, número de comunidades e partição inalterados. Todas as métricas reportadas são da rede completa.

**5. A rede combinada e a assimetria "só IG" vs "só TT".** Os 70 nós exclusivos do Instagram contra 6 do TikTok refletem, em parte, o corpus maior e mais diverso do Instagram e o teto de raspagem que limitou o TikTok — **não apenas uma diferença de riqueza discursiva**.

**6. Metadados textuais, não conteúdo audiovisual.** A análise de redes opera sobre hashtags e não captura o vídeo. Essa lacuna é endereçada — não eliminada — pela dimensão etnográfica ([§6](#6-dimensão-etnográfica-complementar)).

**7. Duplicação recíproca de arestas no arquivo histórico do Instagram.** Ver a nota de replicação em [§3.7](#37-construção-das-redes).

---

## 8. Ética e proteção de dados

Ver o protocolo completo em **[ETHICS.md](ETHICS.md)**.

A natureza do objeto — comunidades que operam regimes de visibilidade ambíguos e veiculam representações explícitas de atos potencialmente enquadráveis como criminosos — impõe cuidados éticos específicos, **sob risco de a própria pesquisa expor as pessoas que publicam esse conteúdo a reações persecutórias**. Medidas adotadas:

- **anonimização** dos nomes de usuário mencionados ao longo do texto;
- **referência indireta** aos dados de campo, evitando descrições que permitam identificar perfis ou publicações específicas;
- **omissão dos IDs** das publicações referenciadas no corpo do texto.

> A ética da pesquisa é assumida como **constitutiva de sua construção**, e não como camada de conformidade aposta *a posteriori*: as escolhas de não interação (não curtir, não comentar), de anonimização e de referência indireta são parte do desenho do estudo, não apenas salvaguardas formais.

O script [`scripts/99_anonimizar.R`](scripts/99_anonimizar.R) implementa a remoção sistemática de campos de autoria, IDs e URLs antes de qualquer publicação de dados. **Executá-lo é obrigatório antes de qualquer commit em `data/raw/`.**

---

## 9. Dicionário de dados

Ver [`data/README.md`](data/README.md) para o esquema completo. Resumo dos arquivos de rede:

**`nodes_<plataforma>.csv`**

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | string | Hashtag na forma canônica (chave primária) |
| `Label` | string | Idêntico a `Id`; rótulo exibido no Gephi |
| `Frequency` | int | Nº de publicações em que a hashtag canônica aparece (presença-por-post) |

**`edges_<plataforma>.csv`**

| Coluna | Tipo | Descrição |
|---|---|---|
| `Source` | string | Hashtag A (referencia `nodes.Id`) |
| `Target` | string | Hashtag B (referencia `nodes.Id`) |
| `Weight` | int | Nº de publicações em que A e B coocorrem |
| `Type` | string | Sempre `Undirected` |

**`dicionario_<plataforma>.xlsx`**

| Coluna | Tipo | Descrição |
|---|---|---|
| `tags` | string | Hashtag original observada |
| `ação` | enum | `M` (manter) · `U` (unificar) · `R` (remover) |
| `substituir por` | string | Forma canônica; preenchida apenas quando `ação = U` |
| `n` | int | Frequência bruta observada *(TikTok)* |
| `justificativa` | string | Racional da decisão *(TikTok)* |
| `ambiguo` | bool | Sinalização para validação humana *(TikTok)* |

---

## 10. Como citar

Este repositório e o relatório metodológico são depositados no **Zenodo**, que gera um **DOI permanente a cada release** do GitHub. Cite a versão que você efetivamente utilizou.

**Relatório metodológico (technical report):**

```
[Autores] (2026). Redes de coocorrência de hashtags em Instagram e TikTok no
ecossistema discursivo do estelionato e da monetização ilícita: memória
metodológica, apêndice técnico e guia de replicação. Zenodo.
https://doi.org/10.5281/zenodo.XXXXXXX
```

**Repositório de dados e código:**

```
[Autores] (2026). estelionato-hashtag-networks: dados, dicionários e scripts
(versão v1.0.0) [Software e conjunto de dados]. Zenodo.
https://doi.org/10.5281/zenodo.XXXXXXX
```

BibTeX e CSL: ver [`CITATION.cff`](CITATION.cff) — o GitHub gera automaticamente os formatos a partir dele ("Cite this repository" na barra lateral).

### Integração com o Zenodo (passo a passo)

1. Entrar em [zenodo.org](https://zenodo.org) com a conta do GitHub.
2. **Settings → GitHub** e ativar o toggle deste repositório.
3. No GitHub, criar uma **release** (`v1.0.0`) — o Zenodo captura o snapshot e emite o DOI.
4. Copiar o **Concept DOI** (que sempre aponta para a versão mais recente) e substituir `10.5281/zenodo.XXXXXXX` no badge do topo, no `CITATION.cff` e nesta seção.
5. Depositar separadamente o **relatório metodológico em PDF** como *Technical Report*, vinculando-o ao repositório pelo campo `related identifiers` (`isSupplementTo`).

---

## 11. Referências

- **Serrano, M. Á., Boguñá, M., & Vespignani, A.** (2009). Extracting the multiscale backbone of complex weighted networks. *Proceedings of the National Academy of Sciences*, 106(16), 6483–6488. https://doi.org/10.1073/pnas.0808904106
- **Hine, C.** (2015). *Ethnography for the Internet: Embedded, Embodied and Everyday*. London: Bloomsbury.
- **Jacomy, M., Venturini, T., Heymann, S., & Bastian, M.** (2014). ForceAtlas2, a continuous graph layout algorithm for handy network visualization designed for the Gephi software. *PLoS ONE*, 9(6), e98679. https://doi.org/10.1371/journal.pone.0098679
- **Blondel, V. D., Guillaume, J.-L., Lambiotte, R., & Lefebvre, E.** (2008). Fast unfolding of communities in large networks. *Journal of Statistical Mechanics*, P10008. https://doi.org/10.1088/1742-5468/2008/10/P10008
- **Bastian, M., Heymann, S., & Jacomy, M.** (2009). Gephi: an open source software for exploring and manipulating networks. *ICWSM*.
- **Peeters, S., & Hagen, S.** (2022). The 4CAT Capture and Analysis Toolkit: A modular tool for transparent and traceable social media research. *Computational Communication Research*, 4(2), 571–589.
- **Rieder, B., & Röhle, T.** (2017). Digital methods: From challenges to *Bildung*. In M. T. Schäfer & K. van Es (Eds.), *The Datafied Society*. Amsterdam University Press.

---

## 12. Equipe e contato

| Papel | Nome | ORCID | Instituição |
|---|---|---|---|
| Coordenação | *a preencher* | *a preencher* | *a preencher* |
| Análise de redes | *a preencher* | *a preencher* | *a preencher* |
| Trabalho de campo etnográfico | *a preencher* | *a preencher* | *a preencher* |

**Contato:** *a preencher*
**Financiamento:** *a preencher*

---

<sub>Última atualização do fluxo metodológico: ver [CHANGELOG.md](CHANGELOG.md).</sub>
