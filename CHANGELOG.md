# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).
Versionamento conforme [SemVer](https://semver.org/lang/pt-BR/).

Cada versão marcada com tag no GitHub gera automaticamente um DOI no Zenodo.

## [Não publicado]

### A fazer antes da v1.0.0
- [ ] Definir a licença e substituir `LICENSE`
- [ ] Preencher autoria, ORCID e afiliação em `CITATION.cff` e `.zenodo.json`
- [ ] Executar `scripts/99_anonimizar.R` e revisar manualmente as saídas
- [ ] Depositar as bases em `data/raw/` e `data/processed/`
- [ ] Depositar os dicionários em `dictionaries/`
- [ ] Depositar os arquivos de rede em `data/network/`
- [ ] Exportar as figuras finais e os projetos `.gephi` para `figures/`
- [ ] Converter o documento metodológico para `docs/` (Markdown + PDF)
- [ ] Ativar a integração Zenodo ↔ GitHub
- [ ] Criar a release `v1.0.0` e substituir `10.5281/zenodo.XXXXXXX` nos badges

## [0.1.0] — 2026-08-07

### Adicionado
- Estrutura de diretórios do repositório (`/data`, `/scripts`, `/dictionaries`,
  `/figures`, `/docs`)
- `README.md` (PT-BR) e `README.en.md` (EN) com o fluxo metodológico completo
- Scripts em R modularizados a partir do Apêndice B do documento metodológico
  (`00_config` a `08_rede_combinada`, `99_anonimizar`, `run_all`)
- `ETHICS.md` com o protocolo ético e de anonimização
- `CITATION.cff` e `.zenodo.json` para citação e depósito
- `docs/PARAMETROS_GEPHI.md` com todos os parâmetros de layout e filtro

### Corrigido
- `05_construir_rede.R` aplica `sort()` ao par antes de `combn()`, eliminando a
  duplicação recíproca de arestas observada no arquivo do Instagram
  (2.256 linhas para 1.569 pares únicos). Correção recomendada pelo próprio
  documento metodológico (§8.3). O arquivo histórico é preservado em
  `data/network/legacy/` para auditoria.
- `04_aplicar_dicionario.R` substitui a busca linear por `filter()` dentro do
  laço por lookup em ambiente hash. Resultado idêntico, execução muito mais
  rápida.
