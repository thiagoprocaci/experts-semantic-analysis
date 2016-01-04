dados = read.csv("C:\\Users\\thiag_000\\Desktop\\analises\\participacaoComunidades.csv", header = TRUE, sep = ';')

dadosBio = subset(dados, dados$comunidade == 'BIO')

resumo<- summary(dadosBio$reputacao)

print(resumo)
hist(dadosBio$reputacao, breaks = 50)
boxplot(dadosBio$reputacao)


x <- c(1,2,3)
y <- c(1,2,3,4)
print(wilcox.test(x,y))