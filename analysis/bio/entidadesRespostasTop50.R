dadosParticipacaoGeral = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\participacaoComunidades.csv", header = TRUE, sep = ';')
dadosEntidades = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\anotacoesBio.csv", header = TRUE, sep = ';')
dadosRespostas = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\respostasComunidades.csv", header = TRUE, sep = ';')
dadosTag = read.csv("C:\\Users\\thiag_000\\Desktop\\analises2\\tags.csv", header = TRUE, sep = ';')

dadosTagBio <- subset(dadosTag, dadosTag$comunidade == 'BIO')

dadosComunidade <- subset(dadosParticipacaoGeral, dadosParticipacaoGeral$comunidade == 'BIO')
dadosComunidadeTop <- head(dadosComunidade, 50)

excludeEntities <- c('.pdf', 'strong', 'html', 'Nice', 'link', '.com', 'http', 'book', 'click', '.org', 'Wikipedia', 'en.wikipedia.org', 'wiki page')

dadosEntidadesRespostasTop <- subset(dadosEntidades, dadosEntidades$tipo == 'texto_resposta' & 
                                       !(dadosEntidades$surface %in% excludeEntities)
                            & dadosEntidades$idUsuario %in% dadosComunidadeTop$idUsuario)

dadosEntidadesPerguntasTop <- subset(dadosEntidades, 
                                     (dadosEntidades$tipo == 'texto_pergunta' | dadosEntidades$tipo == 'titulo_pergunta')  & 
                                       !(dadosEntidades$surface %in% excludeEntities)
                                     & dadosEntidades$idUsuario %in% dadosComunidadeTop$idUsuario)

dadosRespostasTop <- subset(dadosRespostas, dadosRespostas$anoCriacao >= 2012 & dadosRespostas$idUsuario %in% dadosComunidadeTop$idUsuario)

quantEntidadePergunta <- c()
quantEntidadeRespostaComum <- c()
tagsEntidades <- c()

count <- 1
sim <- 0
nao <- 0

#para cada resposta fornecida pelos top 50 depois de 2012
for(i in 1:nrow(dadosRespostasTop)) {
  row <- dadosRespostasTop[i,] 
  idResposta <- as.character(row$id)
  idPergunta <- as.character(row$idPergunta)
  
  # entidades da pergunta extraidas das perguntas
  entidadesPergunta <- subset(dadosEntidadesPerguntasTop, dadosEntidadesPerguntasTop$idText == idPergunta)
  if(nrow(entidadesPergunta) > 0) {
    
    entidadesRespostaComum <- subset(dadosEntidadesRespostasTop, dadosEntidadesRespostasTop$idText == idResposta & 
                                  dadosEntidadesRespostasTop$uri %in% entidadesPergunta$uri)
    uniqueEntidadesPergunta <- unique(entidadesPergunta$uri)
    uniqueEntidadesResposta <- unique(entidadesRespostaComum$uri)
    
   
    tags <- subset(dadosTagBio, dadosTagBio$idPergunta == idPergunta & tolower(dadosTagBio$nomeTag) %in% tolower(entidadesPergunta$surface))
    #print(entidadesPergunta)
    
    if(nrow(tags) > 0 ) {
      tagsEntidades <- c(tagsEntidades, '1')
      sim <- sim + 1
    } else {
      tagsEntidades <- c(tagsEntidades, '0')
      nao <- nao + 1
    }
     
    quantEntidadePergunta <- c(quantEntidadePergunta, length(uniqueEntidadesPergunta))
    quantEntidadeRespostaComum <- c(quantEntidadeRespostaComum, length(uniqueEntidadesResposta))
    
  }
  
}

print(summary(quantEntidadePergunta))
print(summary(quantEntidadeRespostaComum))
boxplot(quantEntidadePergunta, quantEntidadeRespostaComum)


hist(as.numeric(tagsEntidades))

total <- length(tagsEntidades)
print('Sim')
print(sim)
print((sim * 100)/total)


print('Nao')
print(nao)
print((nao * 100)/total)

print('Total Analisado')
print(total)

print('Total')
print(length(unique(dadosRespostasTop$idPergunta)))

