# =============================================================================
# 99_anonimizar.R — Anonimização das bases antes da publicação
# Ver ETHICS.md e README §8.
#
# OBRIGATÓRIO antes de qualquer commit de dados em data/raw/.
#
# O documento metodológico estabelece a anonimização como CONSTITUTIVA do
# desenho da pesquisa, não como camada de conformidade posterior. O objeto —
# comunidades que veiculam representações de atos potencialmente criminosos —
# implica risco real de expor pessoas a reações persecutórias.
#
# O que este script faz:
#   1. remove colunas de autoria, IDs e URLs;
#   2. substitui identificadores de autor por pseudônimos estáveis (hash);
#   3. remove @menções e URLs do texto das legendas;
#   4. arredonda métricas de engajamento (dificulta reidentificação por busca);
#   5. emite um relatório do que foi removido.
#
# O que este script NÃO faz: garantir anonimato absoluto. Hashtags raras,
# combinações incomuns e o próprio texto das legendas podem permitir
# reidentificação. Revise manualmente antes de publicar.
# =============================================================================

source("scripts/00_config.R")
source("scripts/01_setup.R")

# Padrões de nomes de coluna a REMOVER integralmente.
PADROES_REMOVER <- c(
  "id$", "^id", "_id", "url", "link", "permalink",
  "author", "autor", "user", "usuario", "username", "nick", "handle",
  "profile", "perfil", "avatar", "thumbnail", "display_name",
  "location", "localizacao", "coord", "lat", "lon"
)

# Padrões de coluna a PSEUDONIMIZAR (preserva a estrutura de autoria sem
# revelar identidade — permite contar posts por autor sem saber quem é).
PADROES_PSEUDONIMIZAR <- c("author_id", "user_id", "owner_id")

pseudonimo <- function(x, sal = "estelionato-2026") {
  ifelse(is.na(x) | x == "", NA_character_,
         paste0("A", substr(
           vapply(paste0(sal, as.character(x)),
                  function(s) paste0(as.integer(utf8ToInt(substr(s, 1, 1))),
                                     sprintf("%08x", sum(utf8ToInt(s) * seq_along(utf8ToInt(s))))),
                  character(1), USE.NAMES = FALSE), 1, 10)))
}

limpar_texto <- function(x) {
  x <- as.character(x)
  x <- gsub("https?://\\S+", "[URL]", x)
  x <- gsub("@[A-Za-z0-9_.]+", "[USUARIO]", x)
  x <- gsub("[0-9]{2,3}[.\\s-]?[0-9]{4,5}[.\\s-]?[0-9]{4}", "[TELEFONE]", x)
  x <- gsub("[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", "[EMAIL]", x)
  x
}

anonimizar <- function(caminho_entrada, caminho_saida) {
  message("\n--- ", basename(caminho_entrada), " ---")
  dados <- readxl::read_excel(caminho_entrada)
  nomes <- tolower(names(dados))

  # 1. pseudonimizar antes de remover
  idx_pseudo <- which(sapply(nomes, function(n)
    any(sapply(PADROES_PSEUDONIMIZAR, function(p) grepl(p, n)))))
  for (i in idx_pseudo) {
    dados[[i]] <- pseudonimo(dados[[i]])
    message("  pseudonimizada: ", names(dados)[i])
  }
  nomes_pseudo <- names(dados)[idx_pseudo]

  # 2. remover colunas identificadoras
  idx_remover <- which(sapply(seq_along(nomes), function(i)
    !(names(dados)[i] %in% nomes_pseudo) &&
    any(sapply(PADROES_REMOVER, function(p) grepl(p, nomes[i])))))
  if (length(idx_remover) > 0) {
    message("  removidas: ", paste(names(dados)[idx_remover], collapse = ", "))
    dados <- dados[, -idx_remover, drop = FALSE]
  }

  # 3. limpar campos de texto livre
  idx_texto <- which(sapply(dados, is.character))
  for (i in idx_texto) dados[[i]] <- limpar_texto(dados[[i]])
  message("  texto higienizado em ", length(idx_texto), " colunas")

  # 4. arredondar métricas de engajamento
  padroes_metrica <- c("like", "comment", "share", "view", "play", "curtida")
  idx_metrica <- which(sapply(tolower(names(dados)), function(n)
    any(sapply(padroes_metrica, function(p) grepl(p, n)))))
  for (i in idx_metrica) {
    if (is.numeric(dados[[i]])) {
      dados[[i]] <- signif(dados[[i]], 2)
    }
  }
  if (length(idx_metrica) > 0) {
    message("  métricas arredondadas (2 dígitos significativos): ",
            paste(names(dados)[idx_metrica], collapse = ", "))
  }

  openxlsx::write.xlsx(dados, caminho_saida, overwrite = TRUE)
  message("  gravado: ", caminho_saida)
  message("  ", nrow(dados), " linhas x ", ncol(dados), " colunas")

  invisible(dados)
}

# --- execução ----------------------------------------------------------------
arquivos <- list.files(DIR_RAW, pattern = "\\.xlsx$", full.names = TRUE)
arquivos <- arquivos[!grepl("_anon\\.xlsx$", arquivos)]

if (length(arquivos) == 0) {
  message("Nenhum .xlsx encontrado em data/raw/.")
} else {
  for (f in arquivos) {
    saida <- sub("\\.xlsx$", "_anon.xlsx", f)
    anonimizar(f, saida)
  }
  message("\n>>> REVISE MANUALMENTE os arquivos *_anon.xlsx antes de publicar. <<<")
  message(">>> Verifique legendas, hashtags raras e combinações identificáveis. <<<")
}
