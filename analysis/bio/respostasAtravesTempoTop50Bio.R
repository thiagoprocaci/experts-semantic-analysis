dadosParticipacaoGeral = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\participacaoComunidades.csv", header = TRUE, sep = ';')
dadosRespostas = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\respostasComunidades.csv", header = TRUE, sep = ';')

#dadosParticipacaoGeral = read.csv("/home/thiagoprocaci/analises/participacaoComunidades.csv", header = TRUE, sep = ';')
#dadosRespostas = read.csv("/home/thiagoprocaci/analises/respostasComunidades.csv", header = TRUE, sep = ';')

dadosComunidade <- subset(dadosParticipacaoGeral, dadosParticipacaoGeral$comunidade == 'BIO')
dadosComunidadeTop <- head(dadosComunidade, 50)


usuarioList <- unique(dadosComunidadeTop$idUsuario)
top50DadosRespostas <- subset(dadosRespostas, dadosRespostas$idUsuario %in% usuarioList)
dadosRespostasComunidade <- subset(dadosRespostas, dadosRespostas$comunidade == 'BIO' & dadosRespostas$anoCriacao >= 2012)

colunas <- c(unique(sort(substr(dadosRespostasComunidade$dataCriacao, 1, 7))), "SOMA" ,"MEDIA", "REPUTACAO")
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
  if(ano >= 2012) {
    tabela[usuario, anoMes] <- tabela[usuario, anoMes] + 1  
  } #else {
    #print(paste("Ha dados em ", anoMes))
#  }
}


medias <- c()
for(usuario in usuarioList) {
  for(coluna in colunas) {
    if(coluna != "SOMA" & coluna != "MEDIA" & coluna != "REPUTACAO") {
      tabela[usuario, "SOMA"] <- tabela[usuario, coluna] + tabela[usuario, "SOMA"]  
    }
  }
  tabela[usuario, "MEDIA"] <- (tabela[usuario, "SOMA"]/(length(colunas) - 3))
  tabela[usuario, "REPUTACAO"] <- subset(dadosComunidadeTop, dadosComunidadeTop$idUsuario == usuario)$reputacao
  medias <- c(medias, as.numeric(tabela[usuario, "MEDIA"]))
}

print(tabela)
#write.table(tabela,file="resultados\\bioRespostasTempo.csv", sep = ";" , row.names = TRUE)
print(paste("Analise de ", as.character(length(colunas) - 3), " meses"))

#hist(medias, breaks = 50, xlab = "Average Answers", ylab = "Frequency", main = "Average Answers")
boxplot(medias,  ylab = "Average Answer")
print(summary(medias))



