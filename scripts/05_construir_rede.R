# =============================================================================
# 05_construir_rede.R — Construção dos nós e arestas para o Gephi
# Corresponde ao Apêndice B.10–B.14 do documento metodológico. Ver README §3.7.
#
# Nó       = hashtag canônica; atributo Frequency = nº de posts em que aparece.
# Aresta   = par de hashtags no mesmo post; Weight = nº de posts com o par.
#
# CORREÇÃO EM RELAÇÃO AO APÊNDICE B
# O script original chamava combn(tags, 2) SEM ordenar previamente as tags, o
# que fez o arquivo do Instagram registrar a mesma relação não-direcionada em
# duas linhas (viral->fyp peso 145 e fyp->viral peso 147; 2.256 linhas para
# 1.569 pares únicos). O próprio documento recomenda a correção (§8.3).
# Aqui aplicamos sort() antes do combn, produzindo arestas canônicas e únicas.
# Como o grafo é não-direcionado, a leitura analítica não se altera: no Gephi
# os pares recíprocos do arquivo antigo seriam fundidos de qualquer modo.
#
# Para auditar a equivalência com o arquivo histórico, use
# gerar_arestas(..., canonizar = FALSE).
# =============================================================================

source("scripts/00_config.R")
source("scripts/01_setup.R")

# --- vocabulário codificado --------------------------------------------------
vocabulario_codificado <- function(caminho_dic) {
  dic <- readxl::read_excel(caminho_dic)
  nomes <- tolower(names(dic))
  nomes <- gsub("ç", "c", nomes); nomes <- gsub("ã", "a", nomes)
  names(dic)[nomes %in% c("acao", "action")]                  <- "acao"
  names(dic)[nomes %in% c("substituir por", "substituir_por")] <- "substituir_por"

  dic <- dic %>%
    dplyr::mutate(
      tags           = stringr::str_trim(tolower(as.character(tags))),
      acao           = stringr::str_trim(toupper(as.character(acao))),
      substituir_por = stringr::str_trim(tolower(as.character(substituir_por)))
    )

  mantidas   <- dic$tags[dic$acao == "M" & !is.na(dic$acao)]
  canonicas  <- dic$substituir_por[dic$acao == "U" & !is.na(dic$acao)]
  canonicas  <- canonicas[!is.na(canonicas) & canonicas != ""]

  sort(unique(c(mantidas, canonicas)))
}

# --- nós (contagem por presença-por-post) ------------------------------------
gerar_nos_por_post <- function(posts, vocab) {
  listas <- lapply(posts, function(p) {
    if (is.na(p) || p == "") return(character(0))
    t <- unique(stringr::str_trim(unlist(strsplit(p, ","))))
    t[t %in% vocab]
  })
  freq <- table(unlist(listas))
  data.frame(
    Id        = names(freq),
    Label     = names(freq),
    Frequency = as.integer(freq),
    stringsAsFactors = FALSE
  )[order(-as.integer(freq)), ]
}

# --- arestas -----------------------------------------------------------------
gerar_arestas <- function(posts, vocab, canonizar = TRUE) {
  lista <- list()

  for (i in seq_along(posts)) {
    p <- posts[i]
    if (is.na(p) || p == "") next

    tags <- stringr::str_trim(unlist(strsplit(p, ",")))
    tags <- unique(tags)                     # deduplicação intra-post
    tags <- tags[tags %in% vocab]            # restrição ao vocabulário codificado
    if (length(tags) < 2) next

    if (canonizar) tags <- sort(tags)        # <-- CORREÇÃO (ver cabeçalho)

    pares <- t(utils::combn(tags, 2))
    lista[[length(lista) + 1]] <- data.frame(
      Source = pares[, 1], Target = pares[, 2], stringsAsFactors = FALSE
    )
  }

  if (length(lista) == 0) return(data.frame())

  dplyr::bind_rows(lista) %>%
    dplyr::count(Source, Target, name = "Weight") %>%
    dplyr::arrange(dplyr::desc(Weight)) %>%
    dplyr::mutate(Type = "Undirected")
}

# --- execução ----------------------------------------------------------------
processar_plataforma <- function(spec) {
  message("\n=== ", spec$rotulo, " ===")

  caminho_limpo <- file.path(DIR_PROCESSED, paste0(spec$nome, "_limpo.xlsx"))
  caminho_dic   <- file.path(DIR_DICT, spec$dicionario)

  if (!file.exists(caminho_limpo)) {
    warning("Execute 04_aplicar_dicionario.R primeiro.", call. = FALSE)
    return(invisible(NULL))
  }

  dados <- readxl::read_excel(caminho_limpo)
  vocab <- vocabulario_codificado(caminho_dic)
  posts <- dados$hashtags_limpas

  message("Vocabulário codificado: ", length(vocab), " formas canônicas")

  nodes <- gerar_nos_por_post(posts, vocab)
  edges <- gerar_arestas(posts, vocab, canonizar = TRUE)

  esp <- ESPERADO[[spec$nome]]
  checar("nós",                  nrow(nodes),        esp$nos)
  checar("arestas únicas",       nrow(edges),        esp$arestas_unicas)
  checar("peso total",           sum(edges$Weight),  esp$peso_total)

  utils::write.csv(nodes, file.path(DIR_NETWORK, paste0("nodes_", spec$nome, ".csv")),
                   row.names = FALSE, fileEncoding = "UTF-8")
  utils::write.csv(edges, file.path(DIR_NETWORK, paste0("edges_", spec$nome, ".csv")),
                   row.names = FALSE, fileEncoding = "UTF-8")

  message("Gravado: data/network/nodes_", spec$nome, ".csv e edges_", spec$nome, ".csv")
  invisible(list(nodes = nodes, edges = edges))
}

redes <- lapply(PLATAFORMAS, processar_plataforma)
