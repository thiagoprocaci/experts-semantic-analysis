# Vargha & Delaney's A12
vargha.delaney <- function(r1, r2) {
  m <- length(r1);
  n <- length(r2);
  return ((sum(rank(c(r1, r2))[seq_along(r1)]) / m - (m + 1) / 2) / n);
}


respostasTop50 = read.csv("C:\\Users\\thiag_000\\Desktop\\experts-semantic-analysis\\analysis\\bio\\mediasTop50Respostas.csv", header = TRUE, sep = ';')
respostasQuartis = read.csv("C:\\Users\\thiag_000\\Desktop\\experts-semantic-analysis\\analysis\\bio\\mediasQuartisRespostas.csv", header = TRUE, sep = ';')


wc <- wilcox.test(respostasTop50$media, respostasQuartis$media)
effectSize <- vargha.delaney(respostasTop50$media, respostasQuartis$media)
print(wc)

options(scipen=999)
print(paste("Tamanho de efeito ", effectSize))
print(paste("p-value ", wc$p.value))

print(wc$p.value < 0.05)


print('********************************')

wc <- wilcox.test(respostasQuartis$media, respostasTop50$media)
effectSize <- vargha.delaney(respostasQuartis$media, respostasTop50$media)
print(wc)

options(scipen=999)
print(paste("Tamanho de efeito ", effectSize))
print(paste("p-value ", wc$p.value))

print(wc$p.value < 0.05)