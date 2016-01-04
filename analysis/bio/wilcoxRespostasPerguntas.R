# Vargha & Delaney's A12
vargha.delaney <- function(r1, r2) {
  m <- length(r1);
  n <- length(r2);
  return ((sum(rank(c(r1, r2))[seq_along(r1)]) / m - (m + 1) / 2) / n);
}


respostasTop50 = read.csv("C:\\Users\\thiag_000\\Desktop\\experts-semantic-analysis\\analysis\\bio\\mediasTop50Respostas.csv", header = TRUE, sep = ';')
perguntasTop50 = read.csv("C:\\Users\\thiag_000\\Desktop\\experts-semantic-analysis\\analysis\\bio\\mediasTop50Perguntas.csv", header = TRUE, sep = ';')


wc <- wilcox.test(respostasTop50$media, perguntasTop50$media)
effectSize <- vargha.delaney(respostasTop50$media, perguntasTop50$media)
print(wc)

options(scipen=999)
print(paste("Tamanho de efeito ", effectSize))
print(paste("p-value ", wc$p.value))

print(wc$p.value < 0.05)


print('********************************')

wc <- wilcox.test(perguntasTop50$media, respostasTop50$media)
effectSize <- vargha.delaney(perguntasTop50$media, respostasTop50$media)
print(wc)

options(scipen=999)
print(paste("Tamanho de efeito ", effectSize))
print(paste("p-value ", wc$p.value))

print(wc$p.value < 0.05)