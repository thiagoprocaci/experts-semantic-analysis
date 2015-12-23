#dados = read.csv("C:\\Users\\thiag_000\\Desktop\\analises\\participacaoComunidades.csv", header = TRUE, sep = ';')
dados = read.csv("/home/thiagoprocaci/analises/participacaoComunidades.csv", header = TRUE, sep = ';')

dadosBio = subset(dados, dados$comunidade == 'BIO')
dadosTa = subset(dados, dados$comunidade == 'TA')
dadosFis = subset(dados, dados$comunidade == 'FIS')
dadosElu = subset(dados, dados$comunidade == 'ELU')


dadosBioTop <- head(dadosBio, 50)
dadosTaTop <- head(dadosTa, 50)
dadosFisTop <- head(dadosFis, 50)
dadosEluTop <- head(dadosElu, 50)

dadosBio <- NULL
dadosTa <- NULL
dadosFis <- NULL
dadosElu <- NULL


colunas <- c("MediaResposta", "MediaPergunta", "MediaComentarioPergunta", "MediaComentarioResposta")

nomeComunidadeList <- unique(dados$comunidade)
numeroLinhas <- length(nomeComunidadeList)
numeroColunas <- length(colunas)


tabela <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(nomeComunidadeList,colunas))

for(comunidade in nomeComunidadeList) {
  MediaResposta <- 0
  MediaPergunta <- 0
  MediaComentarioPergunta <- 0
  MediaComentarioResposta <- 0
  
  if(comunidade == 'BIO') {
    MediaResposta <- mean(dadosBioTop$respostas)
    MediaPergunta <- mean(dadosBioTop$perguntas)
    MediaComentarioPergunta <- mean(dadosBioTop$comentariospergunta)
    MediaComentarioResposta <- mean(dadosBioTop$comentariosresposta)
  }
  
  if(comunidade == 'TA') {
    MediaResposta <- mean(dadosTaTop$respostas)
    MediaPergunta <- mean(dadosTaTop$perguntas)
    MediaComentarioPergunta <- mean(dadosTaTop$comentariospergunta)
    MediaComentarioResposta <- mean(dadosTaTop$comentariosresposta)
  }
  
  if(comunidade == 'FIS') {
    MediaResposta <- mean(dadosFisTop$respostas)
    MediaPergunta <- mean(dadosFisTop$perguntas)
    MediaComentarioPergunta <- mean(dadosFisTop$comentariospergunta)
    MediaComentarioResposta <- mean(dadosFisTop$comentariosresposta)
  }
  
  if(comunidade == 'ELU') {
    MediaResposta <- mean(dadosEluTop$respostas)
    MediaPergunta <- mean(dadosEluTop$perguntas)
    MediaComentarioPergunta <- mean(dadosEluTop$comentariospergunta)
    MediaComentarioResposta <- mean(dadosEluTop$comentariosresposta)
  }
  tabela[comunidade, "MediaResposta" ] <- MediaResposta
  tabela[comunidade, "MediaPergunta" ] <- MediaPergunta
  tabela[comunidade, "MediaComentarioPergunta" ] <- MediaComentarioPergunta
  tabela[comunidade, "MediaComentarioResposta" ] <- MediaComentarioResposta
}

print(tabela)

