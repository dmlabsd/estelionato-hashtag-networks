# `legacy/` — Arquivos históricos

Coloque aqui os arquivos gerados pela implementação original do Apêndice B,
preservados para auditoria da equivalência com os arquivos corrigidos.

| Arquivo esperado | Por que preservar |
|---|---|
| `edges_instagram_2256linhas.csv` | Contém a duplicação recíproca de arestas (2.256 linhas para 1.569 pares únicos) descrita no README §3.7. Preservá-lo permite verificar que a correção não altera a leitura analítica. |

Verificação de equivalência:

```r
source("scripts/05_construir_rede.R")
original  <- gerar_arestas(posts, vocab, canonizar = FALSE)  # 2.256 linhas
corrigido <- gerar_arestas(posts, vocab, canonizar = TRUE)   # 1.569 linhas

# Os pesos devem somar o mesmo total após canonização do arquivo original:
library(dplyr)
original %>%
  mutate(a = pmin(Source, Target), b = pmax(Source, Target)) %>%
  count(a, b, wt = Weight, name = "W") %>%
  nrow()   # deve dar 1.569
```
