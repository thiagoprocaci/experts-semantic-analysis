
dados = read.csv("correlation.csv", header = TRUE, sep = ';')

dadosBio = subset(dados, dados$comunidade == 'BIO')



dadosBioTop <- head(dadosBio, 50)


colunas <- c("method", "correlation", "p-value", "valid", "desc")

nomeComunidadeList <- c("QUESTIONS", "ANSWERS", "COMMENTS_ON_QUESTION", "COMMENTS_ON_ANSWERS")
numeroLinhas <- length(nomeComunidadeList)
numeroColunas <- length(colunas)


tabelaSpearman <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(nomeComunidadeList,colunas))
tabelaKendall <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(nomeComunidadeList,colunas))

# questions
tabelaSpearman['QUESTIONS', "method"] <- "spearman"
tabelaSpearman['QUESTIONS', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$perguntas, method = "spearman")
tabelaSpearman['QUESTIONS', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$perguntas, method = "spearman")$p.value

tabelaKendall['QUESTIONS', "method"] <- "kendall"
tabelaKendall['QUESTIONS', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$perguntas, method = "kendall")
tabelaKendall['QUESTIONS', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$perguntas, method = "kendall")$p.value

# answers
tabelaSpearman['ANSWERS', "method"] <- "spearman"
tabelaSpearman['ANSWERS', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$respostas, method = "spearman")
tabelaSpearman['ANSWERS', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$respostas, method = "spearman")$p.value

tabelaKendall['ANSWERS', "method"] <- "kendall"
tabelaKendall['ANSWERS', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$respostas, method = "kendall")
tabelaKendall['ANSWERS', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$respostas, method = "kendall")$p.value


# comments on question
tabelaSpearman['COMMENTS_ON_QUESTION', "method"] <- "spearman"
tabelaSpearman['COMMENTS_ON_QUESTION', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$comentariospergunta, method = "spearman")
tabelaSpearman['COMMENTS_ON_QUESTION', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$comentariospergunta, method = "spearman")$p.value

tabelaKendall['COMMENTS_ON_QUESTION', "method"] <- "kendall"
tabelaKendall['COMMENTS_ON_QUESTION', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$comentariospergunta, method = "kendall")
tabelaKendall['COMMENTS_ON_QUESTION', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$comentariospergunta, method = "kendall")$p.value


# comments on answers
tabelaSpearman['COMMENTS_ON_ANSWERS', "method"] <- "spearman"
tabelaSpearman['COMMENTS_ON_ANSWERS', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$comentariosresposta, method = "spearman")
tabelaSpearman['COMMENTS_ON_ANSWERS', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$comentariosresposta, method = "spearman")$p.value

tabelaKendall['COMMENTS_ON_ANSWERS', "method"] <- "kendall"
tabelaKendall['COMMENTS_ON_ANSWERS', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$comentariosresposta, method = "kendall")
tabelaKendall['COMMENTS_ON_ANSWERS', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$comentariosresposta, method = "kendall")$p.value


for(comunidade in nomeComunidadeList) {
  if(as.numeric(tabelaSpearman[comunidade, 'p-value']) < 0.05) {
    tabelaSpearman[comunidade, 'valid'] <- 'Yes' 
  } else {
    tabelaSpearman[comunidade, 'valid'] <- 'No' 
  }
  
  if(as.numeric(tabelaKendall[comunidade, 'p-value']) < 0.05) {
    tabelaKendall[comunidade, 'valid'] <- 'Yes' 
  } else {
    tabelaKendall[comunidade, 'valid'] <- 'No' 
  }
  correlacao <- as.numeric(tabelaSpearman[comunidade, 'correlation'])
  tabelaSpearman[comunidade, 'desc'] <- 'moderate'
  if(correlacao > 0.7){
    tabelaSpearman[comunidade, 'desc'] <- 'strong'
  } 
  if(correlacao < 0.3){
    tabelaSpearman[comunidade, 'desc'] <- 'weak'
  }
  correlacao <- as.numeric(tabelaKendall[comunidade, 'correlation'])
  tabelaKendall[comunidade, 'desc'] <- 'moderate'
  if(correlacao > 0.7){
    tabelaKendall[comunidade, 'desc'] <- 'strong'
  } 
  if(correlacao < 0.3){
    tabelaKendall[comunidade, 'desc'] <- 'weak'
  }
  
}


print('TABLE II. SPEARMAN  TOP 50  - REPUTATION X ATTRIBUTES')
print(tabelaSpearman)
cat('\n\n')
print('TABLE III. KENDALL TOP 50 - REPUTATION X ATTRIBUTES')
print(tabelaKendall)







