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

totalPerguntaComEntidadeIdentificada <- 0
entidadesIdentificadasPerguntas <- c()
contadorPerguntaComTagComumEntidade <- 0
contadorPerguntaComTagNaoComumEntidade <- 0

totalRespostaComEntidadeComumPergunta <- 0

contadorIteracao <- 1
totalIteracao <- length(unique(dadosRespostasTop$idPergunta))
#para cada pergunta onde um top 50 respondeu
for(idPer in unique(dadosRespostasTop$idPergunta)) {
  #print(paste(contadorIteracao, " de ", totalIteracao))
  contadorIteracao <- contadorIteracao + 1
  # entidades extraidas das perguntas
  entidadesPergunta <- subset(dadosEntidadesPerguntasTop, dadosEntidadesPerguntasTop$idText == idPer)
  if(nrow(entidadesPergunta) > 0) {
    #entidades
    totalPerguntaComEntidadeIdentificada <- 1 + totalPerguntaComEntidadeIdentificada
    entidadesIdentificadasPerguntas <- c(entidadesIdentificadasPerguntas, as.character(entidadesPergunta$uri))
    
    tags <- subset(dadosTagBio, dadosTagBio$idPergunta == idPer & gsub("-", " ", tolower(dadosTagBio$nomeTag)) %in% tolower(entidadesPergunta$surface))
    if(nrow(tags) > 0 ) {
    
      contadorPerguntaComTagComumEntidade <- contadorPerguntaComTagComumEntidade + 1
    } else {
      tags <- subset(dadosTagBio, dadosTagBio$idPergunta == idPer)
      print(paste("tags: ",unique(as.character(tags$nomeTag))))
      print(paste("Entidades: ",unique(as.character(entidadesPergunta$surface))))
      print("********")
      contadorPerguntaComTagNaoComumEntidade <- contadorPerguntaComTagNaoComumEntidade + 1
    }
    
    #respostas
    respostasFiltradaPelaPergunta = subset(dadosRespostasTop, dadosRespostasTop$idPergunta == idPer)
    entidadesRespostaComum <- subset(respostasFiltradaPelaPergunta, 
                                     respostasFiltradaPelaPergunta$uri %in% entidadesPergunta$uri)
    
    if(nrow(entidadesRespostaComum) > 0) {
      totalRespostaComEntidadeComumPergunta <- 1 + totalRespostaComEntidadeComumPergunta
    }
    
  }
}


totalPerguntaTop50Respondeu <- length(unique(dadosRespostasTop$idPergunta))

print(paste('Total perguntas que Top 50 respondeu depois de 2012: ', totalPerguntaTop50Respondeu))
print(paste('Total perguntas que Top 50 respondeu depois de 2012 e que foram identificadas entidades: ', totalPerguntaComEntidadeIdentificada))
print(paste('Total de entidades identificadas nas perguntas que Top 50 respondeu depois de 2012: ', length(entidadesIdentificadasPerguntas)))
print(paste('Total de entidades unicas identificadas nas perguntas que Top 50 respondeu depois de 2012: ', length(unique(entidadesIdentificadasPerguntas))))
print(paste('Total perguntas (depois de 2012 que possuem entidade) com pelo menos uma entidade comum a uma tag: ', contadorPerguntaComTagComumEntidade))
print(paste('Total perguntas (depois de 2012 que possuem entidade) com nenhuma entidade comum a uma tag: ', contadorPerguntaComTagNaoComumEntidade))
print(paste('Porcentagem perguntas (depois de 2012 que possuem entidade) com pelo menos uma entidade comum a uma tag: ', ((contadorPerguntaComTagComumEntidade * 100)/(contadorPerguntaComTagComumEntidade + contadorPerguntaComTagNaoComumEntidade))))
print(paste('Porcentagem perguntas (depois de 2012 que possuem entidade) com nenhuma entidade comum a uma tag: ', ((contadorPerguntaComTagNaoComumEntidade * 100)/(contadorPerguntaComTagComumEntidade + contadorPerguntaComTagNaoComumEntidade))))
print(paste('Total de respostas que possuem do Top 50 depois de 2012 que possuem pelo menos uma entidade comum a pergunta', length(entidadesRespostaComum)))

