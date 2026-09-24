# Hashtag co-occurrence networks in the discursive ecosystem of fraud (*estelionato*)

**Instagram and TikTok · a comparative mapping of digital financial-crime discourse**

[![DOI](https://zenodo.org/badge/1326909787.svg)](https://doi.org/10.5281/zenodo.22943099)

> 🇧🇷 A Portuguese version of this README is available at **[README.md](README.md)**.

This repository is the versioning, documentation and reproduction environment for the research that maps and compares the discursive ecosystems associated with *estelionato* (fraud), financial scams, illicit monetisation and virality strategies on **Instagram** and **TikTok**, through **hashtag co-occurrence networks**.

It brings together the data, the R scripts, the coding dictionaries, the figures and the full methodological record underpinning the international article and the book chapter derived from the project.

This README documents the **methodological pathway**. The empirical results (centralities, communities, cross-platform comparison) are in the article and in the full methodological record, at [`docs/documento_metodologico_integrado.docx`](docs/).

---

## Contents

- [1. Research objectives](#1-research-objectives)
- [2. Collection strategy](#2-collection-strategy)
- [3. Queries used](#3-queries-used)
- [4. Tools and versions](#4-tools-and-versions)
- [5. Data processing procedures](#5-data-processing-procedures)
- [6. Full analytical workflow](#6-full-analytical-workflow)
- [7. Repository structure](#7-repository-structure)
- [8. Data dictionary](#8-data-dictionary)
- [9. Limitations and caveats](#9-limitations-and-caveats)
- [10. Ethics and data protection](#10-ethics-and-data-protection)
- [11. References](#11-references)

---

## 1. Research objectives

**This research investigates the digital discursive ecosystems associated with fraud, financial scams, illicit monetisation and virality strategies on Instagram and TikTok**. The object is not an isolated piece of fraudulent content, but the collective grammar through which that content is produced, tagged and distributed: the set of markers (hashtags) that producers use to inscribe their posts into circuits of visibility, community and market.

The platform as part of the phenomenon. Instagram and TikTok are not treated here as data sources, but as participants in the production and transformation of the phenomenon under analysis. The architecture of each environment imposes grammars of visibility that organise how this discourse circulates: hashtags operate as self-declarations of belonging — by tagging a post, the author deliberately positions it within a circuit of visibility, community and market; massive elongation `(#fypppppp)` and emoji decoration `(#fypシ)` are performances of algorithmic appeal induced by the infrastructure itself; and one and the same anchor hashtag can shift structural function depending on the environment. Crime, moreover, does not circulate alone: it is wrapped in entertainment and sold as a promise of enrichment. Hence the unit of analysis is the collective grammar, not the isolated fraudulent post.

**General objective:** To map and compare how digital financial-crime discourse is organised on each platform, treating the architecture of each environment as constitutive of the phenomenon rather than as a mere channel.

**Specific objectives**: To identify:

1. the recurrent thematic vocabulary;
2. the semantic clusters that structure the field (crime, wealth, virality, entertainment);
3. the personas and markers that act as bridges between those clusters;
4. the visibility strategies specific to each algorithmic environment;
5. whether the two platforms host the same discursive ecosystem and, if so, how each architecture modulates it.

Why co-occurrence networks. Three properties of the method justify the choice.

*(i)* Hashtags are self-declarations of belonging: by tagging a post, the author deliberately positions it within a discursive field, which makes the hashtag an observable trace of communicative intent.

*(ii)* Co-occurrence — two hashtags in the same post — reveals associations that are not explicit in any individual post but emerge from the aggregate pattern; it is co-occurrence that shows, for instance, that the vocabulary of fraud circulates systematically coupled to that of virality.

*(iii)* Graph representation makes it possible to apply formal metrics (centrality, modularity, weighted degree) that turn qualitative impressions into structural indicators comparable across platforms.

**Mirrored design**: The procedure developed for Instagram was reproduced in full for TikTok — same thresholds, same coding categories, same network-construction logic — adjusting only what was strictly imposed by differences in the structure of the datasets (essentially, the index of the hashtag column). This ensures that the differences observed between the final networks reflect real differences between the platforms, and not artefacts of method.

**Mixed design**: Network analysis maps the structure of the field at scale, but it operates on textual metadata and does not capture the audiovisual content of the videos — a central element on these platforms. The study is therefore complemented by an ethnographic dimension ([see 2.4](#24-complementary-ethnographic-dimension)).

---

## 2. Collection strategy

### 2.1 Instrumentation

Collection used **identical instrumentation** on both platforms — a condition of comparability.

- **Tool:** the [Zeeschuimer](https://github.com/digitalmethodsinitiative/zeeschuimer) browser extension connected to [4CAT](https://github.com/digitalmethodsinitiative/4cat) (Capture and Analysis Toolkit), capturing posts directly from browsing.
- **Accounts:** **new** accounts were created on TikTok and Instagram specifically for the collection, to avoid algorithmic personalisation of the feed by pre-existing histories.
- **Search:** by hashtag, from six seed hashtags common to both platforms ([see 3](#3-queries-used)).
- **Target:** ~500 posts per hashtag. **Reached on Instagram; not reached on TikTok**, because of the platform's pagination/scraping restrictions. This is the direct source of the size asymmetry between the corpora.

### 2.2 Consolidation into master datasets

The **6 input spreadsheets** for each platform (one per seed) were consolidated into a **single master dataset**, eliminating the fragmentation by search hashtag and allowing the whole to be treated as an integrated corpus.

### 2.3 Comparative table of the corpora

| Dimension | Instagram | TikTok |
|---|---|---|
| Collection tool | Zeeschuimer + 4CAT | Zeeschuimer + 4CAT |
| Accounts used | new, created for the collection | new, created for the collection |
| Seed hashtags | the 6 seeds | the same 6 seeds |
| Date filter | none (not available) | none (not available) |
| Target per hashtag | ~500 posts (**reached**) | ~500 posts (**not reached**) |
| Input spreadsheets | 6 (one per seed) | 6 (one per seed) |
| Master dataset [^1] | `dataset_consolidado_instagram.xlsx` | `dataset_consolidado_tiktok.xlsx` |
| **Total posts** | **3,611** | **1,957** |
| Metadata columns | — | 36 |
| Caption column | G | I (`body`) |
| Hashtag column | **S (index 19)** | **AD (`hashtags`, index 30)** |

[^1]: The consolidated datasets are shared exclusively in their anonymised form.

### 2.4 Complementary ethnographic dimension

Automated collection captures structured metadata but **does not capture the audiovisual content of the videos** — and much of the meaning of the object resides there (the performance of the scam, the staging of wealth, the group's visual codes). To address this gap, collection was complemented by an ethnographically oriented immersion, informed by Hine (2015), following this procedure:

1. an Instagram account **with no posts, no followers and no accounts followed** — a "clean" profile, with no history capable of biasing algorithmic curation;
2. starting from the **first video on the research object displayed in the "Explore" tab**, letting subsequent navigation be driven by the platform's own recommendations;
3. **no likes, no comments** — no interference in the field and no trace of interaction;
4. observational interaction limited to **opening comments and saving videos** through the platform's native feature.

This routine preserves the position of **non-participant observation**: the account emits no engagement signals that would feed back into the algorithm or be noticed by the profiles observed.

The resulting collection comprises **130 posts** selected on Instagram between **May and September 2025** — 81 of fraud (62.3%), 30 of simple theft (23.1%) and 19 of robbery with violence or grave threat (14.6%). It is **complementary, not substitutive**, to the quantitative corpus. For ethical reasons ([see 10](#10-ethics-and-data-protection)), **it is not deposited in this repository**: only its aggregate description is public.

---

## 3. Queries used

The search was conducted **by hashtag**. The six seed hashtags are **common to both platforms**, and each generated one input spreadsheet per platform (6 + 6 = 12 in total).

| # | Query (seed hashtag) | Instagram | TikTok |
|---|---|---|---|
| 1 | `#estelionato` | ✅ | ✅ |
| 2 | `#estelionatario` | ✅ | ✅ |
| 3 | `#raul` | ✅ | ✅ |
| 4 | `#happynation` | ✅ | ✅ |
| 5 | `#tropado7` | ✅ | ✅ |
| 6 | `#171` | ✅ | ✅ |

**Search parameters:**

| Parameter | Value |
|---|---|
| Search type | by hashtag (*hashtag search*) |
| Date filter | **none** — the platforms do not offer this option in hashtag search |
| Time window | not controlled; the corpus is a snapshot of what was available at the moment of capture |
| Capture period | *to be filled in* (month/year of the automated collection) |
| Language / region | no filter |

**Query deliberately excluded.** `#bigode` was removed from the seed set: the posts it retrieved drifted away from the object (they referred mostly to facial hair). Note that `bigode` **remains a node** in the final networks — not as a seed, but as a hashtag internal to the posts, where it designates the persona "Raul Bigode". Its exclusion as a query does not remove it from the discursive field captured by the other seeds.

**Sampling consequence to record.** By construction, the six seeds tend to be the most frequent and most central hashtags in the networks. Their centrality must be read as **partly induced by the sampling design**, not as an emergent finding ([see 9, point 2](#9-limitations-and-caveats)).

---

## 4. Tools and versions

| Layer | Tool | Role in the workflow |
|---|---|---|
| Collection | **Zeeschuimer** (browser extension) | capture of posts during browsing |
| Collection | **4CAT** — Capture and Analysis Toolkit | reception, storage and export of the captures (`.xlsx`/`.csv`) |
| Processing and networks | **R** | the entire pipeline from raw data to the Gephi files |
| Processing and networks | **RStudio** | execution environment |
| Visualisation and metrics | **Gephi** | layout, communities, centralities, figures |
| Visualisation (optional) | **Disparity / Backbone** plugin (Gephi) | code-free alternative to the disparity filter |
| Spreadsheets | Excel / LibreOffice | coding of the dictionaries and assembly of the combined network |

### R packages

| Package | Use |
|---|---|
| `readxl` | reading the master `.xlsx` datasets |
| `dplyr` | manipulation and counting |
| `tidyr` | `separate_rows()` in hashtag extraction |
| `stringr` | normalisation (`str_trim`, `str_split`) |
| `purrr` | `map_chr()` when applying the dictionary |
| `igraph` | graph, `strength`, `degree`, disparity filter |
| `writexl` / `openxlsx` | exporting the spreadsheets |
| `backbone` *(optional)* | cross-check of the disparity-filter implementation |

---

## 5. Data processing procedures

### 5.1 Initial inspection of the datasets

On both platforms, hashtags are stored as a **comma-separated list inside a single cell per post** (column S on Instagram, AD on TikTok), predominantly in lowercase and without the `#` character. This convergence of format is what makes the mirrored treatment viable.

Problems identified and how they were handled:

| Problem | Occurrence | Treatment | Stage |
|---|---|---|---|
| Posts with no hashtag | IG: 485 / TT: 220 (11.2%) | kept in the corpus; excluded from the network | Extraction |
| Internal duplication | TT: 62 posts (e.g. `viral,viral,paineldo7`) | deduplication by presence within the post | Cleaning / network |
| Attached emoji | TT: 164 posts (`fypシ`, `dinheiroonline💰`, `mulherdepreso🔓🕊👫💍`); IG: `brasil🇧🇷`, `viralpost❤️` | unification to the clean textual form | Dictionary (U) |
| Uppercase | TT: 5 posts | conversion to lowercase (`tolower()`) | Normalisation |
| Spelling/language variants | `dinheiro`/`money`, `viral`/`viralvideo`, `fouryou` | unification to a canonical form | Dictionary (U) |
| Elongations | TT: `fyppppppppppppppppppppppp` (39×), `paratiiii…` (21×), `fyyyyyyyyyyyyyyyy` (33×) | unification to the base form | Dictionary (U) |

> **Finding at this stage:** the two corpora share the same modes of "noise". This is itself a result: tagging practices on the two platforms follow similar grammars of virality (elongating `fyp`, decorating with emoji, repeating the appeal to the algorithm). The methodological consequence is that the same set of procedures applies to both datasets, validating the mirrored strategy.

### 5.2 Extraction and frequency counts

**Script:** `Análise de frequência de hashtags – Instagram.R` / `– TikTok.R`

The procedure: select the hashtag column (index 19 on IG; column `hashtags`/AD on TT), split the list-cell with `separate_rows(sep = ",")` — one row per occurrence —, normalise each token with `str_trim()` and `tolower()`, discard empty values and `NA`, and count with `count(tags)`.

> **Essential methodological point.** At this stage frequency is counted **by raw occurrence**, not by presence in the post: a hashtag repeated within the same post is counted more than once. Intra-post deduplication only enters later, at two moments — (i) in the cleaning function (`unique()` over the resolved hashtags of each post) and (ii) in network construction (`unique()` before generating the pairs). Thus **the frequency table and the thresholds operate on raw occurrences**, whereas **node `Frequency` and edge weights operate on presence-per-post**. That is why a hashtag's frequency in the table is generally slightly higher than its frequency as a node.

| Metric | Instagram | TikTok |
|---|---|---|
| Raw occurrences (official count) | 21,812 | 9,149 |
| Distinct hashtags | 5,048 | 2,967 |
| Posts with hashtags | 3,126 | 1,737 |
| Posts without hashtags | 485 | 220 |
| Hashtags with n ≥ 3 | 963 | 425 |
| **Hashtags with n ≥ 10 (threshold adopted)** | **291** | **103** |
| Hashtags with n ≥ 20 | 138 | 51 |

*(For reference: intra-post deduplication would remove 91 repetitions on TikTok, reducing the total to 9,058 — but the official count, as in the script, is the raw one.)*

**Justification for the n ≥ 10 threshold.** Three cut-off points (≥3, ≥10, ≥20) were tested on both platforms. The ≥ 10 threshold was chosen because it (i) **preserves thematic diversity** — it does not discard relevant semantic fields of moderate frequency; (ii) **removes a great deal of noise** — it eliminates the long tail of idiosyncratic hashtags, typos and single-occurrence terms; (iii) **keeps the set manageable** — it makes manual coding of each hashtag feasible, which would be unworkable with the 963/425 hashtags of the ≥3 cut. The effect is comparable across datasets: Instagram goes from 5,048 to 291 candidates (5.8% of the vocabulary) and TikTok from 2,967 to 103 (3.5%).

### 5.3 Analytical dictionaries (M/U/R)

**A human, non-automatable stage.** The hashtags with n ≥ 10 were exported and coded. On **Instagram**, manually, item by item. On **TikTok**, **semi-automatically**: each hashtag received a preliminary classification generated from the criteria and the Instagram dictionary used as an analytical model (direct matching of equivalents, detection of variants, application of the thematic rules), followed by human review and explicit flagging of ambiguous cases.

**The three categories:**

| Code | Meaning | Effect |
|---|---|---|
| **M** | *Manter* (keep) | the hashtag belongs to the object and is preserved as a node |
| **U** | *Unificar* (unify) | it is a variant of another form; replaced by the canonical form in `substituir por` |
| **R** | *Remover* (remove) | it is noise with no thematic relation; eliminated |

**Criteria.**

- **Keep (M):** fraud, scams, criminality, security, monetisation, entrepreneurship, enrichment, digital marketing, platforms, virality, content circulation and the ecosystem's central personas. E.g.: `estelionato`, `dinheiro`, `golpe`, `171`, `cc`, `cartaoclonado`, `raul`, `tropado7`, `happynation`, `fyp`, `viral`.
- **Remove (R):** fandoms, celebrities, football, unrelated music/characters, memes with no thematic link, irrelevant foreign-language hashtags, spam and algorithmic noise. IG: `realmadrid`, `snowman`, `gato`, the whole `asensio` constellation, `airmaxtn`. TT: `gta`, `games`, `house`, `edit`, `lyrics`, `tipografia`, `capcut`, `rj`, `carros`.
- **Unify (U):** spelling variations, singular/plural, accentuation, cross-language equivalents, emoji-bearing versions and virality variants. IG: `dinheirofácil` → `dinheiroextra`, `rendaextra` → `dinheiroextra`, `fy` → `fyp`, `fypage` → `fyp`, `reelsinstagram` → `reels`. TT: `money` → `dinheiro`, `foryou` → `fyp`, `viralvideos` → `viral`, `luxury` → `luxo`.

**Main canonical cores** (the same on both platforms):

| Core | Absorbs |
|---|---|
| `fyp` | `fy`, `foryou`, `foryoupage`, `fouryou`, `fypage`, `fypシ`, `fypp`, all elongations, `vaiprofycaramba`; on TT also `parati` and its elongations; on IG it coexists with `explore` and `reels` (and `feed` → `fyp`) |
| `viral` | `viraliza`, `viralvideo(s)`, `viraltiktok`, `videoviral`, `viral_video`; `trend` → `trending` |
| `dinheiro` | `money` → `dinheiro`; on IG the income bundle (`rendaextra`, `rendafixa`, `dinheirofácil`, `viradadesaldo`) converges on `dinheiroextra` |
| `marketingdigital` | IG: `market`, `marketing`, `mktdigital`; on TT the field appears mainly via `tiktokshop` and `trabalhecomartistas` (ambiguous) |
| `estilo` | `estilodevida` (IG), `lifestyle` (TT) |
| `luxo` | `luxury`, `luxurylife`, `luxurylifestyle`, `mansion` (TT); on IG the field also includes `oldmoney`, `grife` and brand names |
| `musica` | `music`, `song(s)`, `slowed`, `slowedsongs`, `phonk` (TT) |
| group codes | `171`, `7`, `77`, `777`, `tropado7` kept; `tropado777`/`tropadosete` → `tropado7`; `happy` → `happynation` |

> **A deliberate decision:** the entertainment layer (`musica`, `funk`, `humor`, `meme`) was kept as **M**, not removed. It is not noise: it is the **cultural wrapper** in which criminal discourse is distributed — an analytical finding, not a discard.

**Hierarchical rule for ties.** `U` when there is clear semantic equivalence with a canonical form; `R` when the hashtag unequivocally belongs to an external field (gaming, video editing, fandom); `M` when it belongs to one of the research axes **or when Instagram had already coded it as M** (comparability takes priority).

**Ambiguous cases flagged for human validation (TikTok):** `ninoabravanel`/`nino` (34 occurrences; decision applied M, with an explicit recommendation to review — it may be fandom noise), `aceofbase` (a band; M for comparability with IG), `ruyter` and `mckelvinho` (personas of the corpus, kept as M because they co-occur with the criminal core; they require identification), `entregatiktok` (treated as an algorithmic appeal, U → `fyp`; it may be a delivery-service promotion), `status`, `casa`, `trabalhecomartistas`, `house`, `mansion`, `phonk` (borderline terms, with case-by-case decisions documented in the `justificativa` column).

**Distribution of the coding:**

| Category | Instagram (n=291) | TikTok (n=103) |
|---|---|---|
| M (keep) | 107 (36.8%) | 43 (41.7%) |
| U (unify) | 87 (29.9%) | 51 (49.5%) |
| R (remove) | 97 (33.3%) | 9 (8.7%) |

> **Findings from the coding.** (i) The proportion of **U is far higher on TikTok** (≈50% vs 30%): TikTok's vocabulary is more redundant, dominated by virality variants (`fyp`, `viral`, `parati`) that multiply into elongated and decorated forms. (ii) The proportion of **R is far lower on TikTok** (≈9% vs 33%): Instagram brought in much more fandom/football/brand noise, whereas TikTok concentrates more narrowly on the thematic field. (iii) In both, **the M core is stable and almost identical in content** — the first evidence that the two platforms host the same discursive ecosystem.

### 5.4 Applying the cleaning

**Script:** `Ler e padronizar o dicionário instagram.R` / `tiktok.R`

The script standardises the dictionary (`str_trim(tolower(tags))`, `str_trim(toupper(ação))`) and runs through each post applying, hashtag by hashtag: if **R**, remove; if **U**, replace with the canonical form; if **M**, keep; and finally eliminates duplicates within the same post — **including those that arise after unification** (e.g. `fy` and `foryou`, both becoming `fyp`).

The result is written to a **new column**, `hashtags_limpas`, preserving the original column.

| Output | Instagram | TikTok |
|---|---|---|
| File | `dataset_consolidado_instagram_limpo.csv` (= `instagram_limpo.xlsx`) | `tiktok_limpo.xlsx` |
| Posts | 3,611 | 1,957 |
| Hashtag columns | original + `hashtags_limpas` | `hashtags_original` + `hashtags_limpas` |

> **Difference in scope in the cleaned column (a technical replication point).** The `hashtags_limpas` column **preserves the long tail**: hashtags with n < 10 that are not in the dictionary pass through unchanged, since they are neither R nor U. The restriction to the coded vocabulary happens **only at the next stage**, in network construction. It is precisely this logic that takes Instagram from 291 candidates to 111 nodes.

**A real transformation example (TikTok):**

```
171, estelionato, estelionatario, 7, raul, viral, fyp, foryou, golpe, dinheiro
→
171, estelionato, estelionatario, 7, raul, viral, fyp, golpe, dinheiro
```

(`foryou` was unified to `fyp`, which was already present, and the resulting duplicate was eliminated.)

---

## 6. Full analytical workflow

```
┌──────────────┐   ┌──────────────────┐   ┌──────────────┐   ┌───────────────┐
│1. Collection │ → │2. Consolidation  │ → │3. Inspection │ → │4. Extraction  │
│ Zeeschuimer  │   │ 6 files →        │   │ audit of     │   │ + raw counts  │
│  + 4CAT      │   │ master dataset   │   │ noise        │   │               │
└──────────────┘   └──────────────────┘   └──────────────┘   └───────┬───────┘
                                                                     │
        ┌────────────────────────────────────────────────────────────┘
        ▼
┌───────────────┐   ┌──────────────┐   ┌───────────────┐   ┌────────────────┐
│5. Cut n≥10    │ → │6. Dictionary │ → │7. Cleaning    │ → │8. Network      │
│  (291 / 103)  │   │   M/U/R      │   │ R/U/M + dedup │   │ nodes + edges  │
└───────────────┘   └──────────────┘   └───────────────┘   └───────┬────────┘
                                                                   │
        ┌──────────────────────────────────────────────────────────┘
        ▼
┌──────────────────────┐   ┌───────────────────┐   ┌────────────────────┐
│9. Disparity filter   │ → │10. Gephi          │ → │11. Comparison      │
│ backbone (α < 0.10)  │   │ ForceAtlas2 +     │   │ + combined network │
│ visualisation only   │   │ Modularity+degree │   │ (spreadsheet)      │
└──────────────────────┘   └───────────────────┘   └────────────────────┘
```

**Chronological synthesis (stage → procedure → result), valid for both platforms:**

| # | Stage | Procedure | Result |
|---|---|---|---|
| 1 | Collection | search for the 6 seeds via Zeeschuimer + 4CAT, new accounts, no date filter, target ~500 posts/seed | raw material (IG: target reached; TT: limited by the platform's ceiling) |
| 2 | Consolidation | 6 spreadsheets → single master dataset | IG: 3,611 posts · TT: 1,957 posts |
| 3 | Inspection | audit of format, absences, duplications, emoji, uppercase, variants, elongations | map of inconsistencies and treatment plan |
| 4 | Extraction | comma splitting, normalisation, raw counting | IG: 5,048 distinct · TT: 2,967 distinct |
| 5 | Threshold | testing ≥3/≥10/≥20; choice of n ≥ 10 | candidates for coding — IG: 291 · TT: 103 |
| 6 | Coding | manual (IG) / semi-automatic (TT) classification into M/U/R | `dicionario_instagram.xlsx`; `dicionario_tiktok_preliminar.xlsx` / `_revisado.xlsx` |
| 7 | Cleaning | removal of R, replacement of U, retention of M, deduplication | `hashtags_limpas` column in the cleaned datasets |
| 8 | Network | coded vocabulary → nodes (`Frequency`) and edges (`Weight`) | `nodes_*.csv`, `edges_*.csv` |
| 9 | Backbone | disparity filter α < 0.10 (visualisation only) | IG: 88 nodes/273 edges · TT: 40 nodes/86 edges |
| 10 | Gephi | Undirected import, ForceAtlas2, Modularity, Degree/Weighted Degree, visual settings | IG: 111 nodes, Q=0.329 · TT: 47 nodes, Q=0.148 · both with 3 communities |
| 11 | Combined network | union of the vocabularies with weights normalised per corpus | `rede_combinada_instagram_tiktok.xlsx` (117 nodes, 1,690 edges) |

### 6.1 Building the networks

**Script:** `Construção dos nós e arestas instagram.R` / `tiktok.R`

**Definitions:**

| Element | Definition |
|---|---|
| **Node** | a hashtag in canonical form, after cleaning |
| **Edge** | a link between two hashtags that appear together in the same post (co-occurrence) |
| **Weight** | number of posts in which that pair co-occurs — determines edge thickness |
| **Frequency** | node attribute: number of posts in which the canonical hashtag appears — determines node size |
| **Co-occurrence** | the mechanism generating the edges: for a post with A, B, C, the pairs A–B, A–C, B–C are generated |

**Step by step:**

1. **Selection of the coded vocabulary.** The network is built only with the dictionary's hashtags (n ≥ 10), after removing R and applying U. The long tail stays out.
2. **Node generation.** Each surviving canonical form becomes a node; its `Frequency` is **recounted** on the cleaned data.
3. **Edge generation.** For each post, `unique()` on the hashtags and then `combn(tags, 2)` — all pair combinations.
4. **Weight calculation.** `count(Source, Target, name = "Weight")`.
5. **Export to Gephi.** `nodes_*.csv` (`Id`, `Label`, `Frequency`) and `edges_*.csv` (`Source`, `Target`, `Weight`).

**Network indicators:**

| Indicator | Instagram | TikTok |
|---|---|---|
| Nodes | 111 | 47 |
| Edges (rows in the CSV) | 2,256 | 430 |
| Unique undirected pairs | 1,569 | 430 |
| Total edge weight | 22,471 | 4,244 |
| Density | 0.262 | 0.415 |
| Average degree | 28.3 | 18.3 |
| Communities (Modularity, res. 1.0) | 3 | 3 |
| Modularity (Q) | 0.329 | 0.148 |

### 6.2 Backbone (disparity filter)

**Script:** `Disparity filter Instagram.R` / `Dispatity filter titok.R`

**The problem.** Co-occurrence networks are dense and dominated by omnipresent hubs: on Instagram, `viral` co-occurs with 83% of the nodes, `fyp` with 81%, `estelionato` with 75%, and more than a third of the edges represent trivial co-occurrences (weight ≤ 2). Under these conditions no force-directed layout can separate the clusters — the result is an illegible tangle (*hairball*), in which the community structure exists in the metrics but is not visually communicable.

**The solution.** The **disparity filter** (Serrano, Boguñá & Vespignani, 2009) extracts the backbone without arbitrating a weight threshold by eye. For each node *i* of degree *k*, each incident edge receives a normalised weight **p_ij = w_ij / s_i** (the fraction of the node's total strength passing through that edge), and the significance **α_ij = (1 − p_ij)^(k−1)** is computed. Edges that are significant (α below the threshold) **for at least one of their endpoints** are retained, which preserves each node's locally relevant connections — including those of small nodes, which would otherwise be erased by the hubs.

**Threshold adopted: α < 0.10.**

| Network | Complete | Backbone (α < 0.10) |
|---|---|---|
| Instagram | 111 nodes · 1,569 edges · density 0.262 | **88 nodes · 273 edges · density 0.071** |
| TikTok | 47 nodes · 430 edges · density 0.415 | **40 nodes · 86 edges** |

> **The backbone is used only for visualisation and for reading the clusters.** All reported structural metrics (centrality, modularity, weighted degree, density) continue to be computed **on the complete network**, so as not to discard information.

**Code-free alternative:** Gephi's **Disparity** plugin (*Statistics → Disparity*), followed by an `alpha < 0.10` filter in *Filters → Edges*. For exact reproducibility, the script is recommended. The R package **`backbone`** offers `disparity()` with equivalent output, useful as a cross-check.

**Asymmetry of treatment and its justification.** The Instagram network, substantially larger and denser, retained a residual visual tangle even after the disparity filter. To dissolve it, an additional edge-weight cut (**≥ 7**) was applied **to Instagram only**, **exclusively for the legibility of the figure**. The structural impact is negligible: it removes 1 node (`digital`) and 5 low-weight edges (from 88/273 to 87/268), leaving density, the number of communities and the partition unchanged. TikTok, being smaller, did not require this step. The asymmetry therefore follows from a real difference in size between the corpora, not from an inconsistency of method — and it affects **only the rendering**, not the analysis.

### 6.3 Layout, communities and centralities (Gephi)

**Import.** `nodes_*.csv` as the **Nodes Table** and `edges_*.csv` as the **Edges Table**. The graph is set as **Undirected**, consistent with the symmetrical nature of co-occurrence (A co-occurs with B if and only if B co-occurs with A).

**ForceAtlas2 (layout).** A force-directed layout: nodes that co-occur frequently attract each other; unconnected nodes repel each other. The spatial result makes the clusters visually emerge. Enabled **in both networks**: **LinLog mode** (accentuates separation between communities), **Dissuade Hubs** (prevents hubs from dominating the centre), **Prevent Overlap** and **inverted Edge Weights**. The numerical parameters differ according to network size:

| Parameter | Instagram | TikTok |
|---|---|---|
| Scaling | 20 | 50 |
| Gravity | 0.8 | 1.0 |
| Approximation (Barnes-Hut θ) | 0.5 | 1.2 |
| *Approximate Repulsion* | on | — |

The layout was left to converge until the nodes stabilised visually.

**Modularity, Degree and Weighted Degree.** The **Modularity** algorithm (resolution 1.0) partitions the network into communities and assigns each node a `Modularity Class`; it is this partition that, projected onto the colours, reveals the thematic blocks. **Degree** is the number of neighbours; **Weighted Degree**, the sum of a node's edge weights — the **most informative** centrality metric here, since it distinguishes a hashtag that co-occurs many times with few partners from one that co-occurs with many.

> **Note on stability:** the Modularity algorithm is stochastic and the number of communities is sensitive to the resolution parameter. At resolution 1.0 and across repeated runs, the **three-community partition proved stable in both networks**.

**Visual settings:**

| Setting | Configuration | Why |
|---|---|---|
| Node size | Ranking by `Frequency` | immediately conveys the dominant hashtags |
| Node colour | Partition by `Modularity Class` | makes the thematic segmentation visible |
| Edge thickness | Ranking by `Weight` | highlights the most systematic co-occurrences |
| Labels | **uniform size** (not proportional to the node) | so that the low-frequency legal-technical vocabulary (`pix`, `golpedopix`, `consultavel`, `advocaciacriminal`) stays legible and its cluster is not visually erased |

> ⚠️ **Colour means different things in the individual networks and in the combined one.**
>
> - **Figures 1 and 2 (individual networks):** colour = **thematic community** — 🟠 orange: criminal-legal-financial axis · 🟣 purple: virality axis · 🟢 green: lifestyle/enrichment axis.
> - **Figure 3 (combined network):** colour = **node origin** — 🔵 light blue: present on both platforms · ⚪ grey: Instagram only · 🟢 green: TikTok only.
>
> Because green takes on different meanings across the two types of figure, **each figure carries its own caption** stating what colour represents in that specific image — a necessary condition for reading the set correctly.

### 6.4 Combined network

**File:** `data/network/rede_combinada_instagram_tiktok.xlsx` · **Figure 3**

The preceding sections compare the two networks side by side. The **combined network** is a third construction, which makes the overlap between them directly measurable: it unites the vocabulary of both platforms in a single graph and assigns each node and each edge an **origin** label — present on both, Instagram only, or TikTok only.

**Method — distinct from that of the individual networks:**

- **the disparity filter is not applied**: the purpose is not to extract a backbone for reading clusters, but to map the sharing of vocabulary;
- the network is the **union** of the node sets and edge sets of the two networks;
- **weights are not summed raw.** Since the corpora differ greatly in size (3,126 vs 1,737 posts with hashtags), summing them would let Instagram dominate the graph by sheer volume — a collection artefact. Instead, edge weights are normalised per corpus (**co-occurrences per 1,000 posts**) and node frequencies as a **percentage of each dataset's posts**;
- the value of a node or edge present on both platforms is the **average of the two relative metrics**;
- each element carries the `origem` attribute, which governs the colour of Figure 3 (see [6.3](#63-layout-communities-and-centralities-gephi)).

**Result: 117 nodes and 1,690 edges.** The overlap is asymmetrical across the two levels:

| Level | On both | Instagram only | TikTok only | Overlap (Jaccard) |
|---|---|---|---|---|
| Vocabulary (nodes) | 41 | 70 | 6 | 35% |
| Relations (edges) | 309 | 1,260 | 121 | 18% |

The analytical reading of these figures is in the article and in the methodological record; the collection caveat that accompanies them is in [see 9, point 5](#9-limitations-and-caveats).

---

## 7. Repository structure

```
.
├── README.md                  ← Portuguese version (full methodological pathway)
├── README.en.md               ← this file (English version)
├── .zenodo.json               ← Zenodo deposit metadata (DOI per release)
├── ETHICS.md                  ← ethics and anonymisation protocol
├── .gitignore
│
├── data/
│   ├── dados_anonimizado_instagram.xlsx
│   ├── dados_anonimizado_tiktok.xlsx
│   ├── processed/             ← frequencies, thresholds, cleaned datasets
│   │   ├── frequencia3_instagram.csv
│   │   ├── instagram_limpo.csv
│   │   ├── tiktok_limpo.csv
│   │   ├── frequencias_tiktok.xlsx
│   │   └── tiktok_limpo.xlsx
│   └── network/               ← Gephi input
│       ├── nodes_instagram.csv / edges_instagram.csv
│       ├── nodes_tiktok.csv / edges_tiktok.csv
│       ├── nodes_*_backbone.csv / edges_*_backbone.csv
│       └── rede_combinada_instagram_tiktok.xlsx
│
├── scripts/                   ← commented implementation: Appendix B of the methodological record
│   ├── Estatísticas descritivas do corpus.R
│   ├── Análise de frequência de hashtags – Instagram.R
│   ├── Análise de frequência de hashtags – TikTok.R
│   ├── Ler e padronizar o dicionário instagram.R
│   ├── Ler e padronizar o dicionário tiktok.R
│   ├── Construção dos nós e arestas instagram.R
│   ├── Construção dos nós e arestas tiktok.R
│   ├── Disparity filter Instagram.R
│   └── Dispatity filter titok.R
│
├── dictionaries/
│   ├── README.md              ← column schema and coding criteria
│   ├── dicionario_instagram.xlsx
│   ├── dicionario_tiktok_preliminar.xlsx
│   └── dicionario_tiktok_revisado.xlsx
│
├── figures/
│   ├── README.md              ← captions, colour conventions and Gephi parameters
│   ├── fig01_rede_instagram_backbone.png
│   ├── fig02_rede_tiktok_backbone.png
│   ├── fig03_rede_combinada.png
│   └── gephi/                 ← .gephi projects to reopen the visualisations
│
└── docs/
    └── documento_metodologico_integrado.docx  ← full methodological record
```

---

## 8. Data dictionary

**`nodes_<platform>.csv`**

| Column | Type | Description |
|---|---|---|
| `Id` | string | hashtag in canonical form (primary key) |
| `Label` | string | identical to `Id`; label displayed in Gephi |
| `Frequency` | int | number of posts in which the canonical hashtag appears (**presence-per-post**, after unifications) |

**`edges_<platform>.csv`**

| Column | Type | Description |
|---|---|---|
| `Source` | string | hashtag A (references `nodes.Id`) |
| `Target` | string | hashtag B (references `nodes.Id`) |
| `Weight` | int | number of posts in which A and B co-occur |
| `Type` | string | always `Undirected` (present in the backbone files) |

**`dicionario_<platform>.xlsx`**

| Column | Type | Description |
|---|---|---|
| `tags` | string | original hashtag observed |
| `ação` | enum | `M` (keep) · `U` (unify) · `R` (remove) |
| `substituir por` | string | canonical form; filled in only when `ação = U` |
| `n` | int | raw frequency observed *(TikTok)* |
| `justificativa` | string | rationale for the decision *(TikTok)* |
| `ambiguo` | bool | flag for human validation *(TikTok)* |

**Cleaned datasets (`*_limpo.*`)**

| Column | Description |
|---|---|
| *(original columns)* | preserved in full, including the raw hashtag column |
| `hashtags_limpas` | comma-separated list after R/U/M and intra-post deduplication; **preserves the long tail** (see [5.4](#54-applying-the-cleaning)) |

**`rede_combinada_instagram_tiktok.xlsx`**

| Column | Description |
|---|---|
| `origem` | `ambas` · `instagram` · `tiktok` — governs the colour of Figure 3 |
| weights and frequencies | normalised per corpus; see the method in [6.4](#64-combined-network) |

---

## 9. Limitations and caveats

These caveats are part of the research design and should accompany any citation of the results.

**1. The size asymmetry is partly a collection artefact.** The Instagram corpus is ~1.8× larger (3,611 vs 1,957), but this **does not necessarily reflect a smaller discursive ecosystem on TikTok** — it follows above all from the scraping ceiling imposed by the platform. Consequently, all **absolute** indicators (number of nodes, edges, total weight) should be read with caution, privileging **relative structure** (proportions, positions, density, modularity) over raw magnitudes.

**2. Seed selection effect (sampling reflexivity).** Because the corpus was built from six seed hashtags, **those same hashtags tend, by construction, to be the most frequent and most central**. Their centrality must be interpreted as **partly induced by the sampling design**, not as an emergent finding. The analytical value of the networks lies (i) in what **co-occurs** with the seeds — the associated vocabulary that was not searched for directly — and (ii) in the **cross-platform comparisons**, where the sampling design is identical and therefore cancels out.

**3. No controlled time window.** The platforms do not allow date filtering in hashtag search. The corpus is a snapshot of what was available at the moment of capture.

**4. Asymmetry in visual treatment.** The additional weight cut of ≥ 7 applied to Instagram only affects **the rendering alone**, not the analysis: an impact of 1 node and 5 edges, with density, number of communities and partition unchanged. All reported metrics come from the complete network ([see 6.2](#62-backbone-disparity-filter)).

**5. The combined network and the origin asymmetry.** The stark difference between nodes exclusive to Instagram (70) and to TikTok (6) partly reflects Instagram's larger and more diverse corpus and the scraping ceiling that limited TikTok — **not only a difference in discursive richness**. This caveat is stated in the figure caption.

**6. Textual metadata, not audiovisual content.** Network analysis operates on hashtags and does not capture the video. This gap is addressed — not eliminated — by the ethnographic dimension ([see 2.4](#24-complementary-ethnographic-dimension)).

**7. Reciprocal edge duplication in the Instagram file.** The edge file contains 2,256 rows but only 1,569 unique undirected pairs, because `combn(tags, 2)` is applied without ordering the pair beforehand; Gephi merges the reciprocal pairs on import as an undirected network. This does not alter the analytical reading, but it requires attention in any direct recount from the CSV ([see 6.1](#61-building-the-networks)).

**8. The combined network has no versioned script.** It was assembled in a spreadsheet ([see 6.4](#64-combined-network)). Until it is converted into code, this stage is **documented but not automatically reproducible**.

---

## 10. Ethics and data protection

Full protocol in **[ETHICS.md](ETHICS.md)**.

The nature of the object — communities that operate ambiguous regimes of visibility and circulate explicit representations of acts potentially classifiable as criminal — imposes specific ethical safeguards, **at the risk that the research itself might expose the people who publish this content to persecutory reactions**. Measures adopted: **anonymisation** of the usernames mentioned in the text; **indirect reference** to field data, avoiding descriptions that would allow specific profiles or posts to be identified; and **omission of the IDs** of the posts referenced.

> Research ethics is taken to be **constitutive of the study's construction**, not a compliance layer added *a posteriori*: the choices of non-interaction (no likes, no comments), of anonymisation and of indirect reference are part of the research design, not merely formal safeguards.

---

## 11. References

- **Serrano, M. Á., Boguñá, M., & Vespignani, A.** (2009). Extracting the multiscale backbone of complex weighted networks. *Proceedings of the National Academy of Sciences*, 106(16), 6483–6488. https://doi.org/10.1073/pnas.0808904106
- **Jacomy, M., Venturini, T., Heymann, S., & Bastian, M.** (2014). ForceAtlas2, a continuous graph layout algorithm for handy network visualization designed for the Gephi software. *PLoS ONE*, 9(6), e98679. https://doi.org/10.1371/journal.pone.0098679
- **Blondel, V. D., Guillaume, J.-L., Lambiotte, R., & Lefebvre, E.** (2008). Fast unfolding of communities in large networks. *Journal of Statistical Mechanics*, P10008. https://doi.org/10.1088/1742-5468/2008/10/P10008
- **Bastian, M., Heymann, S., & Jacomy, M.** (2009). Gephi: an open source software for exploring and manipulating networks. *ICWSM*.
- **Peeters, S., & Hagen, S.** (2022). The 4CAT Capture and Analysis Toolkit: A modular tool for transparent and traceable social media research. *Computational Communication Research*, 4(2), 571–589.
- **Hine, C.** (2015). *Ethnography for the Internet: Embedded, Embodied and Everyday*. London: Bloomsbury.


## Licença

Os conteúdos deste repositório (scripts, dicionários, dados derivados,
figuras e documentação) estão licenciados sob
[Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

## Como citar

Nicholas, K., Mena, M. F., Arnoni de Camargo, Y., Sander, L., & Sabrina, L. (2026).
*Redes de coocorrência de hashtags em Instagram e TikTok no ecossistema discursivo
do estelionato e da monetização ilícita* (v1.0.1) [Conjunto de dados e scripts].
Zenodo. https://doi.org/10.5281/zenodo.22943099

O relatório técnico-metodológico que documenta este repositório está disponível em:
https://doi.org/10.5281/zenodo.22897219