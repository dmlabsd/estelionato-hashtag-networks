# `/dictionaries` — Dicionários analíticos de codificação

O dicionário é o **coração interpretativo** do pipeline: é onde as decisões
analíticas ficam explícitas, auditáveis e reproduzíveis. Sem ele, a limpeza seria
uma caixa-preta.

## Arquivos

| Arquivo | Plataforma | Codificação | Entradas |
|---|---|---|---|
| `dicionario_instagram.xlsx` | Instagram | Manual, item a item | 291 |
| `dicionario_tiktok_preliminar.xlsx` | TikTok | Semiautomática (modelo IG) | 103 |
| `dicionario_tiktok_revisado.xlsx` | TikTok | Após validação humana | 103 |
| `MODELO_dicionario_*_a_codificar.xlsx` | — | Gerado por `03_cortes_frequencia.R` | — |

## Esquema

| Coluna | Obrigatória | Descrição |
|---|---|---|
| `tags` | ✅ | Hashtag original observada, em minúsculas, sem `#` |
| `ação` | ✅ | `M` (manter) · `U` (unificar) · `R` (remover) |
| `substituir por` | quando `ação = U` | Forma canônica de destino |
| `n` | TikTok | Frequência bruta observada |
| `justificativa` | TikTok | Racional da decisão |
| `ambiguo` | TikTok | Sinalização para validação humana |

## As três categorias

**M — Manter.** A hashtag integra o objeto da pesquisa e é preservada como nó.
Critério: estelionato, fraude, golpes, criminalidade, segurança, monetização,
empreendedorismo, enriquecimento, marketing digital, plataformas, viralização,
circulação de conteúdo e personas centrais.

**U — Unificar.** A hashtag é variante de outra forma e é substituída pela forma
canônica. Critério: variações ortográficas, singular/plural, acentuação,
equivalentes idiomáticos, versões com emoji, variantes de viralização.

**R — Remover.** Ruído sem relação temática. Critério: fandoms, celebridades,
futebol, música/personagens sem relação, memes sem vínculo, hashtags estrangeiras
irrelevantes, spam.

## Regra hierárquica para casos ambíguos

1. **`U`** quando há equivalência semântica clara com uma forma canônica.
2. **`R`** quando a hashtag pertence inequivocamente a um campo externo (gaming,
   edição de vídeo, fandom).
3. **`M`** quando integra um dos eixos da pesquisa **ou quando o Instagram já a
   havia codificado como M** — prioridade à comparabilidade entre plataformas.

## Núcleos canônicos de unificação

| Núcleo | Absorve |
|---|---|
| `fyp` | `fy`, `foryou`, `foryoupage`, `fouryou`, `fypage`, `fypシ`, `fypp`, todos os alongamentos, `vaiprofycaramba`; no TT também `parati` e elongações; no IG também `explore`, `reels`, `feed` |
| `viral` | `viraliza`, `viralvideo(s)`, `viraltiktok`, `videoviral`, `viral_video` |
| `trending` | `trend` |
| `dinheiro` | `money`; no IG o feixe de renda converge para `dinheiroextra` |
| `marketingdigital` | `market`, `marketing`, `mktdigital` (IG) |
| `estilo` | `estilodevida` (IG), `lifestyle` (TT) |
| `luxo` | `luxury`, `luxurylife`, `luxurylifestyle`, `mansion` (TT) |
| `musica` | `music`, `song`, `songs`, `slowed`, `slowedsongs`, `phonk` (TT) |
| `tropado7` | `tropado777`, `tropadosete` |
| `happynation` | `happy` |

## Decisão deliberada: entretenimento é M, não R

`musica`, `funk`, `humor` e `meme` foram mantidos como **M**. Eles **não são
ruído** — são o **invólucro cultural em que o discurso criminal é distribuído**.
Removê-los apagaria o achado de que o crime nunca circula sozinho nessas
plataformas. Trata-se de uma decisão analítica, e está registrada como tal.

## Casos sinalizados para validação humana (TikTok)

| Hashtag | Situação | Decisão aplicada |
|---|---|---|
| `ninoabravanel` / `nino` | Persona recorrente (34 ocorrências), mas o sobrenome remete a uma família de celebridades televisivas | **M**, com recomendação expressa de revisão — pode ser ruído de fandom. Aparece também na rede do Instagram, o que reforça a relevância |
| `aceofbase` | Nome de banda musical | **M** por comparabilidade — o Instagram a codificou como M |
| `ruyter`, `mckelvinho` | Personas do corpus, coocorrem com o núcleo criminal | **M**; exigem identificação. `ruyter` também figura na rede do Instagram |
| `entregatiktok` | Tratada como apelo de algoritmo | **U → fyp**; pode ser promoção de serviço de entrega |
| `status`, `casa`, `trabalhecomartistas`, `house`, `mansion`, `phonk` | Termos genéricos ou limítrofes | Decisão caso a caso, documentada na coluna `justificativa` |

## Distribuição

| Categoria | Instagram (n=291) | TikTok (n=103) |
|---|---|---|
| M | 107 (36,8%) | 43 (41,7%) |
| U | 87 (29,9%) | 51 (49,5%) |
| R | 97 (33,3%) | 9 (8,7%) |

A proporção muito maior de **U** no TikTok (≈50% vs 30%) e muito menor de **R**
(≈9% vs 33%) é, ela própria, um achado — ver README §3.5.

## Como estender o dicionário

1. Rode `scripts/03_cortes_frequencia.R` para gerar a planilha de codificação.
2. Preencha `ação` e, quando `U`, `substituir por`.
3. Documente na coluna `justificativa` toda decisão não óbvia — isso é o que
   torna a codificação auditável por um revisor.
4. Salve como `dicionario_<plataforma>.xlsx` e registre a mudança no CHANGELOG.
