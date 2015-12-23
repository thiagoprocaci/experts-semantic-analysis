dados = read.csv("C:\\Users\\thiag_000\\Desktop\\analises\\participacaoComunidades.csv", header = TRUE, sep = ';')

dadosBio = subset(dados, dados$comunidade == 'BIO')
dadosTa = subset(dados, dados$comunidade == 'TA')
dadosFis = subset(dados, dados$comunidade == 'FIS')
dadosElu = subset(dados, dados$comunidade == 'ELU')


dadosBioTop <- head(dadosBio, 50)
dadosTaTop <- head(dadosTa, 50)
dadosFisTop <- head(dadosFis, 50)
dadosEluTop <- head(dadosElu, 50)


xrange <- range(dadosBioTop$reputacao, dadosTaTop$reputacao, dadosFisTop$reputacao, dadosEluTop$reputacao)
yrange <- range(dadosBioTop$respostas, dadosTaTop$respostas, dadosFisTop$respostas, dadosEluTop$respostas)

plot(xrange, yrange, type="n", xlab="Reputation", ylab="Answers")
title("Reputation X Answers")


points(dadosTaTop$reputacao, dadosTaTop$respostas,  col="red", pch=17)
points(dadosFisTop$reputacao, dadosFisTop$respostas,  col="green", pch=18)
points(dadosEluTop$reputacao, dadosEluTop$respostas,  col="black", pch=20)
points(dadosBioTop$reputacao, dadosBioTop$respostas,  col="darkblue", pch=23)



