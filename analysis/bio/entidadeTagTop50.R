dadosParticipacaoGeral = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\participacaoComunidades.csv", header = TRUE, sep = ';')
dadosEntidades = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\anotacoesBio.csv", header = TRUE, sep = ';')
dadosRespostas = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\respostasComunidades.csv", header = TRUE, sep = ';')
dadosTag = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\tags.csv", header = TRUE, sep = ';')

dadosTagBio <- subset(dadosTag, dadosTag$comunidade == 'BIO')

dadosComunidade <- subset(dadosParticipacaoGeral, dadosParticipacaoGeral$comunidade == 'BIO')
dadosComunidadeTop <- head(dadosComunidade, 50)

excludeEntities <- c('.pdf', 'strong', 'html', 'Nice', 'link', '.com', 'http', 'book', 'click', '.org', 'Wikipedia', 'en.wikipedia.org', 'wiki page')
#excludeEntities <- c()

#dadosEntidadesRespostasTop <- subset(dadosEntidades, dadosEntidades$tipo == 'texto_resposta' & 
#                                       !(dadosEntidades$surface %in% excludeEntities)
#                                     & dadosEntidades$idUsuario %in% dadosComunidadeTop$idUsuario)

dadosEntidadesPerguntasTop <- subset(dadosEntidades, 
                                     (dadosEntidades$tipo == 'texto_pergunta' | dadosEntidades$tipo == 'titulo_pergunta')  & 
                                       !(dadosEntidades$surface %in% excludeEntities)
                                     & dadosEntidades$idUsuario %in% dadosComunidadeTop$idUsuario)

dadosRespostasTop <- subset(dadosRespostas, dadosRespostas$anoCriacao >= 2012 & dadosRespostas$idUsuario %in% dadosComunidadeTop$idUsuario)



perguntaUniqueList <- unique(dadosRespostasTop$idPergunta)

colunas <- c("QUANT_ENTIDADE_COMUM_TAG" ,"QUANT_TAG", "QUANT_ENTIDADE")
numeroLinhas <- length(perguntaUniqueList)
numeroColunas <- length(colunas)


tabela <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(perguntaUniqueList,colunas))
#inicializando a tabela
for(p in perguntaUniqueList) {
  tabela[p, "QUANT_ENTIDADE_COMUM_TAG"] <- 0
  tabela[p, "QUANT_TAG"] <- 0
  tabela[p, "QUANT_ENTIDADE"] <- 0
  
}

contadorIteracao <- 1
totalIteracao <- numeroLinhas
contadorPerguntaComTagComumEntidade <- 0
contadorPerguntaComTagNaoComumEntidade <- 0
#para cada pergunta onde um top 50 respondeu
for(idPer in perguntaUniqueList) {
  print(paste(contadorIteracao, " de ", totalIteracao))
  contadorIteracao <- contadorIteracao + 1
  respostasFiltradaPelaPergunta = subset(dadosRespostasTop, dadosRespostasTop$idPergunta == idPer)
  idRespostaList <- as.character(respostasFiltradaPelaPergunta$id)
  
  #entidadesPerguntas <- tolower(as.character(subset(dadosEntidadesPerguntasTop, dadosEntidadesPerguntasTop$idText == idPer)$surface))
  entidadesPerguntas <- subset(dadosEntidadesPerguntasTop, dadosEntidadesPerguntasTop$idText == idPer)
 
  #entidadesRespostas <- tolower(as.character(subset(dadosEntidadesRespostasTop, dadosEntidadesRespostasTop$idText %in% idRespostaList)$surface))
  tags <- subset(dadosTagBio, dadosTagBio$idPergunta == idPer)

  tabela[idPer, "QUANT_ENTIDADE"] <- nrow(entidadesPerguntas)
  tabela[idPer, "QUANT_TAG"] <- nrow(tags)
  
  if(nrow(entidadesPerguntas) == 0){
    next
  }
  tagsComumEntidade <- subset(dadosTagBio, dadosTagBio$idPergunta == idPer & gsub("-", " ", tolower(dadosTagBio$nomeTag)) %in% tolower(entidadesPerguntas$surface))
  tabela[idPer, "QUANT_ENTIDADE_COMUM_TAG"] <- nrow(tagsComumEntidade)
  
  if(nrow(tagsComumEntidade) > 0 ) {
    contadorPerguntaComTagComumEntidade <- contadorPerguntaComTagComumEntidade + 1
  } else {
    contadorPerguntaComTagNaoComumEntidade <- contadorPerguntaComTagNaoComumEntidade + 1
  }
}


print(tabela)
write.table(tabela, file = "tabelaEntidadeTags.csv", sep = ";")
print(contadorPerguntaComTagComumEntidade)


