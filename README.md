# Redes de coocorrência de hashtags no ecossistema discursivo do estelionato

**Instagram e TikTok · mapeamento comparado do discurso do crime financeiro digital**

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)

> 🇬🇧 An English version of this README is available at **[README.en.md](README.en.md)**.

Este repositório é o ambiente de versionamento, documentação e reprodução da pesquisa que mapeia e compara os ecossistemas discursivos associados ao estelionato, aos golpes financeiros, à monetização ilícita e às estratégias de viralização no **Instagram** e no **TikTok**, por meio de **redes de coocorrência de hashtags**.

Reúne os dados, os scripts em R, os dicionários de codificação, as figuras e a memória metodológica completa que sustentam o artigo internacional e o capítulo de livro derivados do projeto.

Este README documenta o **percurso metodológico**. Os resultados empíricos (centralidades, comunidades, comparação entre plataformas) estão no artigo e na memória metodológica completa, em [`docs/documento_metodologico_integrado.docx`](docs/). Autoria, financiamento e forma de citação estão em [`CITATION.cff`](CITATION.cff).

**Princípio orientador:** todo número reportado no artigo e no capítulo deve ser rastreável até um arquivo deste repositório e até o bloco de código que o produziu.

> **Convenção de leitura:** os campos marcados com `«confirmar»` dependem de informação que só a equipe pode preencher (versões efetivamente usadas, licença). Estão sinalizados para não serem publicados por engano.

---

## Sumário

