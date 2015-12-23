
dados = read.csv("C:\\Users\\thiag_000\\Desktop\\analises\\participacaoComunidades.csv", header = TRUE, sep = ';')

dadosBio = subset(dados, dados$comunidade == 'BIO')
dadosTa = subset(dados, dados$comunidade == 'TA')
dadosFis = subset(dados, dados$comunidade == 'FIS')
dadosElu = subset(dados, dados$comunidade == 'ELU')


dadosBioTop <- head(dadosBio, 50)
dadosTaTop <- head(dadosTa, 50)
dadosFisTop <- head(dadosFis, 50)
dadosEluTop <- head(dadosElu, 50)

colunas <- c("method", "correlation", "p-value", "valido", "descricao")

nomeComunidadeList <- unique(dados$comunidade)
numeroLinhas <- length(nomeComunidadeList)
numeroColunas <- length(colunas)


tabelaSpearman <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(nomeComunidadeList,colunas))
tabelaKendall <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(nomeComunidadeList,colunas))

tabelaSpearman['BIO', "method"] <- "spearman"
tabelaSpearman['BIO', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$comentariospergunta, method = "spearman")
tabelaSpearman['BIO', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$comentariospergunta, method = "spearman")$p.value

tabelaKendall['BIO', "method"] <- "kendall"
tabelaKendall['BIO', "correlation"] <- cor(dadosBioTop$reputacao, dadosBioTop$comentariospergunta, method = "kendall")
tabelaKendall['BIO', "p-value"] <- cor.test(dadosBioTop$reputacao, dadosBioTop$comentariospergunta, method = "kendall")$p.value


tabelaSpearman['TA', "method"] <- "spearman"
tabelaSpearman['TA', "correlation"] <- cor(dadosTaTop$reputacao, dadosTaTop$comentariospergunta, method = "spearman")
tabelaSpearman['TA', "p-value"] <- cor.test(dadosTaTop$reputacao, dadosTaTop$comentariospergunta, method = "spearman")$p.value

tabelaKendall['TA', "method"] <- "kendall"
tabelaKendall['TA', "correlation"] <- cor(dadosTaTop$reputacao, dadosTaTop$comentariospergunta, method = "kendall")
tabelaKendall['TA', "p-value"] <- cor.test(dadosTaTop$reputacao, dadosTaTop$comentariospergunta, method = "kendall")$p.value


tabelaSpearman['FIS', "method"] <- "spearman"
tabelaSpearman['FIS', "correlation"] <- cor(dadosFisTop$reputacao, dadosFisTop$comentariospergunta, method = "spearman")
tabelaSpearman['FIS', "p-value"] <- cor.test(dadosFisTop$reputacao, dadosFisTop$comentariospergunta, method = "spearman")$p.value

tabelaKendall['FIS', "method"] <- "kendall"
tabelaKendall['FIS', "correlation"] <- cor(dadosFisTop$reputacao, dadosFisTop$comentariospergunta, method = "kendall")
tabelaKendall['FIS', "p-value"] <- cor.test(dadosFisTop$reputacao, dadosFisTop$comentariospergunta, method = "kendall")$p.value

tabelaSpearman['ELU', "method"] <- "spearman"
tabelaSpearman['ELU', "correlation"] <- cor(dadosEluTop$reputacao, dadosEluTop$comentariospergunta, method = "spearman")
tabelaSpearman['ELU', "p-value"] <- cor.test(dadosEluTop$reputacao, dadosEluTop$comentariospergunta, method = "spearman")$p.value

tabelaKendall['ELU', "method"] <- "kendall"
tabelaKendall['ELU', "correlation"] <- cor(dadosEluTop$reputacao, dadosEluTop$comentariospergunta, method = "kendall")
tabelaKendall['ELU', "p-value"] <- cor.test(dadosEluTop$reputacao, dadosEluTop$comentariospergunta, method = "kendall")$p.value

for(comunidade in nomeComunidadeList) {
  if(as.numeric(tabelaSpearman[comunidade, 'p-value']) < 0.05) {
    tabelaSpearman[comunidade, 'valido'] <- 'Sim' 
  } else {
    tabelaSpearman[comunidade, 'valido'] <- 'Nao' 
  }
  
  if(as.numeric(tabelaKendall[comunidade, 'p-value']) < 0.05) {
    tabelaKendall[comunidade, 'valido'] <- 'Sim' 
  } else {
    tabelaKendall[comunidade, 'valido'] <- 'Nao' 
  }
  correlacao <- as.numeric(tabelaSpearman[comunidade, 'correlation'])
  tabelaSpearman[comunidade, 'descricao'] <- 'moderada'
  if(correlacao > 0.7){
    tabelaSpearman[comunidade, 'descricao'] <- 'forte'
  } 
  if(correlacao < 0.3){
    tabelaSpearman[comunidade, 'descricao'] <- 'fraca'
  }
  correlacao <- as.numeric(tabelaKendall[comunidade, 'correlation'])
  tabelaKendall[comunidade, 'descricao'] <- 'moderada'
  if(correlacao > 0.7){
    tabelaKendall[comunidade, 'descricao'] <- 'forte'
  } 
  if(correlacao < 0.3){
    tabelaKendall[comunidade, 'descricao'] <- 'fraca'
  }
  
}


print('Correlacao Top 50 - Reputacao X Comentarios Pergunta')
print(tabelaSpearman)
print(tabelaKendall)


options(scipen=999)
write.table(tabelaSpearman, file = "correlacaoTop50ComentariosPerguntasReputacaoSpearman", sep = ";")
write.table(tabelaKendall, file = "correlacaoTop50ComentariosPerguntasReputacaoKendall", sep = ";")





