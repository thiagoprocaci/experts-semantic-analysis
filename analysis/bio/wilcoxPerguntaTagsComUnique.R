# Vargha & Delaney's A12
vargha.delaney <- function(r1, r2) {
  m <- length(r1);
  n <- length(r2);
  return ((sum(rank(c(r1, r2))[seq_along(r1)]) / m - (m + 1) / 2) / n);
}


dados = read.csv("C:\\Users\\thiag_000\\Desktop\\experts-semantic-analysis\\analysis\\bio\\entidadeTags.csv", header = TRUE, sep = ';')
dadosComEntidade <- subset(dados, dados$QUANT_ENTIDADE > 0)
dadosSemEntidade <- subset(dados, dados$QUANT_ENTIDADE == 0)
dadosComEntidadeIgualUmaTag <- subset(dadosComEntidade, dadosComEntidade$QUANT_ENTIDADE_COMUM_TAG > 0 )
dadosSemEntidadeIgualUmaTag <- subset(dadosComEntidade, dadosComEntidade$QUANT_ENTIDADE_COMUM_TAG == 0 )

total <- nrow(dados)
totalComEntidade <- nrow(dadosComEntidade)
totalSemEntidade <- nrow(dadosSemEntidade)
totalComEntidadeIgualTag <- nrow(dadosComEntidadeIgualUmaTag)
totalSemEntidadeIgualUmaTag <- nrow(dadosSemEntidadeIgualUmaTag)

print(paste("Total perguntas", total))
print(paste("Total com entidades", totalComEntidade))
print(paste("Total sem entidades", totalSemEntidade))
print(paste("Total com entidades igual a pelo menos uma tag:", totalComEntidadeIgualTag))
print(paste("Total com nenhuma entidade igual a pelo menos uma tag:", totalSemEntidadeIgualUmaTag))




#wc <- wilcox.test(dadosComEntidade$ENTIDADE_TAG, dadosComEntidade$TAG)
#effectSize <- vargha.delaney(dadosComEntidade$ENTIDADE_TAG, dadosComEntidade$TAG)
#print(wc)

#options(scipen=999)
#print(paste("Tamanho de efeito ", effectSize))
#print(paste("p-value ", wc$p.value))

#print(wc$p.value < 0.05)


#print('********************************')

#wc <- wilcox.test(dadosComEntidade$TAG, dadosComEntidade$ENTIDADE_TAG)
#effectSize <- vargha.delaney(dadosComEntidade$TAG, dadosComEntidade$ENTIDADE_TAG)
#print(wc)

#options(scipen=999)
#print(paste("Tamanho de efeito ", effectSize))
#print(paste("p-value ", wc$p.value))

#print(wc$p.value < 0.05)


#print('********************************')