- [1. Objetivos da pesquisa](#1-objetivos-da-pesquisa)
- [2. Estratégia de coleta](#2-estratégia-de-coleta)
- [3. Queries utilizadas](#3-queries-utilizadas)
- [4. Ferramentas e versões](#4-ferramentas-e-versões)
- [5. Procedimentos de tratamento dos dados](#5-procedimentos-de-tratamento-dos-dados)
- [6. Fluxo completo da análise](#6-fluxo-completo-da-análise)
- [7. Organização do repositório](#7-organização-do-repositório)
- [8. Instruções para reproduzir](#8-instruções-para-reproduzir)
- [9. Dicionário de dados](#9-dicionário-de-dados)
- [10. Limitações e ressalvas](#10-limitações-e-ressalvas)
- [11. Ética e proteção de dados](#11-ética-e-proteção-de-dados)
- [12. Referências](#12-referências)

---

## 1. Objetivos da pesquisa

A pesquisa investiga os ecossistemas discursivos digitais associados ao estelionato, aos golpes financeiros, à monetização ilícita e às estratégias de viralização em **Instagram** e **TikTok**. O objeto não é uma peça isolada de conteúdo fraudulento, mas a **gramática coletiva** com que esse conteúdo é produzido, etiquetado e distribuído: o conjunto de marcadores (hashtags) que os produtores empregam para inscrever suas publicações em circuitos de visibilidade, comunidade e mercado.

**Objetivo geral.** Mapear e comparar como o discurso do crime financeiro digital se organiza em cada plataforma.

**Objetivos específicos.** Identificar:

1. o vocabulário temático recorrente;
2. os agrupamentos semânticos que estruturam o campo (crime, riqueza, viralização, entretenimento);
3. as personas e os marcadores que funcionam como pontes entre esses agrupamentos;
4. as estratégias de visibilidade específicas de cada ambiente algorítmico.

**Por que redes de coocorrência.** Três propriedades do método justificam a escolha. (i) As hashtags são **autodeclarações de pertencimento**: ao etiquetar uma publicação, o autor a posiciona deliberadamente em um campo discursivo, o que torna a hashtag um traço observável da intenção comunicativa. (ii) A **coocorrência** — duas hashtags no mesmo post — revela associações que não estão explícitas em nenhuma publicação individual, mas emergem do padrão agregado; é ela que expõe, por exemplo, que o vocabulário do estelionato circula sistematicamente acoplado ao da viralização. (iii) A **representação em grafo** permite aplicar métricas formais (centralidade, modularidade, grau ponderado) que transformam impressões qualitativas em indicadores estruturais comparáveis entre plataformas.

**Desenho espelhado.** O procedimento desenvolvido para o Instagram foi reproduzido integralmente para o TikTok — mesmos limiares, mesmas categorias de codificação, mesma lógica de construção de rede —, ajustando-se apenas o que era estritamente imposto pelas diferenças de estrutura das bases (essencialmente, o índice da coluna de hashtags). Isso garante que as diferenças observadas entre as redes finais reflitam diferenças reais entre as plataformas, e não artefatos de método.

**Desenho misto.** A análise de redes mapeia a estrutura do campo em escala, mas opera sobre metadados textuais e **não captura o conteúdo audiovisual** dos vídeos — elemento central nessas plataformas. Por isso o estudo é complementado por uma dimensão etnográfica ([§2.4](#24-dimensão-etnográfica-complementar)).

---

## 2. Estratégia de coleta

### 2.1 Instrumentação

Coleta com **instrumentação idêntica** nas duas plataformas — condição da comparabilidade.

- **Ferramenta:** extensão [Zeeschuimer](https://github.com/digitalmethodsinitiative/zeeschuimer) conectada ao [4CAT](https://github.com/digitalmethodsinitiative/4cat) (Capture and Analysis Toolkit), capturando as publicações diretamente da navegação.
- **Contas:** criadas **novas** no TikTok e no Instagram especificamente para a coleta, para evitar personalização algorítmica do feed por históricos preexistentes.
- **Busca:** por hashtag, a partir de seis hashtags-semente comuns às duas plataformas ([§3](#3-queries-utilizadas)).
- **Meta:** ~500 posts por hashtag. **Atingida no Instagram; não atingida no TikTok**, por restrições de paginação/raspagem da plataforma. Essa é a origem direta da assimetria de tamanho entre os corpora (ver [§10](#10-limitações-e-ressalvas)).

### 2.2 Consolidação em bases mestras

As **6 planilhas de entrada** de cada plataforma (uma por semente) foram consolidadas em uma **base mestra única**, eliminando a fragmentação por hashtag de busca e permitindo tratar o conjunto como corpus integrado.

### 2.3 Tabela comparativa dos corpora

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
| Colunas de metadados | — | 36 |
| Coluna de legenda | G | I (`body`) |
| Coluna de hashtags | **S (índice 19)** | **AD (`hashtags`, índice 30)** |

### 2.4 Dimensão etnográfica complementar

A coleta automatizada captura metadados estruturados, mas **não captura o conteúdo audiovisual dos vídeos** — e é nele que reside boa parte do sentido do objeto (a performance do golpe, a encenação da riqueza, os códigos visuais do grupo). Para endereçar essa lacuna, a coleta foi complementada por uma imersão de orientação etnográfica, informada por Hine (2015), com o seguinte procedimento:

1. conta no Instagram **sem publicações, sem seguidores e sem perfis seguidos** — perfil "limpo", sem histórico capaz de enviesar a curadoria algorítmica;
2. partida do **primeiro vídeo sobre o objeto exibido na aba "Explorar"**, deixando a navegação subsequente ser conduzida pela recomendação da plataforma;
3. **nenhuma curtida, nenhum comentário** — sem interferência no campo e sem rastro de interação;
4. interação observacional limitada a **abrir comentários e salvar vídeos** pelo recurso nativo da plataforma.

A rotina preserva a posição de **observação não participante**: a conta não emite sinais de engajamento que realimentem o algoritmo ou sejam percebidos pelos perfis observados.

O acervo resultante reúne **130 publicações** selecionadas no Instagram entre **maio e setembro de 2025** — 81 de estelionato (62,3%), 30 de furto simples (23,1%) e 19 de roubo mediante violência ou grave ameaça (14,6%). É **complementar, e não substitutivo**, ao corpus quantitativo. Por razões éticas ([§11](#11-ética-e-proteção-de-dados)), **não é depositado neste repositório**: apenas sua descrição agregada é pública.

---

## 3. Queries utilizadas

A busca foi feita **por hashtag**. As seis hashtags-semente são **comuns às duas plataformas**, e cada uma gerou uma planilha de entrada por plataforma (6 + 6 = 12 no total).

| # | Query (hashtag-semente) | Instagram | TikTok |
|---|---|---|---|
| 1 | `#estelionato` | ✅ | ✅ |
| 2 | `#estelionatario` | ✅ | ✅ |
| 3 | `#raul` | ✅ | ✅ |
| 4 | `#happynation` | ✅ | ✅ |
| 5 | `#tropado7` | ✅ | ✅ |
| 6 | `#171` | ✅ | ✅ |

**Parâmetros da busca:**

| Parâmetro | Valor |
|---|---|
| Tipo de busca | por hashtag (*hashtag search*) |
| Filtro de datas | **nenhum** — as plataformas não permitem essa opção na busca por hashtag |
| Janela temporal | não controlada; o corpus é um recorte do disponível no momento da captura |
| Período de captura | `«confirmar»` (mês/ano da coleta automatizada) |
| Idioma / região | sem filtro |

**Query excluída deliberadamente.** `#bigode` foi retirada do conjunto de sementes: os posts recuperados por ela se afastavam do objeto (referiam-se majoritariamente a pelos faciais). Note-se que `bigode` **permanece como nó** nas redes finais — não como semente, mas como hashtag interna às publicações, onde designa a persona "Raul Bigode". Sua exclusão como query não a remove do campo discursivo capturado pelas outras sementes.

**Consequência amostral a registrar.** Por construção, as seis sementes tendem a ser as hashtags mais frequentes e mais centrais das redes. Sua centralidade deve ser lida como **parcialmente induzida pelo desenho amostral**, não como achado emergente (ver [§10, ponto 2](#10-limitações-e-ressalvas)).

---

## 4. Ferramentas e versões

| Camada | Ferramenta | Versão usada | Papel no fluxo |
|---|---|---|---|
| Coleta | **Zeeschuimer** (extensão de navegador) | `«confirmar»` | captura das publicações durante a navegação |
| Coleta | **4CAT** — Capture and Analysis Toolkit | `«confirmar»` | recepção, armazenamento e exportação das capturas (`.xlsx`/`.csv`) |
| Tratamento e redes | **R** | ≥ 4.2 (usada: `«confirmar»`) | todo o pipeline do dado bruto aos arquivos do Gephi |
| Tratamento e redes | **RStudio** | `«confirmar»` | ambiente de execução |
| Visualização e métricas | **Gephi** | ≥ 0.10 (usada: `«confirmar»`) | layout, comunidades, centralidades, figuras |
| Visualização (opcional) | plugin **Disparity / Backbone** (Gephi) | `«confirmar»` | alternativa sem código ao disparity filter |
| Planilhas | `«confirmar»` (Excel / LibreOffice) | `«confirmar»` | codificação dos dicionários e montagem da rede combinada |

### Pacotes de R

| Pacote | Versão | Uso |
|---|---|---|
| `readxl` | `«confirmar»` | leitura das bases mestras `.xlsx` |
| `dplyr` | `«confirmar»` | manipulação e contagem |
| `tidyr` | `«confirmar»` | `separate_rows()` na extração das hashtags |
| `stringr` | `«confirmar»` | normalização (`str_trim`, `str_split`) |
| `purrr` | `«confirmar»` | `map_chr()` na aplicação do dicionário |
| `igraph` | `«confirmar»` | grafo, `strength`, `degree`, disparity filter |
| `writexl` / `openxlsx` | `«confirmar»` | exportação das planilhas |
| `backbone` *(opcional)* | `«confirmar»` | checagem cruzada da implementação do disparity filter |

> **Como preencher as versões.** No mesmo ambiente em que o pipeline foi executado:
>
> ```r
> writeLines(capture.output(sessionInfo()), "docs/sessioninfo.txt")
> ```
>
> Isso registra R, sistema operacional e todos os pacotes carregados com suas versões. Gephi (*Help → About*), Zeeschuimer (página de extensões do navegador) e 4CAT (rodapé da interface web) precisam ser anotados à mão. Se o pipeline foi executado em máquinas diferentes, reporta-se a versão do ambiente em que foram gerados os arquivos finais (`nodes_*.csv` / `edges_*.csv`), registrando essa ressalva.

---

## 5. Procedimentos de tratamento dos dados

### 5.1 Inspeção inicial das bases

Em ambas as plataformas as hashtags estão armazenadas como **lista separada por vírgulas dentro de uma única célula por publicação** (coluna S no Instagram, AD no TikTok), predominantemente em minúsculas e sem o caractere `#`. Essa convergência de formato é o que torna o tratamento espelhado viável.

Problemas identificados e seu tratamento:

| Problema | Ocorrência | Tratamento | Etapa |
|---|---|---|---|
| Publicações sem hashtag | IG: 485 / TT: 220 (11,2%) | mantidas no corpus; excluídas da rede | Extração |
| Duplicação interna | TT: 62 posts (ex.: `viral,viral,paineldo7`) | deduplicação por presença dentro do post | Limpeza / rede |
| Emojis anexados | TT: 164 posts (`fypシ`, `dinheiroonline💰`, `mulherdepreso🔓🕊👫💍`); IG: `brasil🇧🇷`, `viralpost❤️` | unificação à forma textual limpa | Dicionário (U) |
| Maiúsculas | TT: 5 posts | conversão a minúsculas (`tolower()`) | Normalização |
| Variantes ortográficas/idiomáticas | `dinheiro`/`money`, `viral`/`viralvideo`, `fouryou` | unificação a forma canônica | Dicionário (U) |
| Alongamentos | TT: `fyppppppppppppppppppppppp` (39×), `paratiiii…` (21×), `fyyyyyyyyyyyyyyyy` (33×) | unificação à forma base | Dicionário (U) |

> **Achado desta etapa:** os dois corpora compartilham os mesmos modos de "sujeira". Isso é, em si, um resultado — as práticas de etiquetagem nas duas plataformas seguem gramáticas semelhantes de viralização (alongar `fyp`, decorar com emojis, repetir o apelo ao algoritmo). A consequência metodológica é que o mesmo conjunto de procedimentos se aplica às duas bases, validando a estratégia espelhada.

### 5.2 Extração e contagem de frequências

**Script:** `Análise de frequência de hashtags – Instagram.R` / `– TikTok.R`

O procedimento: seleciona a coluna de hashtags (índice 19 no IG; coluna `hashtags`/AD no TT), desmembra a célula-lista com `separate_rows(sep = ",")` — uma linha por ocorrência —, normaliza cada token com `str_trim()` e `tolower()`, descarta vazios e `NA`, e conta com `count(tags)`.

> **Ponto metodológico essencial.** Nessa etapa a frequência é contada **por ocorrência bruta**, não por presença no post: uma hashtag repetida dentro de um mesmo post é contada mais de uma vez. A deduplicação intra-post só entra depois, em dois momentos — (i) na função de limpeza (`unique()` sobre as hashtags resolvidas de cada post) e (ii) na construção da rede (`unique()` antes de gerar os pares). Assim, **a tabela de frequências e os cortes operam sobre ocorrências brutas**, ao passo que **a `Frequency` dos nós e os pesos das arestas operam sobre presença-por-post**. É por isso que a frequência de uma hashtag na tabela é, em geral, ligeiramente superior à sua frequência como nó.

| Métrica | Instagram | TikTok |
|---|---|---|
| Ocorrências brutas (contagem oficial) | 21.812 | 9.149 |
| Hashtags distintas | 5.048 | 2.967 |
| Publicações com hashtag | 3.126 | 1.737 |
| Publicações sem hashtag | 485 | 220 |
| Hashtags com n ≥ 3 | 963 | 425 |
| **Hashtags com n ≥ 10 (corte adotado)** | **291** | **103** |
| Hashtags com n ≥ 20 | 138 | 51 |

*(Referência: a deduplicação intra-post removeria 91 repetições no TikTok, reduzindo o total a 9.058 — mas a contagem oficial, como no script, é a bruta.)*

**Justificativa do limiar n ≥ 10.** Foram testados três pontos de corte (≥3, ≥10, ≥20) em ambas as plataformas. O ≥ 10 foi escolhido porque (i) **preserva a diversidade temática** — não descarta campos semânticos relevantes de frequência moderada; (ii) **elimina muito ruído** — remove a cauda longa de hashtags idiossincráticas, erros e termos de ocorrência única; (iii) **mantém um conjunto administrável** — viabiliza a codificação manual de cada hashtag, inviável com as 963/425 do corte ≥3. O efeito é comparável nas duas bases: o Instagram passa de 5.048 para 291 candidatas (5,8% do vocabulário) e o TikTok de 2.967 para 103 (3,5%).

### 5.3 Dicionários analíticos (M/U/R)

**Etapa humana, não automatizável.** As hashtags com n ≥ 10 foram exportadas e codificadas. No **Instagram**, manualmente, item a item. No **TikTok**, de forma **semiautomática**: cada hashtag recebeu classificação preliminar gerada a partir dos critérios e do dicionário do Instagram como modelo analítico (matching direto de equivalentes, detecção de variantes, aplicação das regras temáticas), seguida de revisão humana e da explicitação dos casos ambíguos.

**As três categorias:**

| Código | Significado | Efeito |
|---|---|---|
| **M** | Manter | a hashtag integra o objeto e é preservada como nó |
| **U** | Unificar | é variante de outra forma; substituída pela forma canônica de `substituir por` |
| **R** | Remover | é ruído sem relação temática; eliminada |

**Critérios.**

- **Manter (M):** estelionato, fraude, golpes, criminalidade, segurança, monetização, empreendedorismo, enriquecimento, marketing digital, plataformas, viralização, circulação de conteúdo e personas centrais. Ex.: `estelionato`, `dinheiro`, `golpe`, `171`, `cc`, `cartaoclonado`, `raul`, `tropado7`, `happynation`, `fyp`, `viral`.
- **Remover (R):** fandoms, celebridades, futebol, música/personagens sem relação, memes sem vínculo temático, hashtags estrangeiras irrelevantes, spam e ruído algorítmico. IG: `realmadrid`, `snowman`, `gato`, toda a constelação `asensio`, `airmaxtn`. TT: `gta`, `games`, `house`, `edit`, `lyrics`, `tipografia`, `capcut`, `rj`, `carros`.
- **Unificar (U):** variações ortográficas, singular/plural, acentuação, equivalentes idiomáticos, versões com emoji e variantes de viralização. IG: `dinheirofácil` → `dinheiroextra`, `rendaextra` → `dinheiroextra`, `fy` → `fyp`, `fypage` → `fyp`, `reelsinstagram` → `reels`. TT: `money` → `dinheiro`, `foryou` → `fyp`, `viralvideos` → `viral`, `luxury` → `luxo`.

**Principais núcleos canônicos** (os mesmos nas duas plataformas):

| Núcleo | Absorve |
|---|---|
| `fyp` | `fy`, `foryou`, `foryoupage`, `fouryou`, `fypage`, `fypシ`, `fypp`, todos os alongamentos, `vaiprofycaramba`; no TT também `parati` e elongações; no IG coexiste com `explore` e `reels` (e `feed` → `fyp`) |
| `viral` | `viraliza`, `viralvideo(s)`, `viraltiktok`, `videoviral`, `viral_video`; `trend` → `trending` |
| `dinheiro` | `money` → `dinheiro`; no IG o feixe de renda (`rendaextra`, `rendafixa`, `dinheirofácil`, `viradadesaldo`) converge para `dinheiroextra` |
| `marketingdigital` | IG: `market`, `marketing`, `mktdigital`; no TT o campo aparece via `tiktokshop` e `trabalhecomartistas` (ambíguo) |
| `estilo` | `estilodevida` (IG), `lifestyle` (TT) |
| `luxo` | `luxury`, `luxurylife`, `luxurylifestyle`, `mansion` (TT); no IG inclui `oldmoney`, `grife` e marcas |
| `musica` | `music`, `song(s)`, `slowed`, `slowedsongs`, `phonk` (TT) |
| códigos do grupo | `171`, `7`, `77`, `777`, `tropado7` mantidos; `tropado777`/`tropadosete` → `tropado7`; `happy` → `happynation` |

> **Decisão deliberada:** a camada de entretenimento (`musica`, `funk`, `humor`, `meme`) foi mantida como **M**, e não removida. Ela não é ruído: é o **invólucro cultural** em que o discurso criminal é distribuído — um achado analítico, não um descarte.

**Regra hierárquica para empates.** `U` quando há equivalência semântica clara com uma forma canônica; `R` quando a hashtag pertence inequivocamente a um campo externo (gaming, edição de vídeo, fandom); `M` quando integra um dos eixos da pesquisa **ou quando o Instagram já a havia codificado como M** (prioridade à comparabilidade).

**Casos ambíguos sinalizados para validação humana (TikTok):** `ninoabravanel`/`nino` (34 ocorrências; decisão aplicada M, com recomendação expressa de revisão — pode ser ruído de fandom), `aceofbase` (banda; M por comparabilidade com o IG), `ruyter` e `mckelvinho` (personas do corpus, M por coocorrerem com o núcleo criminal; exigem identificação), `entregatiktok` (tratada como apelo de algoritmo, U → `fyp`; pode ser promoção de serviço de entrega), `status`, `casa`, `trabalhecomartistas`, `house`, `mansion`, `phonk` (limítrofes, com decisão caso a caso na coluna `justificativa`).

**Distribuição da codificação:**

| Categoria | Instagram (n=291) | TikTok (n=103) |
|---|---|---|
| M (manter) | 107 (36,8%) | 43 (41,7%) |
| U (unificar) | 87 (29,9%) | 51 (49,5%) |
| R (remover) | 97 (33,3%) | 9 (8,7%) |

> **Achados da codificação.** (i) A proporção de **U é muito maior no TikTok** (≈50% vs 30%): o vocabulário do TikTok é mais redundante, dominado por variantes de viralização (`fyp`, `viral`, `parati`) que se multiplicam em formas alongadas e decoradas. (ii) A proporção de **R é muito menor no TikTok** (≈9% vs 33%): o Instagram trouxe muito mais ruído de fandom/futebol/marcas, ao passo que o TikTok se concentra mais estreitamente no campo temático. (iii) Em ambos, **o núcleo M é estável e quase idêntico em conteúdo** — primeira evidência de que as duas plataformas hospedam o mesmo ecossistema discursivo.

### 5.4 Aplicação da limpeza

**Script:** `Ler e padronizar o dicionário instagram.R` / `tiktok.R`

O script padroniza o dicionário (`str_trim(tolower(tags))`, `str_trim(toupper(ação))`) e percorre cada publicação aplicando, hashtag a hashtag: se **R**, remove; se **U**, substitui pela forma canônica; se **M**, mantém; ao final, elimina duplicatas dentro do mesmo post — **incluindo as que surgem após a unificação** (p. ex. `fy` e `foryou`, ambos virando `fyp`).

O resultado é gravado em uma **nova coluna** `hashtags_limpas`, preservando-se a coluna original.

| Saída | Instagram | TikTok |
|---|---|---|
| Arquivo | `dataset_consolidado_instagram_limpo.csv` (= `instagram_limpo.xlsx`) | `tiktok_limpo.xlsx` |
| Posts | 3.611 | 1.957 |
| Colunas de hashtags | original + `hashtags_limpas` | `hashtags_original` + `hashtags_limpas` |

> **Diferença de escopo na coluna limpa (ponto técnico de replicação).** A coluna `hashtags_limpas` **preserva a cauda longa**: hashtags com n < 10 que não constam do dicionário passam adiante sem alteração, porque não são nem R nem U. A restrição ao vocabulário codificado acontece **apenas na etapa seguinte**, na construção da rede. É exatamente essa lógica que leva o Instagram de 291 candidatas a 111 nós.

**Exemplo real de transformação (TikTok):**

```
171, estelionato, estelionatario, 7, raul, viral, fyp, foryou, golpe, dinheiro
→
171, estelionato, estelionatario, 7, raul, viral, fyp, golpe, dinheiro
```

(`foryou` foi unificado a `fyp`, que já estava presente, e a duplicata resultante foi eliminada.)

---

## 6. Fluxo completo da análise

```
┌─────────────┐   ┌───────────────┐   ┌───────────┐   ┌────────────┐
│  1. Coleta  │ → │2. Consolidação│ → │3. Inspeção│ → │4. Extração │
│ Zeeschuimer │   │ 6 planilhas → │   │ auditoria │   │ + contagem │
│   + 4CAT    │   │  base mestra  │   │ de sujeira│   │ (bruta)    │
└─────────────┘   └───────────────┘   └───────────┘   └─────┬──────┘
                                                            │
        ┌───────────────────────────────────────────────────┘
        ▼
┌──────────────┐   ┌────────────┐   ┌──────────────┐   ┌──────────────┐
│ 5. Corte n≥10│ → │6. Dicionár.│ → │  7. Limpeza  │ → │ 8. Rede      │
│  (291 / 103) │   │   M/U/R    │   │ R/U/M+dedup  │   │ nós+arestas  │
└──────────────┘   └────────────┘   └──────────────┘   └──────┬───────┘
                                                              │
        ┌─────────────────────────────────────────────────────┘
        ▼
┌──────────────────────┐   ┌───────────────────┐   ┌──────────────────┐
│ 9. Disparity filter  │ → │ 10. Gephi         │ → │ 11. Comparação   │
│  backbone (α < 0,10) │   │ ForceAtlas2 +     │   │  + rede combinada│
│  só para visualizar  │   │ Modularity + grau │   │  (planilha)      │
└──────────────────────┘   └───────────────────┘   └──────────────────┘
```

**Síntese cronológica (etapa → procedimento → resultado), válida para as duas plataformas:**

| # | Etapa | Procedimento | Resultado |
|---|---|---|---|
| 1 | Coleta | busca pelas 6 sementes via Zeeschuimer + 4CAT, contas novas, sem filtro de data, meta ~500 posts/semente | material bruto (IG: meta atingida; TT: limitado pelo teto da plataforma) |
| 2 | Consolidação | 6 planilhas → base mestra única | IG: 3.611 posts · TT: 1.957 posts |
| 3 | Inspeção | auditoria de formato, ausências, duplicações, emojis, maiúsculas, variantes, alongamentos | mapa de inconsistências e plano de tratamento |
| 4 | Extração | separação por vírgula, normalização, contagem bruta | IG: 5.048 distintas · TT: 2.967 distintas |
| 5 | Corte | teste de ≥3/≥10/≥20; escolha de n ≥ 10 | candidatas à codificação — IG: 291 · TT: 103 |
| 6 | Codificação | classificação manual (IG) / semiautomática (TT) em M/U/R | `dicionario_instagram.xlsx`; `dicionario_tiktok_preliminar.xlsx` / `_revisado.xlsx` |
| 7 | Limpeza | remoção de R, substituição de U, manutenção de M, deduplicação | coluna `hashtags_limpas` nas bases limpas |
| 8 | Rede | vocabulário codificado → nós (`Frequency`) e arestas (`Weight`) | `nodes_*.csv`, `edges_*.csv` |
| 9 | Backbone | disparity filter α < 0,10 (só para visualização) | IG: 88 nós/273 arestas · TT: 40 nós/86 arestas |
| 10 | Gephi | importação Undirected, ForceAtlas2, Modularity, Degree/Weighted Degree, ajustes visuais | IG: 111 nós, Q=0,329 · TT: 47 nós, Q=0,148 · ambas com 3 comunidades |
| 11 | Rede combinada | união dos vocabulários com pesos normalizados por corpus | `rede_combinada_instagram_tiktok.xlsx` (117 nós, 1.690 arestas) |

### 6.1 Construção das redes

**Script:** `Construção dos nós e arestas instagram.R` / `tiktok.R`

**Definições:**

| Elemento | Definição |
|---|---|
| **Nó** | uma hashtag na forma canônica, após limpeza |
| **Aresta** | ligação entre duas hashtags que aparecem juntas no mesmo post (coocorrência) |
| **Weight** | nº de publicações em que aquele par coocorre — define a espessura da aresta |
| **Frequency** | atributo do nó: nº de publicações em que a hashtag canônica aparece — define o tamanho do nó |
| **Coocorrência** | mecanismo gerador das arestas: para um post com A, B, C, geram-se A–B, A–C, B–C |

**Passo a passo:**

1. **Seleção do vocabulário codificado.** A rede é construída apenas com as hashtags do dicionário (n ≥ 10), após remover R e aplicar U. A cauda longa fica fora.
2. **Geração dos nós.** Cada forma canônica sobrevivente vira um nó; sua `Frequency` é **recontada** sobre os dados limpos.
3. **Geração das arestas.** Para cada post, `unique()` nas hashtags e depois `combn(tags, 2)` — todas as combinações de pares.
4. **Cálculo dos pesos.** `count(Source, Target, name = "Weight")`.
5. **Exportação para o Gephi.** `nodes_*.csv` (`Id`, `Label`, `Frequency`) e `edges_*.csv` (`Source`, `Target`, `Weight`).

> ⚠️ **Nota de replicação sobre as arestas.** O arquivo do **Instagram** contém **2.256 linhas**, mas apenas **1.569 pares não-direcionados únicos**: a geração usa `combn(tags, 2)` **sem ordenar previamente o par**, de modo que a mesma relação aparece, em muitos casos, em duas linhas (p. ex. `viral→fyp` com peso 145 e `fyp→viral` com peso 147). Ao importar como rede **não-direcionada** no Gephi, esses pares recíprocos são fundidos. No **TikTok**, o pipeline já canoniza a ordem, produzindo **430 arestas únicas**. Para replicação exata, ordenar o par dentro de cada post antes do `combn`; a leitura analítica não se altera, pois a rede é não-direcionada em ambos os casos.

**Indicadores das redes:**

| Indicador | Instagram | TikTok |
|---|---|---|
| Nós | 111 | 47 |
| Arestas (linhas no CSV) | 2.256 | 430 |
| Pares não-direcionados únicos | 1.569 | 430 |
| Peso total das arestas | 22.471 | 4.244 |
| Densidade | 0,262 | 0,415 |
| Grau médio | 28,3 | 18,3 |
| Comunidades (Modularity, res. 1,0) | 3 | 3 |
| Modularidade (Q) | 0,329 | 0,148 |

### 6.2 Espinha dorsal (disparity filter)

**Script:** `Disparity filter Instagram.R` / `Dispatity filter titok.R`

**O problema.** As redes de coocorrência são densas e dominadas por hubs onipresentes: no Instagram, `viral` coocorre com 83% dos nós, `fyp` com 81%, `estelionato` com 75%, e mais de um terço das arestas representa coocorrências triviais (peso ≤ 2). Sob essas condições nenhum layout dirigido por forças separa os agrupamentos — o resultado é um emaranhado ilegível (*hairball*), em que a estrutura de comunidades existe nas métricas mas não é visualmente comunicável.

**A solução.** O **disparity filter** (Serrano, Boguñá & Vespignani, 2009) extrai a espinha dorsal (*backbone*) sem arbitrar um limiar de peso no olho. Para cada nó *i* de grau *k*, cada aresta incidente recebe um peso normalizado **p_ij = w_ij / s_i** (fração da força total do nó que passa por aquela aresta), e calcula-se a significância **α_ij = (1 − p_ij)^(k−1)**. Mantêm-se as arestas significativas (α abaixo do limiar) **para pelo menos um dos extremos**, o que preserva as conexões localmente relevantes de cada nó — inclusive as dos nós pequenos, que de outro modo seriam apagados pelos hubs.

**Limiar adotado: α < 0,10.**

| Rede | Completa | Backbone (α < 0,10) |
|---|---|---|
| Instagram | 111 nós · 1.569 arestas · densidade 0,262 | **88 nós · 273 arestas · densidade 0,071** |
| TikTok | 47 nós · 430 arestas · densidade 0,415 | **40 nós · 86 arestas** |

> **A espinha dorsal é usada apenas para a visualização e a leitura dos clusters.** Todas as métricas estruturais reportadas (centralidade, modularidade, grau ponderado, densidade) continuam a ser calculadas **sobre a rede completa**, para não descartar informação.

**Alternativa sem código:** plugin **Disparity** do Gephi (*Statistics → Disparity*), seguido de filtro `alpha < 0.10` em *Filters → Edges*. Para reprodutibilidade exata, recomenda-se o script. O pacote R **`backbone`** oferece `disparity()` com saída equivalente, útil para checagem cruzada.

**Assimetria de tratamento e sua justificativa.** A rede do Instagram, substancialmente maior e mais densa, reteve um emaranhado visual residual mesmo após o disparity filter. Para dissolvê-lo, aplicou-se **apenas ao Instagram** um corte adicional de peso de aresta (**≥ 7**), **exclusivamente para legibilidade da figura**. O impacto estrutural é desprezível: remove 1 nó (`digital`) e 5 arestas de baixo peso (de 88/273 para 87/268), mantendo inalterados densidade, número de comunidades e partição. O TikTok, por ser menor, não exigiu esse passo. A assimetria decorre de uma diferença real de tamanho entre os corpora, não de inconsistência de método — e afeta **apenas a renderização**, não a análise.

### 6.3 Layout, comunidades e centralidades (Gephi)

**Importação.** `nodes_*.csv` como **Nodes Table** e `edges_*.csv` como **Edges Table**. O grafo é definido como **Undirected**, coerente com a natureza simétrica da coocorrência (A coocorre com B se e somente se B coocorre com A).

**ForceAtlas2 (layout).** Layout dirigido por forças: nós que coocorrem com frequência se atraem; nós sem ligação se repelem. O resultado espacial faz emergir visualmente os agrupamentos. Ativados **em ambas as redes**: **LinLog mode** (acentua a separação entre comunidades), **Dissuade Hubs** (evita que os hubs dominem o centro), **Prevent Overlap** e **Edge Weights invertidos**. Os parâmetros numéricos diferem por tamanho da rede:

| Parâmetro | Instagram | TikTok |
|---|---|---|
| Escala (*scaling*) | 20 | 50 |
| Gravidade | 0,8 | 1,0 |
| Aproximação (Barnes-Hut θ) | 0,5 | 1,2 |
| *Approximate Repulsion* | ligado | — |

O layout foi deixado convergir até a estabilização visual dos nós.

**Modularity, Degree e Weighted Degree.** O algoritmo de **Modularity** (resolução 1,0) particiona a rede em comunidades e atribui a cada nó uma `Modularity Class`; é essa partição que, projetada nas cores, revela os blocos temáticos. **Degree** é o nº de vizinhos; **Weighted Degree**, a soma dos pesos das arestas do nó — a métrica de centralidade **mais informativa** aqui, pois distingue uma hashtag que coocorre muitas vezes com poucas parceiras de uma que coocorre com muitas.

> **Nota sobre estabilidade:** o algoritmo de Modularity é estocástico e o número de comunidades é sensível à resolução. Com resolução 1,0 e execuções repetidas, a **partição em 3 comunidades mostrou-se estável em ambas as redes**.

**Ajustes visuais:**

| Ajuste | Configuração | Por quê |
|---|---|---|
| Tamanho dos nós | Ranking por `Frequency` | comunica de imediato as hashtags dominantes |
| Cor dos nós | Partition por `Modularity Class` | torna visível a segmentação temática |
| Espessura das arestas | Ranking por `Weight` | destaca as coocorrências mais sistemáticas |
| Rótulos | **tamanho uniforme** (não proporcional ao nó) | para que o vocabulário técnico-jurídico de baixa frequência (`pix`, `golpedopix`, `consultavel`, `advocaciacriminal`) permaneça legível e seu cluster não seja visualmente apagado |

> ⚠️ **A cor significa coisas diferentes nas redes individuais e na combinada.**
>
> - **Figuras 1 e 2 (redes individuais):** cor = **comunidade temática** — 🟠 laranja: eixo criminal-jurídico-financeiro · 🟣 roxo: eixo de viralização · 🟢 verde: eixo de estilo de vida/enriquecimento.
> - **Figura 3 (rede combinada):** cor = **origem do nó** — 🔵 azul-claro: presente em ambas as plataformas · ⚪ cinza: exclusivo do Instagram · 🟢 verde: exclusivo do TikTok.
>
> Como o verde assume sentidos distintos entre os dois tipos de figura, **cada figura traz legenda própria** explicitando o que a cor representa naquela imagem — condição necessária para a leitura correta do conjunto.

### 6.4 Construção da rede combinada

**Arquivo:** `data/network/rede_combinada_instagram_tiktok.xlsx`

A rede combinada une o vocabulário das duas plataformas num único grafo, atribuindo a cada nó e a cada aresta um rótulo de **origem** (presente em ambas / só Instagram / só TikTok), o que torna a sobreposição diretamente mensurável.

**Método — distinto do das redes individuais:**

- **não se aplica o disparity filter**: o propósito não é extrair espinha dorsal para leitura de clusters, mas mapear o compartilhamento de vocabulário;
- a rede é a **união** dos conjuntos de nós e de arestas das duas redes;
- **os pesos não são somados em bruto.** Como os corpora têm tamanhos muito diferentes (3.126 vs 1.737 publicações com hashtag), somá-los faria o Instagram dominar o grafo por puro volume — um artefato de coleta. Em vez disso, os pesos das arestas são normalizados por corpus (**coocorrências por 1.000 publicações**) e as frequências dos nós, como **percentual das publicações de cada base**;
- o valor de um nó/aresta presente em ambas é a **média das duas métricas relativas**;
- cada elemento carrega o atributo `origem`, que governa a cor da figura.

**Resultado:** 117 nós e 1.690 arestas. A repartição por origem está documentada na própria planilha e analisada no artigo.

> ⚠️ **Ressalva de replicação.** Esta etapa foi executada em planilha, não em script R versionado — é o único ponto do pipeline sem código correspondente em `scripts/`.

### 6.5 Quadro-resumo (rede completa vs. espinha dorsal)

As métricas analíticas reportadas referem-se à **rede completa**; a espinha dorsal é a base das **figuras**.

| Rede | Nós (completa) | Arestas (completa) | Densidade | Nós (backbone) | Arestas (backbone) | Comunidades | Q |
|---|---|---|---|---|---|---|---|
| Instagram | 111 | 1.569 ¹ | 0,262 | 88 (87) ² | 273 (268) ² | 3 | 0,329 |
| TikTok | 47 | 430 | 0,415 | 40 | 86 | 3 | 0,148 |
| Combinada | 117 | 1.690 | — | n/a ³ | n/a ³ | — | — |

¹ Pares não-direcionados únicos (o arquivo tem 2.256 linhas por duplicação recíproca;
² Entre parênteses, os valores após o corte adicional de peso (≥ 7) aplicado somente ao Instagram para legibilidade da figura.
³ A rede combinada não usa backbone 

---

## 7. Organização do repositório

```
.
├── README.md                  ← este arquivo (percurso metodológico completo)
├── README.en.md               ← versão em inglês
├── CITATION.cff               ← metadados de citação (lidos pelo GitHub e pelo Zenodo)
├── .zenodo.json               ← metadados do depósito Zenodo (DOI por release)
├── ETHICS.md                  ← protocolo ético e de anonimização
├── .gitignore
│
├── data/
│   │   ├── dataset_anonimizado_instagram.xlsx
│   │   └── dataset_anonimizado_tiktok.xlsx
│   ├── processed/             ← frequências, cortes, bases limpas
│   │   ├── frequencia3_instagram.csv
│   │   ├── hashtags_freq10.csv
│   │   ├── hashtags_freq20.csv
│   │   ├── frequencias_tiktok.xlsx
│   │   ├── dataset_consolidado_instagram_limpo.csv   (= instagram_limpo.xlsx)
│   │   └── tiktok_limpo.xlsx
│   └── network/               ← entrada do Gephi
│       ├── nodes_instagram.csv / edges_instagram.csv
│       ├── nodes_tiktok.csv / edges_tiktok.csv
│       ├── nodes_*_backbone.csv / edges_*_backbone.csv
│       └── rede_combinada_instagram_tiktok.xlsx
│
├── scripts/                   ← ordem de execução em §8.2
│   ├── Estatísticas descritivas do corpus.R
│   ├── Análise de frequência de hashtags – Instagram.R
│   ├── Análise de frequência de hashtags – TikTok.R
│   ├── Ler e padronizar o dicionário instagram.R
│   ├── Ler e padronizar o dicionário tiktok.R
│   ├── Construção dos nós e arestas instagram.R
│   ├── Construção dos nós e arestas tiktok.R
│   ├── Disparity filter Instagram.R
│   └── Dispatity filter titok.R          ← [sic] grafia original preservada
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
    ├── documento_metodologico_integrado.docx  ← memória metodológica completa
    ├── documento_metodologico_integrado.md    ← mesma versão em Markdown
    ├── Notas_metodológicas.docx               ← notas de coleta
    └── sessioninfo.txt                        ← saída de sessionInfo() («confirmar»)
```

### Estado dos componentes

| Componente | Onde está | Estado |
|---|---|---|
| Documentação metodológica completa | [`docs/`](docs/) | ✅ |
| Scripts em R do pipeline (bruto → Gephi) | [`scripts/`](scripts/) | ✅ |
| Dicionários de codificação M/U/R | [`dictionaries/`](dictionaries/) | ⬜ a depositar |
| Bases mestras e planilhas intermediárias | [`data/`](data/) | ⬜ a depositar |
| Arquivos de nós e arestas para o Gephi | [`data/network/`](data/network/) | ⬜ a depositar |
| Figuras das redes (Gephi) | [`figures/`](figures/) | ⬜ a depositar |

> ⬜ = diretório e documentação já preparados; os arquivos devem ser copiados pela equipe. Cada pasta tem um `README.md` local com a lista exata dos arquivos esperados e seus nomes canônicos.

> **Nota sobre os nomes dos scripts.** Os nomes acima são os nomes reais dos arquivos, com espaços, acentos e as grafias originais (`Dispatity filter titok.R`), preservados para que a documentação corresponda exatamente ao conteúdo do repositório. Se a equipe optar por renomeá-los ([§8.3](#83-sugestão-opcional-de-renomeação)), **esta seção e a §8.2 devem ser atualizadas na mesma alteração**.

---

## 8. Instruções para reproduzir

### 8.1 Requisitos e instalação

```bash
git clone https://github.com/<ORG>/estelionato-hashtag-networks.git
cd estelionato-hashtag-networks
```

```r
install.packages(c(
  "readxl", "dplyr", "tidyr", "stringr",
  "purrr", "igraph", "writexl", "openxlsx"
))

library(readxl);  library(dplyr);  library(tidyr)
library(stringr); library(purrr);  library(igraph)
library(writexl); library(openxlsx)
```

Além disso: **Gephi ≥ 0.10** para as visualizações (opcionalmente com o plugin **Disparity/Backbone**).

> **Caminhos.** Os caminhos de pasta nos scripts foram anonimizados para `caminho/do/projeto/`. Antes de executar, substituí-los pelos caminhos locais — ou, preferencialmente, pelos caminhos relativos deste repositório (`data/raw/`, `data/processed/`, `data/network/`).

### 8.2 Execução passo a passo

Os scripts são executados **nesta ordem**, que não coincide com a ordem alfabética dos arquivos. Cada linha indica o bloco correspondente do **Apêndice B** do documento metodológico, onde está o código comentado.

| Ordem | Script | Apêndice B | Entrada | Saída |
|---|---|---|---|---|
| 1 | `Estatísticas descritivas do corpus.R` | B.15 | `data/raw/dataset_consolidado_*.xlsx` | totais de hashtags e de posts com/sem hashtag (IG: 21.812 · 3.611/3.126/485 — TT: 9.149 · 1.957/1.737/220) |
| 2 | `Análise de frequência de hashtags – Instagram.R`<br>`Análise de frequência de hashtags – TikTok.R` | B.2–B.6 | base mestra | `data/processed/frequencia3_instagram.csv`, `hashtags_freq10.csv`, `hashtags_freq20.csv`, `frequencias_tiktok.xlsx` |
| 3 | *(codificação humana — não automatizável)* | §6 do doc. | `hashtags_freq10.csv` (291 / 103) | `dictionaries/dicionario_*.xlsx` |
| 4 | `Ler e padronizar o dicionário instagram.R`<br>`Ler e padronizar o dicionário tiktok.R` | B.7–B.9 | base mestra + dicionário | `data/processed/*_limpo.{csv,xlsx}` (coluna `hashtags_limpas`) |
| 5 | `Construção dos nós e arestas instagram.R`<br>`Construção dos nós e arestas tiktok.R` | B.10–B.14 | base limpa | `data/network/nodes_*.csv`, `edges_*.csv` |
| 6 | `Disparity filter Instagram.R`<br>`Dispatity filter titok.R` | B.16–B.17 | nós + arestas | `data/network/nodes_*_backbone.csv`, `edges_*_backbone.csv` |
| 7 | *(Gephi — ver §8.4)* | §9 do doc. | arquivos de rede | métricas (`Degree`, `Weighted Degree`, `Modularity Class`) e figuras |
| 8 | *(planilha — sem script)* | §11.6 do doc. | ambas as redes | `data/network/rede_combinada_instagram_tiktok.xlsx` |

> **A etapa 3 é humana e não automatizável:** é o momento da codificação M/U/R. Os dicionários resultantes estão versionados em `dictionaries/`, de modo que **o pipeline é reproduzível de ponta a ponta sem repetir a codificação**.

> **A etapa 8 ainda não tem script versionado.** A rede combinada foi montada em planilha, com a normalização por corpus descrita em [§6.4](#64-construção-da-rede-combinada). Convertê-la em script R é a pendência de reprodutibilidade mais relevante do repositório.

### 8.3 Sugestão (opcional) de renomeação

Os nomes atuais têm espaços, acentos e duas grafias divergentes (`Dispatity filter titok.R`), o que dificulta `source()` em outros sistemas e a citação estável no artigo. Caso a equipe decida padronizar:

| Nome atual | Sugestão |
|---|---|
| `Estatísticas descritivas do corpus.R` | `01_estatisticas_descritivas.R` |
| `Análise de frequência de hashtags – Instagram.R` | `02_frequencias_instagram.R` |
| `Análise de frequência de hashtags – TikTok.R` | `02_frequencias_tiktok.R` |
| `Ler e padronizar o dicionário instagram.R` | `03_aplicar_dicionario_instagram.R` |
| `Ler e padronizar o dicionário tiktok.R` | `03_aplicar_dicionario_tiktok.R` |
| `Construção dos nós e arestas instagram.R` | `04_rede_instagram.R` |
| `Construção dos nós e arestas tiktok.R` | `04_rede_tiktok.R` |
| `Disparity filter Instagram.R` | `05_backbone_instagram.R` |
| `Dispatity filter titok.R` | `05_backbone_tiktok.R` |


### 8.4 Reprodução das figuras no Gephi

1. Importar `nodes_*_backbone.csv` como **Nodes Table** e `edges_*_backbone.csv` como **Edges Table**.
2. Definir o grafo como **Undirected**.
3. Rodar **Statistics → Modularity** (resolução 1,0) e **Average Degree**.
4. Aplicar **ForceAtlas2** com os parâmetros de [§6.3](#63-layout-comunidades-e-centralidades-gephi); deixar convergir até estabilização visual.
5. Ajustes visuais: tamanho por `Frequency`, cor por `Modularity Class`, espessura por `Weight`, rótulos uniformes.
6. **Instagram apenas:** aplicar o filtro adicional **Edge Weight ≥ 7**.

> Lembrar que **as métricas analíticas reportadas vêm da rede completa**, não do backbone: para reproduzi-las, importar `nodes_*.csv` / `edges_*.csv` (sem `_backbone`) e rodar as mesmas estatísticas.

---

## 9. Dicionário de dados


**`nodes_<plataforma>.csv`**

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | string | hashtag na forma canônica (chave primária) |
| `Label` | string | idêntico a `Id`; rótulo exibido no Gephi |
| `Frequency` | int | nº de publicações em que a hashtag canônica aparece (**presença-por-post**, após unificações) |

**`edges_<plataforma>.csv`**

| Coluna | Tipo | Descrição |
|---|---|---|
| `Source` | string | hashtag A (referencia `nodes.Id`) |
| `Target` | string | hashtag B (referencia `nodes.Id`) |
| `Weight` | int | nº de publicações em que A e B coocorrem |
| `Type` | string | sempre `Undirected` (presente nos arquivos de backbone) |

**`dicionario_<plataforma>.xlsx`**

| Coluna | Tipo | Descrição |
|---|---|---|
| `tags` | string | hashtag original observada |
| `ação` | enum | `M` (manter) · `U` (unificar) · `R` (remover) |
| `substituir por` | string | forma canônica; preenchida apenas quando `ação = U` |
| `n` | int | frequência bruta observada *(TikTok)* |
| `justificativa` | string | racional da decisão *(TikTok)* |
| `ambiguo` | bool | sinalização para validação humana *(TikTok)* |



---

## 10. Limitações e ressalvas

Estas ressalvas são parte do desenho da pesquisa e devem acompanhar qualquer citação dos resultados.

**1. A assimetria de tamanho é, em parte, artefato de coleta.** O corpus do Instagram é ~1,8× maior (3.611 vs 1.957), mas isso **não reflete necessariamente um ecossistema discursivo menor no TikTok** — decorre sobretudo do teto de raspagem imposto pela plataforma. Em consequência, todos os indicadores **absolutos** (nº de nós, arestas, peso total) devem ser lidos com cautela, privilegiando-se a **estrutura relativa** (proporções, posições, densidade, modularidade) sobre as magnitudes brutas.

**2. Efeito de seleção das sementes (reflexividade amostral).** Como o corpus foi construído a partir de seis hashtags-semente, **essas mesmas hashtags tendem a ser, por construção, as mais frequentes e mais centrais**. Sua centralidade deve ser interpretada como **parcialmente induzida pelo desenho amostral**, não como achado emergente. O valor analítico das redes está (i) no que **coocorre** com as sementes — o vocabulário associado que não foi buscado diretamente — e (ii) nas **comparações entre plataformas**, em que o desenho amostral é idêntico e, portanto, se cancela.

**3. Sem janela temporal controlada.** As plataformas não permitem filtro de datas na busca por hashtag. O corpus é um recorte do disponível no momento da captura.

**4. Assimetria no tratamento visual.** O corte adicional de peso ≥ 7 aplicado apenas ao Instagram afeta **apenas a renderização**, não a análise: impacto de 1 nó e 5 arestas, com densidade, número de comunidades e partição inalterados. Todas as métricas reportadas são da rede completa ([§6.2](#62-espinha-dorsal-disparity-filter)).

**5. A rede combinada e a assimetria de origem.** A forte diferença entre nós exclusivos do Instagram e do TikTok reflete, em parte, o corpus maior e mais diverso do Instagram e o teto de raspagem que limitou o TikTok — **não apenas uma diferença de riqueza discursiva**. Essa ressalva é declarada na legenda da figura.

**6. Metadados textuais, não conteúdo audiovisual.** A análise de redes opera sobre hashtags e não captura o vídeo. Essa lacuna é endereçada — não eliminada — pela dimensão etnográfica ([§2.4](#24-dimensão-etnográfica-complementar)).

**7. Duplicação recíproca de arestas no arquivo do Instagram.** Ver a nota de replicação em [§6.1](#61-construção-das-redes). Não altera a leitura analítica (a rede é não-direcionada), mas exige atenção em qualquer recontagem direta do CSV.

**8. A rede combinada não tem script versionado.** Foi montada em planilha ([§6.4](#64-construção-da-rede-combinada)). Até que seja convertida em código, essa etapa é **documentada mas não automaticamente reproduzível**.

---

## 11. Ética e proteção de dados

Protocolo completo em **[ETHICS.md](ETHICS.md)**.

A natureza do objeto — comunidades que operam regimes de visibilidade ambíguos e veiculam representações explícitas de atos potencialmente enquadráveis como criminosos — impõe cuidados éticos específicos, **sob risco de a própria pesquisa expor as pessoas que publicam esse conteúdo a reações persecutórias**. Medidas adotadas: **anonimização** dos nomes de usuário mencionados no texto; **referência indireta** aos dados de campo, evitando descrições que permitam identificar perfis ou publicações específicas; e **omissão dos IDs** das publicações referenciadas.

> A ética da pesquisa é assumida como **constitutiva de sua construção**, e não como camada de conformidade aposta *a posteriori*: as escolhas de não interação (não curtir, não comentar), de anonimização e de referência indireta são parte do desenho do estudo, não apenas salvaguardas formais.

**Consequência para este repositório.** As bases depositadas em `data/raw/` devem ser versões **sem campos de autoria, IDs e URLs**; a remoção desses campos é condição para qualquer commit nesse diretório — `«confirmar»`: definir se será feita por script versionado (a criar) ou por procedimento manual documentado em `ETHICS.md`. O acervo etnográfico ([§2.4](#24-dimensão-etnográfica-complementar)) não é depositado.

---

## 12. Referências

- **Serrano, M. Á., Boguñá, M., & Vespignani, A.** (2009). Extracting the multiscale backbone of complex weighted networks. *Proceedings of the National Academy of Sciences*, 106(16), 6483–6488. https://doi.org/10.1073/pnas.0808904106
- **Jacomy, M., Venturini, T., Heymann, S., & Bastian, M.** (2014). ForceAtlas2, a continuous graph layout algorithm for handy network visualization designed for the Gephi software. *PLoS ONE*, 9(6), e98679. https://doi.org/10.1371/journal.pone.0098679
- **Blondel, V. D., Guillaume, J.-L., Lambiotte, R., & Lefebvre, E.** (2008). Fast unfolding of communities in large networks. *Journal of Statistical Mechanics*, P10008. https://doi.org/10.1088/1742-5468/2008/10/P10008
- **Bastian, M., Heymann, S., & Jacomy, M.** (2009). Gephi: an open source software for exploring and manipulating networks. *ICWSM*.
- **Peeters, S., & Hagen, S.** (2022). The 4CAT Capture and Analysis Toolkit: A modular tool for transparent and traceable social media research. *Computational Communication Research*, 4(2), 571–589.
- **Hine, C.** (2015). *Ethnography for the Internet: Embedded, Embodied and Everyday*. London: Bloomsbury.

---

