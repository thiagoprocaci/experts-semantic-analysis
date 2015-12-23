dados = read.csv("C:\\Users\\thiag_000\\Desktop\\analises\\participacaoComunidades.csv", header = TRUE, sep = ';')

dadosBio = subset(dados, dados$comunidade == 'BIO')

resumo<- summary(dadosBio$reputacao)
primeiroQuartil <- resumo[2]
terceiroQuartil <- resumo[5]
dadosBio <- subset(dados, dados$comunidade == 'BIO' & dados$reputacao >= primeiroQuartil & dados$reputacao <= terceiroQuartil)

dadosTa = subset(dados, dados$comunidade == 'TA')
resumo<- summary(dadosTa$reputacao)
primeiroQuartil <- resumo[2]
terceiroQuartil <- resumo[5]
dadosTa <- subset(dados, dados$comunidade == 'TA' & dados$reputacao >= primeiroQuartil & dados$reputacao <= terceiroQuartil)

dadosFis = subset(dados, dados$comunidade == 'FIS')
resumo<- summary(dadosFis$reputacao)
primeiroQuartil <- resumo[2]
terceiroQuartil <- resumo[5]
dadosFis <- subset(dados, dados$comunidade == 'FIS' & dados$reputacao >= primeiroQuartil & dados$reputacao <= terceiroQuartil)

dadosElu = subset(dados, dados$comunidade == 'ELU')
resumo<- summary(dadosElu$reputacao)
primeiroQuartil <- resumo[2]
terceiroQuartil <- resumo[5]
dadosElu <- subset(dados, dados$comunidade == 'ELU' & dados$reputacao >= primeiroQuartil & dados$reputacao <= terceiroQuartil)



colunas <- c("method", "correlation", "p-value", "valido", "descricao")

nomeComunidadeList <- unique(dados$comunidade)
numeroLinhas <- length(nomeComunidadeList)
numeroColunas <- length(colunas)

tabelaSpearman <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(nomeComunidadeList,colunas))
tabelaKendall <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(nomeComunidadeList,colunas))

tabelaSpearman['BIO', "method"] <- "spearman"
tabelaSpearman['BIO', "correlation"] <- cor(dadosBio$reputacao, dadosBio$respostas, method = "spearman")
tabelaSpearman['BIO', "p-value"] <- cor.test(dadosBio$reputacao, dadosBio$respostas, method = "spearman")$p.value

tabelaKendall['BIO', "method"] <- "kendall"
tabelaKendall['BIO', "correlation"] <- cor(dadosBio$reputacao, dadosBio$respostas, method = "kendall")
tabelaKendall['BIO', "p-value"] <- cor.test(dadosBio$reputacao, dadosBio$respostas, method = "kendall")$p.value


tabelaSpearman['TA', "method"] <- "spearman"
tabelaSpearman['TA', "correlation"] <- cor(dadosTa$reputacao, dadosTa$respostas, method = "spearman")
tabelaSpearman['TA', "p-value"] <- cor.test(dadosTa$reputacao, dadosTa$respostas, method = "spearman")$p.value

tabelaKendall['TA', "method"] <- "kendall"
tabelaKendall['TA', "correlation"] <- cor(dadosTa$reputacao, dadosTa$respostas, method = "kendall")
tabelaKendall['TA', "p-value"] <- cor.test(dadosTa$reputacao, dadosTa$respostas, method = "kendall")$p.value


tabelaSpearman['FIS', "method"] <- "spearman"
tabelaSpearman['FIS', "correlation"] <- cor(dadosFis$reputacao, dadosFis$respostas, method = "spearman")
tabelaSpearman['FIS', "p-value"] <- cor.test(dadosFis$reputacao, dadosFis$respostas, method = "spearman")$p.value

tabelaKendall['FIS', "method"] <- "kendall"
tabelaKendall['FIS', "correlation"] <- cor(dadosFis$reputacao, dadosFis$respostas, method = "kendall")
tabelaKendall['FIS', "p-value"] <- cor.test(dadosFis$reputacao, dadosFis$respostas, method = "kendall")$p.value

tabelaSpearman['ELU', "method"] <- "spearman"
tabelaSpearman['ELU', "correlation"] <- cor(dadosElu$reputacao, dadosElu$respostas, method = "spearman")
tabelaSpearman['ELU', "p-value"] <- cor.test(dadosElu$reputacao, dadosElu$respostas, method = "spearman")$p.value

tabelaKendall['ELU', "method"] <- "kendall"
tabelaKendall['ELU', "correlation"] <- cor(dadosElu$reputacao, dadosElu$respostas, method = "kendall")
tabelaKendall['ELU', "p-value"] <- cor.test(dadosElu$reputacao, dadosElu$respostas, method = "kendall")$p.value

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


print('Correlacao  50 - Reputacao X Respostas')
print(tabelaSpearman)
print(tabelaKendall)

