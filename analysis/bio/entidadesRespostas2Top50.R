dadosParticipacaoGeral = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\participacaoComunidades.csv", header = TRUE, sep = ';')
dadosEntidades = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\anotacoesBio.csv", header = TRUE, sep = ';')
dadosRespostas = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\respostasComunidades.csv", header = TRUE, sep = ';')
dadosTag = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\tags.csv", header = TRUE, sep = ';')

dadosTagBio <- subset(dadosTag, dadosTag$comunidade == 'BIO')

dadosComunidade <- subset(dadosParticipacaoGeral, dadosParticipacaoGeral$comunidade == 'BIO')
dadosComunidadeTop <- head(dadosComunidade, 50)

excludeEntities <- c('.pdf', 'strong', 'html', 'Nice', 'link', '.com', 'http', 'book', 'click', '.org', 'Wikipedia', 'en.wikipedia.org', 'wiki page')
#excludeEntities <- c()

dadosEntidadesRespostasTop <- subset(dadosEntidades, dadosEntidades$tipo == 'texto_resposta' & 
                                       !(dadosEntidades$surface %in% excludeEntities)
                                     & dadosEntidades$idUsuario %in% dadosComunidadeTop$idUsuario)

dadosEntidadesPerguntasTop <- subset(dadosEntidades, 
                                     (dadosEntidades$tipo == 'texto_pergunta' | dadosEntidades$tipo == 'titulo_pergunta')  & 
                                       !(dadosEntidades$surface %in% excludeEntities)
                                     & dadosEntidades$idUsuario %in% dadosComunidadeTop$idUsuario)

dadosRespostasTop <- subset(dadosRespostas, dadosRespostas$anoCriacao >= 2012 & dadosRespostas$idUsuario %in% dadosComunidadeTop$idUsuario)


contadorPerguntaComTagComumEntidade <- 0
contadorPerguntaComTagNaoComumEntidade <- 0
totalRespostaComEntidadeIdentificada <- 0


perguntaUniqueList <- unique(dadosRespostasTop$idPergunta)

contadorIteracao <- 1
totalIteracao <- length(perguntaUniqueList)

#para cada pergunta onde um top 50 respondeu
for(idPer in perguntaUniqueList) {
  print(paste(contadorIteracao, " de ", totalIteracao))
  contadorIteracao <- contadorIteracao + 1
  respostasFiltradaPelaPergunta = subset(dadosRespostasTop, dadosRespostasTop$idPergunta == idPer)
  idRespostaList <- as.character(respostasFiltradaPelaPergunta$id)
  
  #entidadesPerguntas <- subset(dadosEntidadesPerguntasTop, dadosEntidadesPerguntasTop$idText == idPergunta)
  entidadesRespostas <- subset(dadosEntidadesRespostasTop, dadosEntidadesRespostasTop$idText %in% idRespostaList)
  if(nrow(entidadesRespostas) > 0) {
    totalRespostaComEntidadeIdentificada <- 1 + totalRespostaComEntidadeIdentificada
    tags <- subset(dadosTagBio, dadosTagBio$idPergunta == idPer & gsub("-", " ",tolower(dadosTagBio$nomeTag)) %in%  tolower(entidadesRespostas$surface))
    
    if(nrow(tags) > 0 ) {
      contadorPerguntaComTagComumEntidade <- contadorPerguntaComTagComumEntidade + 1
    } else {
      contadorPerguntaComTagNaoComumEntidade <- contadorPerguntaComTagNaoComumEntidade + 1
    }
  }
}

totalRespostaTop50 <- length(unique(dadosRespostasTop$id))

print(paste('Total respostas do Top 50 depois de 2012: ', totalRespostaTop50))
print(paste('Total respostas doo Top 50 depois de 2012 e que foram identificadas entidades: ', totalRespostaComEntidadeIdentificada))
print(paste('Porcentagem respostas (depois de 2012 que possuem entidade) com pelo menos uma entidade comum a uma tag: ', ((contadorPerguntaComTagComumEntidade * 100)/(contadorPerguntaComTagComumEntidade + contadorPerguntaComTagNaoComumEntidade))))
print(paste('Porcentagem respostas (depois de 2012 que possuem entidade) com nenhuma entidade comum a uma tag: ', ((contadorPerguntaComTagNaoComumEntidade * 100)/(contadorPerguntaComTagComumEntidade + contadorPerguntaComTagNaoComumEntidade))))


