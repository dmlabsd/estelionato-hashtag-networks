# `/figures` — Figuras das redes

## Arquivos esperados

| Arquivo | Conteúdo | Base |
|---|---|---|
| `fig01_rede_instagram_backbone.png` | Rede do Instagram | Backbone (α < 0,10) **+ corte de peso ≥ 7** |
| `fig02_rede_tiktok_backbone.png` | Rede do TikTok | Backbone (α < 0,10) |
| `fig03_rede_combinada.png` | Sobreposição entre plataformas | Rede combinada, **sem backbone** |
| `gephi/*.gephi` | Projetos do Gephi para reabrir e reeditar | — |

Exporte também em formato vetorial (`.svg` ou `.pdf`) para submissão — a maioria
dos journals exige. Resolução mínima recomendada para raster: **600 dpi**.

## ⚠️ A cor significa coisas diferentes em figuras diferentes

Este é o ponto mais fácil de errar na leitura do conjunto.

**Redes individuais (Fig. 1 e 2) — cor = comunidade temática:**

| Cor | Eixo |
|---|---|
| 🟠 Laranja | Criminal-jurídico-financeiro |
| 🟣 Roxo | Viralização |
| 🟢 Verde | Estilo de vida / enriquecimento |

**Rede combinada (Fig. 3) — cor = origem do nó:**

| Cor | Origem |
|---|---|
| 🔵 Azul-claro | Presente em ambas as plataformas |
| ⚪ Cinza | Exclusivo do Instagram |
| 🟢 Verde | Exclusivo do TikTok |

**O verde muda de sentido entre os dois tipos de figura** — tema nas individuais,
plataforma na combinada. Por isso **cada figura precisa de legenda própria**
explicitando o que a cor representa naquela imagem. Isso não é redundância
editorial: é condição de leitura correta.

## Legendas sugeridas

> **Figura 1.** Rede de coocorrência de hashtags do Instagram (espinha dorsal,
> *disparity filter* α < 0,10, com corte adicional de peso ≥ 7 para legibilidade).
> Cor = comunidade temática: laranja, criminal-jurídico-financeiro; roxo,
> viralização e personas; verde, enriquecimento/estilo de vida. Tamanho do nó ∝
> grau ponderado. Métricas estruturais calculadas sobre a rede completa (111 nós,
> 1.569 arestas, densidade 0,262, Q = 0,329).

> **Figura 2.** Rede de coocorrência de hashtags do TikTok (espinha dorsal,
> *disparity filter* α < 0,10). Cor = comunidade temática, mesma convenção da
> Figura 1. Tamanho do nó ∝ grau ponderado. Métricas sobre a rede completa
> (47 nós, 430 arestas, densidade 0,415, Q = 0,148).

> **Figura 3.** Rede combinada Instagram + TikTok (117 nós, 1.690 arestas).
> **Cor = origem do nó**, não comunidade temática: azul-claro, presente em ambas;
> cinza, exclusivo do Instagram; verde, exclusivo do TikTok. Pesos normalizados
> por corpus (coocorrências por 1.000 publicações). *Ressalva:* a assimetria
> entre nós exclusivos do Instagram (70) e do TikTok (6) reflete, em parte, o
> corpus maior do Instagram e o teto de raspagem que limitou o TikTok.


