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

### 3.1 O que **não** deve ser publicado

- Nomes de usuário, @handles, nomes de exibição
- IDs de publicação, IDs de autor não pseudonimizados
- URLs ou permalinks de publicações
- Fotos de perfil, thumbnails, qualquer mídia identificável
- Dados de geolocalização
- Legendas íntegras que contenham menções, telefones, e-mails ou dados pessoais

### 3.2 O que pode ser publicado

- Hashtags (o objeto analítico da pesquisa)
- Tabelas de frequência e dicionários de codificação
- Arquivos de nós e arestas das redes
- Métricas agregadas e estatísticas descritivas
- Legendas higienizadas, quando estritamente necessárias à análise
- IDs de autor **pseudonimizados** (preservam a estrutura de autoria sem revelar identidade)

### 3.3 Procedimento obrigatório

```r
source("scripts/99_anonimizar.R")
```

Este script remove colunas identificadoras, pseudonimiza IDs de autor, higieniza
texto livre (URLs, @menções, telefones, e-mails) e arredonda métricas de
engajamento — o arredondamento dificulta a reidentificação por busca reversa de
números exatos de curtidas.

> ⚠️ **O script não garante anonimato absoluto.** Hashtags raras, combinações
> incomuns e o próprio texto das legendas podem permitir reidentificação por
> busca. **Revisão manual antes de qualquer publicação é obrigatória.**

### 3.4 Checklist antes de cada commit em `data/`

- [ ] `99_anonimizar.R` executado sobre todos os arquivos
- [ ] Nenhuma coluna de autoria, ID bruto ou URL remanescente
- [ ] Legendas revisadas manualmente por amostragem
- [ ] Hashtags que constituem nomes próprios identificáveis avaliadas caso a caso
- [ ] `git diff` inspecionado antes do `git push`

> **Nota sobre o Git:** um dado publicado por engano **permanece no histórico do
> repositório mesmo após ser removido em um commit posterior**. Se isso ocorrer,
> não basta apagar o arquivo — é necessário reescrever o histórico
> (`git filter-repo`) e forçar o push, e assumir que o dado pode ter sido
> clonado nesse intervalo. **Verificar antes é a única salvaguarda efetiva.**

## 4. Redação de textos derivados

- **Anonimização** dos nomes de usuário mencionados no artigo e no capítulo.
- **Referência indireta** aos dados de campo, evitando descrições que permitam
  identificar perfis ou publicações específicas.
- **Omissão dos IDs** das publicações referenciadas no corpo do texto — tanto por
  resguardo ético quanto por fluidez narrativa.

### 4.1 O caso das personas

Algumas hashtags do corpus são **nomes de pessoas** (`raul`, `ruyter`,
`mckelvinho`, `ninoabravanel`, `buzeira`). Elas são analiticamente centrais —
funcionam como pontes entre o núcleo criminal e o eixo de viralização — e não
podem simplesmente ser removidas sem destruir o achado.

Critério adotado: essas hashtags são tratadas como **marcadores discursivos**, não
como identificação de indivíduos. A análise incide sobre a posição estrutural da
hashtag na rede, não sobre a pessoa. Nenhuma afirmação sobre conduta individual,
autoria de crime ou responsabilidade penal é feita ou pode ser derivada dos
resultados.

> Esta é uma zona genuinamente cinzenta. A equipe deve revisitar o critério antes
> da submissão e considerar, se o comitê de ética assim recomendar, a substituição
> dos nomes por códigos (`PERSONA_01`) nos arquivos publicados, mantendo a chave
> de correspondência fora do repositório.

## 5. Aprovação ética

| Item | Situação |
|---|---|
| Comitê de Ética em Pesquisa (CEP/CONEP) | *a preencher* |
| Número do parecer | *a preencher* |
| Data de aprovação | *a preencher* |
| Dispensa (se aplicável) e justificativa | *a preencher* |

> Pesquisas com dados públicos de mídias sociais nem sempre exigem submissão ao
> CEP no Brasil, mas **journals internacionais frequentemente solicitam uma
> declaração explícita** — de aprovação ou de dispensa fundamentada. Recomenda-se
> resolver isso antes da submissão, não depois.

## 6. Contato para questões éticas

*a preencher* — e-mail institucional para solicitações de remoção de dados ou
esclarecimentos sobre o tratamento aplicado.

---

**Referências de apoio**

- Franzke, A. S., Bechmann, A., Zimmer, M., Ess, C., & Association of Internet
  Researchers (2020). *Internet Research: Ethical Guidelines 3.0*. AoIR.
- Markham, A., & Buchanan, E. (2012). *Ethical Decision-Making and Internet
  Research: Recommendations from the AoIR Ethics Working Committee (Version 2.0)*.
- Brasil. Lei nº 13.709/2018 (Lei Geral de Proteção de Dados Pessoais), art. 4º,
  II, "b" — tratamento para fins acadêmicos.
