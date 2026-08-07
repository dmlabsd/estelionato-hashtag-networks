# Hashtag Co-occurrence Networks in the Discursive Ecosystem of Financial Fraud

**Instagram and TikTok · a comparative mapping of digital financial-crime discourse in Brazil**

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)
[![License: TBD](https://img.shields.io/badge/license-TBD-lightgrey.svg)](LICENSE)

> 🇧🇷 A versão em português deste README está em **[README.md](README.md)**.

This repository is the versioning, documentation and reproduction environment for a study that maps and compares the digital discursive ecosystems associated with **estelionato** (fraud/swindling under Art. 171 of the Brazilian Penal Code), financial scams, illicit monetisation and virality strategies on **Instagram** and **TikTok**, using **hashtag co-occurrence networks**.

It gathers the data, the R scripts, the coding dictionaries, the figures and the full methodological record underpinning the international article and the book chapter derived from the project.

> **A note on terminology.** *Estelionato* is the Brazilian legal category for obtaining an illicit advantage through deceit, artifice or any fraudulent means (Penal Code, Art. 171 — hence the emic hashtag `#171`). It is close to, but not identical with, "fraud" or "swindling" in Anglo-American law. Throughout this repository the Portuguese term is retained because it is also an **emic** category: it is the word the community itself uses to tag its own content.

---

## Contents

- [1. What this repository contains](#1-what-this-repository-contains)
- [2. Directory structure](#2-directory-structure)
- [3. Methodological workflow](#3-methodological-workflow)
- [4. How to reproduce](#4-how-to-reproduce)
- [5. Main findings](#5-main-findings)
- [6. Complementary ethnographic component](#6-complementary-ethnographic-component)
- [7. Limitations and caveats](#7-limitations-and-caveats)
- [8. Ethics and data protection](#8-ethics-and-data-protection)
- [9. Data dictionary](#9-data-dictionary)
- [10. How to cite](#10-how-to-cite)
- [11. References](#11-references)
- [12. Team and contact](#12-team-and-contact)

---

## 1. What this repository contains

| Component | Location | Status |
|---|---|---|
| Full methodological documentation | [`docs/`](docs/) | ✅ |
| R pipeline scripts (raw → Gephi) | [`scripts/`](scripts/) | ✅ |
| M/U/R coding dictionaries | [`dictionaries/`](dictionaries/) | ⬜ to be deposited |
| Master datasets and intermediate spreadsheets | [`data/`](data/) | ⬜ to be deposited |
| Node and edge files for Gephi | [`data/network/`](data/network/) | ⬜ to be deposited |
| Network figures (Gephi) | [`figures/`](figures/) | ⬜ to be deposited |

**Guiding principle:** every figure reported in the article and in the book chapter must be traceable to a file in this repository and to the script line that produced it.

---

## 2. Directory structure

```
.
├── README.md / README.en.md   ← full methodological workflow (PT-BR / EN)
├── CITATION.cff               ← citation metadata (read by GitHub and Zenodo)
├── .zenodo.json               ← Zenodo deposit metadata (DOI per release)
├── LICENSE                    ← licence (to be defined)
├── ETHICS.md                  ← ethics and anonymisation protocol
├── CHANGELOG.md
│
├── data/
│   ├── raw/                   ← consolidated master datasets (6 sheets → 1 per platform)
│   ├── processed/             ← frequencies, thresholds, cleaned datasets
│   └── network/               ← nodes_*.csv / edges_*.csv (Gephi input)
│
├── scripts/                   ← 00_config → 08_rede_combinada, 99_anonimizar, run_all
├── dictionaries/              ← M/U/R coding dictionaries per platform
├── figures/                   ← final network figures + .gephi project files
└── docs/                      ← methodological report, Gephi parameters, appendices
```

---

## 3. Methodological workflow

The design is **mirrored**: the procedure developed for Instagram was reproduced in full for TikTok — same thresholds, same coding categories, same network-construction logic — adjusting only what was strictly imposed by structural differences between the datasets. This ensures that differences observed between the final networks reflect **real differences between platforms rather than artefacts of method**.

```
Collection → Consolidation → Audit → Extraction & frequencies → n ≥ 10 threshold
    → M/U/R dictionary → Cleaning → Network (nodes + edges)
    → Disparity filter backbone → Gephi (ForceAtlas2 + Modularity) → Comparison
```

### 3.1 Collection

- **Instrumentation:** [Zeeschuimer](https://github.com/digitalmethodsinitiative/zeeschuimer) browser extension connected to [4CAT](https://github.com/digitalmethodsinitiative/4cat), capturing posts directly from browsing. **Identical on both platforms** — a precondition for comparability.
- **Accounts:** newly created on both platforms specifically for data collection, to avoid algorithmic feed personalisation from pre-existing histories.
- **Six seed hashtags, common to both platforms:** `#estelionato` · `#estelionatario` · `#raul` · `#happynation` · `#tropado7` · `#171`
- **Date filter:** none — the platforms do not offer this option in hashtag search. The corpus is therefore a snapshot of material available at capture time, **with no controlled temporal window**.
- **Deliberate exclusion:** `#bigode` was dropped from the seed set (retrieved posts referred predominantly to facial hair). Note that `bigode` **remains a node** in the final networks — not as a seed, but as an internal hashtag where it designates the persona "Raul Bigode".
- **Target:** ~500 posts per hashtag. **Met on Instagram; not met on TikTok** because of platform scraping/pagination limits. This is the direct origin of the size asymmetry between corpora (see [§7](#7-limitations-and-caveats)).

### 3.2 Consolidation

The **six input spreadsheets** (one per seed) were consolidated, on each platform, into a **single master dataset**.

| Dimension | Instagram | TikTok |
|---|---|---|
| Collection tool | Zeeschuimer + 4CAT | Zeeschuimer + 4CAT |
| Accounts | new, created for collection | new, created for collection |
| Seed hashtags | the 6 seeds | the same 6 seeds |
| Date filter | none (not permitted) | none (not permitted) |
| Target per hashtag | ~500 posts (**met**) | ~500 posts (**not met**) |
| Input spreadsheets | 6 (one per seed) | 6 (one per seed) |
| Master dataset | `dataset_consolidado_instagram.xlsx` | `dataset_consolidado_tiktok.xlsx` |
| **Total posts** | **3,611** | **1,957** |
| Caption column | G | I (`body`) |
| Hashtag column | S (index 19) | AD (`hashtags`) |

### 3.3 Initial audit

On both platforms, hashtags are stored as a **comma-separated list within a single cell per post**, predominantly lowercase and without the `#` character. This format convergence is what makes the mirrored treatment viable.

| Issue | Occurrence | Treatment | Stage |
|---|---|---|---|
| Posts with no hashtags | IG: 485 / TT: 220 (11.2%) | Kept in corpus; excluded from network | Extraction |
| Internal duplication | TT: 62 posts (e.g. `viral,viral,paineldo7`) | Deduplication by presence within post | Extraction |
| Attached emoji | TT: 164 posts (`fypシ`, `dinheiroonline💰`) | Unified to clean textual form | Dictionary (U) |
| Uppercase | TT: 5 posts | `tolower()` | Normalisation |
| Orthographic / cross-linguistic variants | `dinheiro`/`money`, `fouryou` | Unified to canonical form | Dictionary (U) |
| Character elongation | `fyppppppppppppppppppppppp` (39×), `paratiiii…` (21×) | Unified to base form | Dictionary (U) |

> **Finding at this stage:** both corpora share the same modes of "noise". This is itself a result — tagging practices on the two platforms follow **similar virality grammars** (elongating `fyp`, decorating with emoji, repeating the appeal to the algorithm).

### 3.4 Extraction and frequency counts

Script: [`scripts/02_extracao_frequencias.R`](scripts/02_extracao_frequencias.R). The cell-list is split with `separate_rows(sep = ",")`, normalised (`str_trim()` + `tolower()`), emptied tokens discarded, and counted.

> ⚠️ **Critical methodological point.** At this stage frequency is counted **per raw occurrence**, not per presence-in-post: a hashtag repeated within the same post is counted more than once. Intra-post deduplication is applied only later — (i) in the cleaning function (`unique()` over each post's resolved hashtags) and (ii) in network construction (`unique()` before generating pairs). **This is why a hashtag's frequency in the frequency table is generally slightly higher than its frequency as a node.**

| Metric | Instagram | TikTok |
|---|---|---|
| Raw occurrences (official count) | 21,812 | 9,149 |
| Distinct hashtags | 5,048 | 2,967 |
| Posts **with** hashtags | 3,126 | 1,737 |
| Posts **without** hashtags | 485 | 220 |
| Hashtags with n ≥ 3 | 963 | 425 |
| **Hashtags with n ≥ 10** | **291** | **103** |
| Hashtags with n ≥ 20 | 138 | 51 |

Top of the distributions:

| # | Instagram (n) | TikTok (n) |
|---|---|---|
| 1 | `raul` (816) | `fyp` (520) |
| 2 | `estelionato` (576) | `estelionato` (349) |
| 3 | `happynation` (540) | `viral` (251) |
| 4 | `tropado7` (493) | `happynation` (240) |
| 5 | `171` (430) | `raul` (237) |

**Rationale for the n ≥ 10 threshold.** Three cut-off points were tested (≥3, ≥10, ≥20). n ≥ 10 was chosen because it (a) **preserves thematic diversity** — it does not discard relevant semantic fields of moderate frequency; (b) **removes substantial noise** — it eliminates the long tail of idiosyncratic hashtags, typos and single-occurrence terms; (c) **keeps the set tractable** — it makes manual coding feasible, which would be impossible with the 963/425 hashtags of the ≥3 cut-off. The effect is comparable across platforms: Instagram goes from 5,048 to 291 candidates (5.8% of the vocabulary), TikTok from 2,967 to 103 (3.5%).

### 3.5 Analytical dictionaries (M/U/R)

Hashtags with n ≥ 10 were exported and coded. On **Instagram** coding was **manual**, item by item. On **TikTok** it was **semi-automatic**: each hashtag received a preliminary classification generated from the Instagram criteria and dictionary as an analytical model (direct matching of equivalents, variant detection, application of thematic rules), followed by review and explicit flagging of ambiguous cases for human validation.

| Code | Name | Definition |
|---|---|---|
| **M** | Maintain | The hashtag belongs to the research object and is preserved as a network node. |
| **U** | Unify | The hashtag is a variant; it is replaced by the canonical form given in `substituir por`. |
| **R** | Remove | The hashtag is thematically unrelated noise and is eliminated. |

**Criteria.** *Maintain (M):* fraud, scams, criminality, security, monetisation, entrepreneurship, wealth accumulation, digital marketing, platforms, virality, content circulation, and central personas. *Remove (R):* fandoms, celebrities, football, unrelated music/characters, memes with no thematic link, irrelevant foreign hashtags, spam, algorithmic noise. *Unify (U):* orthographic variation, singular/plural, diacritics, cross-linguistic equivalents, emoji-decorated versions, virality variants.

**Canonical unification cores:** `fyp` (algorithmic virality — absorbs `fy`, `foryou`, `foryoupage`, `fouryou`, `fypage`, `fypシ`, all elongations; on TikTok also `parati` and its elongations, the Portuguese equivalent of *for you*; on Instagram it coexists with `explore`, `reels` and `feed`) · `viral` (circulation) · `dinheiro` (financial core; `money` → `dinheiro`) · `marketingdigital` · `estilo` (lifestyle) · `luxo` (conspicuous consumption) · `musica` (entertainment) · group codes (`tropado777`/`tropadosete` → `tropado7`; `happy` → `happynation`).

> **Deliberate decision:** the entertainment layer (`musica`, `funk`, `humor`, `meme`) was coded **M**, not removed. It is not noise — it is the **cultural wrapper through which criminal discourse is distributed**. This is an analytical finding, not a discard.

**Hierarchical rule for ambiguous cases:** `U` when there is clear semantic equivalence with a canonical form; `R` when the hashtag unequivocally belongs to an external field (gaming, video editing, fandom); `M` when it belongs to one of the research axes **or when Instagram had already coded it as M** (comparability takes priority).

| Category | Instagram (n=291) | TikTok (n=103) |
|---|---|---|
| M (maintain) | 107 (36.8%) | 43 (41.7%) |
| U (unify) | 87 (29.9%) | 51 (49.5%) |
| R (remove) | 97 (33.3%) | 9 (8.7%) |

> **Coding findings.** (i) The **U share is much higher on TikTok** (≈50% vs 30%): TikTok's vocabulary is more redundant, dominated by virality variants multiplying into elongated and decorated forms. (ii) The **R share is much lower on TikTok** (≈9% vs 33%): Instagram carried far more fandom/football/brand noise, whereas TikTok is more narrowly concentrated in the thematic field. (iii) In both, **the M core is stable and nearly identical in content** — the first strong evidence that the two platforms host the same discursive ecosystem.

### 3.6 Cleaning

For each hashtag in each post: if **R**, drop; if **U**, replace with the canonical form; if **M**, keep. Duplicates within the post are then removed — **including those arising after unification** (e.g. `fy` and `foryou` both becoming `fyp`).

> **Scope difference — important for replication.** The cleaned column **preserves the long tail**: hashtags with n < 10 that are absent from the dictionary pass through unchanged, since they are neither R nor U. Restriction to the coded vocabulary happens **only at the next stage**, in network construction. This is the logic that takes Instagram from 291 candidates to 111 nodes.

### 3.7 Network construction

| Term | Definition |
|---|---|
| **Node** | A hashtag in canonical form, post-cleaning. |
| **Edge** | A link between two hashtags appearing in the same post (co-occurrence). |
| **Weight** | Number of posts in which that pair co-occurs. Sets edge thickness. |
| **Frequency** | Node attribute: number of posts in which the canonical hashtag appears. Sets node size. |

> ⚠️ **Replication note on edges.** The Instagram edge file contains **2,256 rows but only 1,569 unique undirected pairs**: the original generation used `combn(tags, 2)` **without pre-sorting the pair**, so the same relation appears in two rows (e.g. `viral→fyp` weight 145 and `fyp→viral` weight 147). When imported as an **undirected** graph in Gephi these reciprocal pairs are merged and the analytical reading is unaffected. TikTok's pipeline already canonicalises pair order, yielding 430 unique edges.
>
> **In this repository, [`scripts/05_construir_rede.R`](scripts/05_construir_rede.R) applies `sort()` to each pair before `combn`**, producing canonical, unique edges directly. The historical Instagram files (2,256 rows) are preserved under `data/network/legacy/` for equivalence auditing.

| Indicator | Instagram | TikTok |
|---|---|---|
| Nodes | 111 | 47 |
| Edges (rows in CSV) | 2,256 | 430 |
| **Unique undirected pairs** | **1,569** | **430** |
| Total edge weight | 22,471 | 4,244 |
| Density | 0.262 | **0.415** |
| Average degree | 28.3 | 18.3 |
| Communities (Modularity, res. 1.0) | 3 | 3 |
| Modularity (Q) | **0.329** | 0.148 |

### 3.8 Backbone extraction and visualisation

**The problem.** Co-occurrence networks are dense and dominated by ubiquitous hubs. On Instagram, `viral` co-occurs with 83% of nodes, `fyp` with 81%, `estelionato` with 75%; over a third of the edges represent trivial co-occurrences (weight ≤ 2). Under these conditions no force-directed layout can separate the clusters: the result is an illegible **hairball** in which the community structure exists in the metrics but is not visually communicable.

**The solution — disparity filter** (Serrano, Boguñá & Vespignani, 2009). For each node *i* of degree *k*, each incident edge receives a normalised weight `p_ij = w_ij / s_i`, and the statistical significance is computed as

```
α_ij = (1 − p_ij)^(k − 1)
```

Only edges significant **for at least one of their endpoints** are retained, preserving each node's locally relevant connections — including those of small nodes that would otherwise be erased by the hubs.

**Threshold: α < 0.10.** On Instagram the network goes from 1,569 to 273 edges and density falls from 0.262 to 0.071, preserving 88 nodes in the giant component.

> 🔴 **Decisive interpretive rule.** The backbone is used **exclusively for visualisation and cluster reading**. All reported structural metrics (centrality, modularity, weighted degree, density) are computed **on the complete network**.

**Declared asymmetry in visual treatment.** The Instagram network, substantially larger and denser, retained residual visual entanglement even after the disparity filter. An **additional edge-weight cut-off (≥ 7) was applied to Instagram only, exclusively for figure legibility**. TikTok required no such step. The structural impact is negligible: the cut-off removes **1 node (`digital`) and 5 low-weight edges** (from 88/273 to 87/268), leaving density, community count and partition unchanged. The asymmetry stems from a real size difference between corpora, not from methodological inconsistency.

**ForceAtlas2 parameters:**

| Parameter | Instagram | TikTok |
|---|---|---|
| LinLog mode | on | on |
| Dissuade Hubs | on | on |
| Prevent Overlap | on | on |
| Inverted edge weights | on | on |
| Scaling | 20 | 50 |
| Gravity | 0.8 | 1.0 |
| Barnes-Hut θ | 0.5 | 1.2 |
| Approximate Repulsion | on | — |

**Visual encodings:** node size → ranking by `Frequency`; node colour → partition by `Modularity Class`; edge thickness → ranking by `Weight`; labels at **uniform size** (not proportional to node), so that the low-frequency legal-technical vocabulary of fraud (`pix`, `golpedopix`, `consultavel`, `advocaciacriminal`) remains legible and its cluster is not visually erased.

> ⚠️ **Colour convention — read the figures carefully.** In the **individual networks** colour encodes the **thematic community**: 🟠 orange = criminal-legal-financial axis · 🟣 purple = virality axis · 🟢 green = lifestyle/wealth axis. In the **combined network** colour encodes **node origin**: 🔵 light blue = present on both · ⚪ grey = Instagram only · 🟢 green = TikTok only. Because green carries different meanings across the two figure types, **each figure carries its own legend**.

### 3.9 The combined network

The combined network merges both platforms' vocabularies into a single graph, labelling each node and edge by **origin** — present on both, Instagram only, or TikTok only.

**A deliberately different method.** It does **not** apply the disparity filter, because its purpose is not backbone extraction for cluster reading but **mapping vocabulary sharing**. Because the corpora differ markedly in size (3,126 vs 1,737 posts with hashtags), **weights are not summed raw** — that would let Instagram dominate the graph by sheer volume, a collection artefact. Instead: co-occurrences are normalised **per 1,000 posts**; frequencies are expressed as a **percentage of each base's posts**; and the value of a node/edge present on both is the **mean of the two relative metrics**.

| Level | On both | Instagram only | TikTok only | Overlap (Jaccard) |
|---|---|---|---|---|
| Vocabulary (nodes) | 41 | 70 | 6 | **35%** |
| Relations (edges) | 309 | 1,260 | 121 | **18%** |

Total: 117 nodes, 1,690 edges.

> 🎯 **This is the finding that empirically grounds the central thesis.** A shared discursive core exists — 35% of the vocabulary appears on both platforms, including the central hashtags of fraud (`estelionato`, `171`, `golpe`, `cc`, `cartaoclonado`), virality (`fyp`, `viral`) and wealth (`happynation`, `dinheiro`). But **relational overlap (18%) is half the lexical overlap (35%)**: the same hashtags combine differently on each platform.
>
> **Shared content structure, distinct visibility grammar:** the ecosystem's lexicon is largely shared, but the *syntax* of co-occurrences — which terms link to which — is platform-specific.

---

## 4. How to reproduce

**Requirements:** R ≥ 4.2 with `readxl`, `dplyr`, `tidyr`, `stringr`, `purrr`, `igraph`, `writexl`, `openxlsx`; Gephi ≥ 0.10 (optionally with the Disparity/Backbone plugin).

```bash
git clone https://github.com/<ORG>/estelionato-hashtag-networks.git
cd estelionato-hashtag-networks
```

```r
source("scripts/01_setup.R")   # install and load packages
source("scripts/run_all.R")    # run the full pipeline
```

| Order | Script | Input | Output |
|---|---|---|---|
| 0 | `00_config.R` | — | project paths and parameters |
| 1 | `01_setup.R` | — | packages installed and loaded |
| 2 | `02_extracao_frequencias.R` | `data/raw/dataset_consolidado_*.xlsx` | `data/processed/frequencias_*.xlsx` |
| 3 | `03_cortes_frequencia.R` | frequencies | `data/processed/hashtags_freq{3,10,20}_*.csv` |
| 4 | *(manual / semi-automatic coding)* | `hashtags_freq10_*.csv` | `dictionaries/dicionario_*.xlsx` |
| 5 | `04_aplicar_dicionario.R` | master dataset + dictionary | `data/processed/*_limpo.xlsx` |
| 6 | `05_construir_rede.R` | cleaned dataset | `data/network/nodes_*.csv`, `edges_*.csv` |
| 7 | `06_disparity_filter.R` | nodes + edges | `data/network/*_backbone.csv` |
| 8 | `07_metricas_rede.R` | complete network | `data/processed/metricas_rede_*.csv` |
| 9 | `08_rede_combinada.R` | both networks | `data/network/rede_combinada_*.csv` |

> **Step 4 is human and not automatable**: it is the M/U/R coding stage. The resulting dictionaries are versioned in `dictionaries/`, so the pipeline is reproducible end-to-end **without repeating the coding**.

**Reproducing the figures in Gephi:** import `nodes_*_backbone.csv` as Nodes Table and `edges_*_backbone.csv` as Edges Table; set the graph to **Undirected** (co-occurrence is symmetric by nature); run **Statistics → Modularity** (resolution 1.0) and **Average Degree**; apply **ForceAtlas2** with the parameters in [§3.8](#38-backbone-extraction-and-visualisation) and let it converge; apply the visual encodings; for Instagram only, apply the additional **Edge Weight ≥ 7** filter.

> **Stability note:** the Modularity algorithm is stochastic and community count is sensitive to the resolution parameter. At resolution 1.0 with repeated runs, the 3-community partition proved stable on both networks.

---

## 5. Main findings

### 5.1 Instagram

**Structure.** 111 nodes, 1,569 co-occurrence pairs, density 0.262, 3 communities, Q = 0.329 — clearly separated communities organised as a strong central core surrounded by distinct thematic blocks.

**Centrality (weighted degree).** `fyp` (1,223), `viral` (1,210), `estelionato` (861), `raul` (855), `explore` (781), `dinheiro` (724), `estelionatario` (691), `171` (578), `tropado7` (521), `reels` (515). By frequency, `raul` (809) leads, followed by `fyp` (715) and `viral` (591). **Strongest edge: `viral`–`fyp`.**

- 🟠 **Criminal-financial-legal core** — the fraud lexicon (`estelionato`, `estelionatario`, `golpe`, `fraude`, `golpedopix`, `171`, `roubo`, `cc`, `cartaoclonado`, `lavagemdedinheiro`, `laranja`), the financial lexicon (`dinheiro`, `dinheiroextra`, `dinheiroonline`) and legal-policing vocabulary (`advocacia`, `advocaciacriminal`, `direito`, `falsoadvogado`, `policia`, `policiacivil`, `segurança`, `prisão`). **On Instagram, `dinheiro` anchors this block.**
- 🟣 **Virality and personas** — `fyp`, `viral`, `explore`, `reels`, `trending`, the entertainment layer (`funk`, `humor`, `meme`, `musica`) and — an important Instagram-specific feature — the personas `raul`, `tropado7`, `bigode`, `buzeira`, `ninoabravanel`.
- 🟢 **Wealth and lifestyle** — `happynation`, `marketingdigital`, `sucesso`, `lifestyle`, `mindset`, `empreendedorismo`, `oldmoney`, `milionario`, `rico`, `bilionario`, `carro`, `brasil`, plus the numeric codes `77`/`333`/`777`.

### 5.2 TikTok

**Structure.** 47 nodes, 430 edges, density 0.415 — **denser** than Instagram. 3 communities but Q = 0.148: blocks are far more fused around the virality axis.

**Centrality (weighted degree).** `fyp` (1,511), `viral` (818), `estelionato` (756), `raul` (519), `dinheiro` (484), `happynation` (433), `171` (407), `7` (353), `estelionatario` (324), `tropado7` (287). By frequency `fyp` (896) dominates by a wide margin. **Strongest edges: `fyp`–`viral` (239) and `estelionato`–`fyp` (172).**

- 🟠 **Criminal core** — `estelionato`, `estelionatario`, `171`, `7`, `777`, `golpe`, `crime`, `cc`, `cartaoclonado`, `laranja`, `bigode`, `frases`, `mckelvinho`, `meme`, `explore` and — **unlike Instagram** — the personas `raul` and `tropado7`.
- 🟣 **Virality and entertainment** — `fyp`, `viral`, `happynation`, `funk`, `musica`, `humor`, `trending`, `tiktok`, `status`, `motivational`, `ninoabravanel`, `mulherdepreso`, `brasil`, `policia`, `sucesso`.
- 🟢 **Lifestyle / wealth** — `dinheiro`, `luxo`, `milionario`, `rico`, `ruyter`. A smaller, leaner block than Instagram's. **Note that `dinheiro`, which anchors the criminal-financial core on Instagram, shifts to the lifestyle axis on TikTok.**

### 5.3 Comparison

**Structural similarities.** Both networks reproduce the **same tripartite architecture**: (1) a criminal-financial core (`estelionato` + `dinheiro`), (2) a virality core (`fyp`/`viral`) and (3) an aspirational/conspicuous layer (luxury/wealth), stitched together by **anchor personas** (above all `raul`). In both, the strongest edge links `fyp` and `viral`, and the fraud core connects directly to the virality core. The M vocabulary is nearly identical and several personas are shared (`raul`, `ruyter`, `ninoabravanel`, `aceofbase`, `happynation`, `tropado7`, `buzeira`, `bigode`).

| Aspect | Instagram | TikTok |
|---|---|---|
| Size | larger (111 nodes) | smaller (47 nodes) |
| Density | lower (0.262) | higher (0.415) |
| Modularity (Q) | higher (0.329) | lower (0.148) |
| Communities | 3, more separated | 3, more fused |
| Top centrality | distributed (`fyp` ≈ `viral` ≈ `raul`) | concentrated in `fyp` |

**Vocabulary differences.** Instagram carries a **more diversified, market-oriented** vocabulary: luxury brands (`armani`, `nike`, `lacoste`, `lv`), `oldmoney`, `dropshipping`, `marketingdigital`, `bitcoin`, `blackhat`, and an extensive legal-security repertoire. TikTok's vocabulary is **leaner and more algorithmic**, dominated by virality variants and a musical entertainment layer (`musica`, `funk`, `phonk`, `slowed`), with platform-specific elements such as `mulherdepreso` and `tiktokshop`.

**Visibility mechanisms — the sharpest distinction.**

- **Instagram → group identity + discovery.** Visibility is anchored in `explore`, `reels` and `feed`, combined with belonging markers (`happynation`, `tropado7`, personas). Reach is negotiated both through the discovery algorithm and through affiliation to an identifiable community.
- **TikTok → pure algorithmic virality.** Visibility is anchored in `fyp` and `parati` — direct appeals to the recommendation algorithm. Massive elongation (`fyppppp…`, `paratiiiii…`) and emoji decoration (`fypシ`) are far more intense performances of algorithmic appeal.

**Crime–monetisation–entertainment articulation.** On both platforms **crime does not circulate alone**: it comes wrapped in entertainment (`funk`, `humor`, `meme`, `musica` — all coded M precisely because they are the vehicle) and sold as a promise of enrichment (`luxo`, wealth, `sucesso`). The difference is emphasis: on Instagram the monetisation-entrepreneurship axis is more elaborate, suggesting a discourse closer to the **market**; on TikTok the entertainment-virality axis dominates, suggesting a discourse closer to **spectacle** and algorithmic reach.

### 5.4 Central finding

> **It is the same discursive ecosystem — with a qualification.**
>
> **Yes:** both platforms host the same ecosystem — the same core criminal-financial lexicon, the same logic of coupling crime to virality, the same anchor personas circulating across environments, the same tripartite architecture.
>
> **Qualified:** each platform modulates that ecosystem according to its own economy of visibility — Instagram organises it around **group identity and market**; TikTok around **algorithmic virality and spectacle**.
>
> **There is one ecosystem; there are two visibility grammars.**

---

## 6. Complementary ethnographic component

**The gap.** Automated collection captures structured metadata but **not the audiovisual content of the videos**. On Instagram and TikTok, video is the central element of a post, and much of the meaning of the research object — the performance of the scam, the staging of wealth, the group's visual codes — is accessible only through direct observation of the audiovisual piece.

**Procedure**, informed by Hine (2015):

1. An Instagram account **with no posts, no followers and no accounts followed** — a "clean" profile with no history capable of biasing algorithmic curation.
2. Starting from the **first video on the research object shown in the "Explore" tab**, letting subsequent navigation be driven by the platform's own recommendations.
3. **No likes, no comments** — no interference in the field and no interaction trace.
4. Observational interaction limited to **opening comments and saving videos** via the platform's native save feature.

This routine preserves a position of **non-participant observation**: the account emits no engagement signals that could feed back into the recommendation algorithm or be noticed by the observed profiles, and material is archived through a mechanism already provided by the platform, without external extraction of the video itself.

**Resulting archive** — posts selected on Instagram between **May and September 2025**:

| Category (reference criminal offence) | Posts | % |
|---|---|---|
| Estelionato (fraud, Art. 171) | 81 | 62.3% |
| Simple theft (*furto simples*) | 30 | 23.1% |
| Robbery with violence or grave threat | 19 | 14.6% |
| **Total** | **130** | **100%** |

This qualitative archive is **complementary, not substitutive**, to the quantitative corpus.

---

## 7. Limitations and caveats

These caveats are part of the research design and should accompany any citation of the results.

**1. The size asymmetry is partly a collection artefact.** The Instagram corpus is ~1.8× larger (3,611 vs 1,957), but this **does not necessarily reflect a smaller discursive ecosystem on TikTok** — it stems chiefly from the platform's scraping ceiling. Consequently, all **absolute** indicators (node count, edge count, total weight) should be read cautiously, favouring **relative structure** (proportions, positions, density, modularity) over raw magnitudes.

**2. Seed selection effect (sampling reflexivity).** Because the corpus was built from six seed hashtags, **those same hashtags tend by construction to be the most frequent and most central**. The centrality of `estelionato`, `estelionatario`, `raul`, `happynation`, `tropado7` and `171` should be interpreted as **partly induced by the sampling design**, not as an emergent finding. The analytical value of the networks lies (i) in what **co-occurs** with the seeds — the associated vocabulary that was not searched for directly — and (ii) in the **cross-platform comparisons**, where the sampling design is identical and therefore cancels out.

**3. No controlled temporal window.** The platforms do not allow date filtering in hashtag search.

**4. Asymmetric visual treatment.** The additional weight ≥ 7 cut-off applied to Instagram only affects **rendering, not analysis**: 1 node and 5 edges, with density, community count and partition unchanged. All reported metrics come from the complete network.

**5. The combined network's "IG-only" vs "TT-only" asymmetry.** The 70 Instagram-exclusive nodes against 6 TikTok-exclusive ones partly reflect Instagram's larger and more diverse corpus and TikTok's scraping ceiling — **not solely a difference in discursive richness**.

**6. Textual metadata, not audiovisual content.** The network analysis operates on hashtags and does not capture video. This gap is addressed — not eliminated — by the ethnographic component ([§6](#6-complementary-ethnographic-component)).

**7. Reciprocal edge duplication in the historical Instagram file.** See the replication note in [§3.7](#37-network-construction).

---

## 8. Ethics and data protection

See the full protocol in **[ETHICS.md](ETHICS.md)**.

The nature of the object — communities operating ambiguous visibility regimes and circulating explicit representations of potentially criminal acts — imposes specific ethical safeguards, **since the research itself risks exposing the people who publish this content to persecutory reactions**. Measures adopted: **anonymisation** of usernames mentioned in the text; **indirect reference** to field data, avoiding descriptions that would allow identification of specific profiles or posts; **omission of post IDs** from the body of the text.

> Research ethics is treated as **constitutive of the study's construction**, not as a compliance layer applied *post hoc*: the choices of non-interaction (no likes, no comments), anonymisation and indirect reference are part of the research design, not merely formal safeguards.

The script [`scripts/99_anonimizar.R`](scripts/99_anonimizar.R) implements systematic removal of authorship fields, IDs and URLs prior to any data publication. **Running it is mandatory before any commit to `data/raw/`.**

---

## 9. Data dictionary

**`nodes_<platform>.csv`** — `Id` (canonical hashtag, primary key) · `Label` (identical to `Id`) · `Frequency` (posts in which the canonical hashtag appears, presence-per-post).

**`edges_<platform>.csv`** — `Source` / `Target` (hashtags, referencing `nodes.Id`) · `Weight` (posts in which the pair co-occurs) · `Type` (always `Undirected`).

**`dicionario_<platform>.xlsx`** — `tags` (observed hashtag) · `ação` (`M`/`U`/`R`) · `substituir por` (canonical form, filled only when `ação = U`) · `n` (raw frequency, TikTok) · `justificativa` (rationale, TikTok) · `ambiguo` (flag for human validation, TikTok).

Full schema and provenance in [`data/README.md`](data/README.md).

---

## 10. How to cite

This repository and the methodological report are deposited on **Zenodo**, which mints a **permanent DOI for each GitHub release**. Please cite the version you actually used.

```
[Authors] (2026). Hashtag co-occurrence networks on Instagram and TikTok in the
discursive ecosystem of financial fraud and illicit monetisation: methodological
record, technical appendix and replication guide. Zenodo.
https://doi.org/10.5281/zenodo.XXXXXXX
```

BibTeX and CSL formats are generated by GitHub from [`CITATION.cff`](CITATION.cff) ("Cite this repository" in the sidebar).

**Zenodo integration:** (1) sign in to [zenodo.org](https://zenodo.org) with the GitHub account; (2) **Settings → GitHub**, enable the toggle for this repository; (3) create a GitHub **release** (`v1.0.0`) — Zenodo captures the snapshot and issues the DOI; (4) copy the **Concept DOI** (always pointing to the latest version) and replace `10.5281/zenodo.XXXXXXX` in the badge, in `CITATION.cff` and in this section; (5) deposit the methodological report PDF separately as a *Technical Report*, linking it to the repository via `related identifiers` (`isSupplementTo`).

---

## 11. References

- **Serrano, M. Á., Boguñá, M., & Vespignani, A.** (2009). Extracting the multiscale backbone of complex weighted networks. *PNAS*, 106(16), 6483–6488. https://doi.org/10.1073/pnas.0808904106
- **Hine, C.** (2015). *Ethnography for the Internet: Embedded, Embodied and Everyday*. London: Bloomsbury.
- **Jacomy, M., Venturini, T., Heymann, S., & Bastian, M.** (2014). ForceAtlas2, a continuous graph layout algorithm for handy network visualization designed for the Gephi software. *PLoS ONE*, 9(6), e98679. https://doi.org/10.1371/journal.pone.0098679
- **Blondel, V. D., Guillaume, J.-L., Lambiotte, R., & Lefebvre, E.** (2008). Fast unfolding of communities in large networks. *J. Stat. Mech.*, P10008.
- **Bastian, M., Heymann, S., & Jacomy, M.** (2009). Gephi: an open source software for exploring and manipulating networks. *ICWSM*.
- **Peeters, S., & Hagen, S.** (2022). The 4CAT Capture and Analysis Toolkit. *Computational Communication Research*, 4(2), 571–589.
- **Rieder, B., & Röhle, T.** (2017). Digital methods: From challenges to *Bildung*. In *The Datafied Society*. Amsterdam University Press.

---

## 12. Team and contact

| Role | Name | ORCID | Affiliation |
|---|---|---|---|
| Principal investigator | *to be completed* | | |
| Network analysis | *to be completed* | | |
| Ethnographic fieldwork | *to be completed* | | |

**Contact:** *to be completed* · **Funding:** *to be completed*
