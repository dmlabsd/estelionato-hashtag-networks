# Protocolo ético e de proteção de dados

> A ética da pesquisa é assumida como **constitutiva de sua construção**, e não
> como uma camada de conformidade aposta *a posteriori*. As escolhas de não
> interação, anonimização e referência indireta são parte do desenho do estudo.

---

## 1. Por que este objeto exige cuidado específico

A pesquisa observa comunidades que operam **regimes de visibilidade ambíguos** e
que veiculam representações explícitas de atos potencialmente enquadráveis como
criminosos. Isso cria um risco concreto e assimétrico: **a própria pesquisa pode
expor as pessoas que publicam esse conteúdo a reações persecutórias** — policiais,
midiáticas ou de linchamento digital — que não decorreriam de suas publicações
isoladamente, mas de sua agregação, sistematização e circulação em contexto
acadêmico.

O conteúdo é público no sentido técnico. Isso **não** implica consentimento para
agregação, análise e republicação. A pesquisa opera, portanto, sob o princípio de
que **a publicidade do dado não dispensa a proteção da pessoa**.

## 2. Coleta

| Medida | Implementação |
|---|---|
| Contas dedicadas | Contas novas, criadas exclusivamente para a coleta, sem histórico pessoal |
| Não interação | Nenhuma curtida, nenhum comentário, nenhum seguimento de perfis |
| Sem extração de mídia | Vídeos arquivados pelo recurso nativo de "salvar" da plataforma, sem download externo |
| Observação não participante | A conta não emite sinais de engajamento que realimentem o algoritmo ou sejam percebidos pelos perfis observados |

## 3. Tratamento e publicação de dados

As bases disponibilizadas neste repositório são **versões anonimizadas** dos
conjuntos coletados. As bases originais não são publicadas e permanecem
armazenadas apenas localmente pela equipe de pesquisa.

A anonimização preserva a **estrutura das bases** (mesmas colunas, mesmos nomes)
para que os scripts possam ser executados sem alterações, mas substitui ou
remove toda informação que permita identificar pessoas ou localizar as
publicações originais.

| Tipo de informação | Tratamento | Campos |
|---|---|---|
| Nomes de usuário e nomes completos | Substituídos por códigos fictícios (`usuario_1`, `nome_1`…). A mesma conta recebe sempre o mesmo código | `author`, `author_full(name)`, `coauthors`, `coauthor_fullnames`, `usertags` |
| Identificadores de publicações | Substituídos por códigos sequenciais (`post_1`…), preservando a relação entre publicações e respostas | `id`, `thread_id`, `parent_id`, `coauthor_ids` |
| Texto das publicações | Removido e substituído por `[texto removido]` | `body`, `stickers` |
| Links e mídias | Substituídos por um endereço fictício (`https://example.com`) | URLs de publicação, perfil, imagens, vídeos e áudio |
| Localização | Coordenadas removidas; nomes e IDs de lugares codificados | `location_latlong`, `location_name`, `location_id` |
| Métricas da conta (TikTok) | Removidas, por permitirem identificar perfis | `author_followers`, `author_likes`, `author_videos` |
| Áudios originais (TikTok) | Nomes que contêm o usuário substituídos por "som original"; IDs e autores codificados | `music_name`, `music_id`, `music_author` |

**Campos mantidos.** Hashtags (brutas e limpas), datas, tipo de mídia e métricas
de engajamento das publicações, necessários para as análises.

**Correspondência entre códigos e dados originais.** Não é publicada. Os códigos
não permitem reconstruir nomes de usuário nem localizar as publicações.

**Dados derivados.** Tabelas de frequência, nós e arestas das redes contêm
apenas hashtags e contagens agregadas, sem qualquer informação sobre autoria.

**Referência indireta.** Nos textos resultantes da pesquisa, publicações não são
citadas literalmente nem atribuídas a perfis, para evitar que possam ser
localizadas por busca nas plataformas.