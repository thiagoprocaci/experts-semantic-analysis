dadosParticipacaoGeral = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\participacaoComunidades.csv", header = TRUE, sep = ';')
dadosRespostas = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\respostasComunidades.csv", header = TRUE, sep = ';')

#dadosParticipacaoGeral = read.csv("/home/thiagoprocaci/analises/participacaoComunidades.csv", header = TRUE, sep = ';')
#dadosRespostas = read.csv("/home/thiagoprocaci/analises/respostasComunidades.csv", header = TRUE, sep = ';')

dadosBio = subset(dadosParticipacaoGeral, dadosParticipacaoGeral$comunidade == 'BIO')

resumo <- summary(dadosBio$reputacao)
primeiroQuartil <- resumo[2]
terceiroQuartil <- resumo[5]
dadosComunidadeTop <- subset(dadosParticipacaoGeral, dadosParticipacaoGeral$comunidade == 'BIO' & dadosParticipacaoGeral$reputacao >= primeiroQuartil & dadosParticipacaoGeral$reputacao <= terceiroQuartil)


usuarioList <- unique(dadosComunidadeTop$idUsuario)
top50DadosRespostas <- subset(dadosRespostas, dadosRespostas$idUsuario %in% usuarioList)
dadosRespostasComunidade <- subset(dadosRespostas, dadosRespostas$comunidade == 'BIO' & dadosRespostas$anoCriacao >= 2012)

colunas <- c(unique(sort(substr(dadosRespostasComunidade$dataCriacao, 1, 7))), "SOMA_VOTE_UP", "MEDIA" , "REPUTACAO")
numeroLinhas <- length(usuarioList)
numeroColunas <- length(colunas)


tabela <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(usuarioList,colunas))
#inicializando a tabela
for(usuario in usuarioList) {
  for(coluna in colunas) {
    tabela[usuario, coluna] <- 0
  }
}


for(i in 1:nrow(top50DadosRespostas)) {
  row <- top50DadosRespostas[i,] 
  usuario <- as.character(row$idUsuario)
  ano <- as.numeric(row$anoCriacao)
  anoMes <- as.character(substr(row$dataCriacao, 1, 7))
  votesUp <- row$votosPositivos
  if(ano >= 2012) {
    tabela[usuario, anoMes] <- tabela[usuario, anoMes] + votesUp
  } 
}

medias <- c()
for(usuario in usuarioList) {
  for(coluna in colunas) {
    if(coluna != "SOMA_VOTE_UP" & coluna != "REPUTACAO" & coluna != "MEDIA") {
      tabela[usuario, "SOMA_VOTE_UP"] <- tabela[usuario, coluna] + tabela[usuario, "SOMA_VOTE_UP"]  
    }
  }
  tabela[usuario, "MEDIA"] <- (tabela[usuario, "SOMA_VOTE_UP"]/(length(colunas) - 3))
  tabela[usuario, "REPUTACAO"] <- subset(dadosComunidadeTop, dadosComunidadeTop$idUsuario == usuario)$reputacao
  medias <- c(medias, as.numeric(tabela[usuario, "MEDIA"]))
}

print(tabela)
print(paste("Analise de ", as.character(length(colunas) - 3), " meses"))

#hist(medias, breaks = 50, xlab = "Average Answers", ylab = "Frequency", main = "Average Answers")
boxplot(medias,  ylab = "Average Votes Up")
print(summary(medias))
