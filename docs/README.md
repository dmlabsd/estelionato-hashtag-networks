# `/docs` — Documentação metodológica

| Arquivo | Conteúdo |
|---|---|
| `documento_metodologico_integrado.md` | Memória metodológica completa (12 seções + apêndices A e B) |
| `documento_metodologico_integrado.pdf` | Versão para depósito no Zenodo como *technical report* |
| `PARAMETROS_GEPHI.md` | Todos os parâmetros de layout, filtro e aparência |
| `appendix/apendice_a_inventario_arquivos.md` | Inventário completo dos arquivos do estudo |
| `appendix/apendice_b_scripts.md` | Scripts originais em R, como referência histórica |

## Depósito do relatório no Zenodo

O documento metodológico é suficientemente detalhado para funcionar como
**technical report / methodological report** autônomo. Recomenda-se depositá-lo
no Zenodo **separadamente** do repositório de código:

1. Converter para PDF com paginação, sumário e metadados de autoria.
2. Depositar no Zenodo com `upload_type: publication`, `publication_type: report`.
3. Vincular ao repositório pelo campo *related identifiers*, relação
   `isSupplementedBy` (do relatório para o repositório) e `isSupplementTo`
   (do repositório para o relatório).
4. Citar o DOI resultante no artigo internacional e no capítulo do livro.

Isso dá ao relatório uma **existência citável própria**, independente da
publicação do artigo — útil quando o artigo tem limite de palavras e a
metodologia não cabe no corpo do texto.
