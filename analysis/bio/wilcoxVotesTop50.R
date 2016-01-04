# Vargha & Delaney's A12
vargha.delaney <- function(r1, r2) {
  m <- length(r1);
  n <- length(r2);
  return ((sum(rank(c(r1, r2))[seq_along(r1)]) / m - (m + 1) / 2) / n);
}


voteupTop50 = read.csv("C:\\Users\\thiag_000\\Desktop\\experts-semantic-analysis\\analysis\\bio\\mediasTop50VoteUp.csv", header = TRUE, sep = ';')
votedownTop50 = read.csv("C:\\Users\\thiag_000\\Desktop\\experts-semantic-analysis\\analysis\\bio\\mediasTop50VoteDown.csv", header = TRUE, sep = ';')


wc <- wilcox.test(voteupTop50$media, votedownTop50$media)
effectSize <- vargha.delaney(voteupTop50$media, votedownTop50$media)
print(wc)

options(scipen=999)
print(paste("Tamanho de efeito ", effectSize))
print(paste("p-value ", wc$p.value))

print(wc$p.value < 0.05)


print('********************************')

wc <- wilcox.test(votedownTop50$media, voteupTop50$media)
effectSize <- vargha.delaney(votedownTop50$media, voteupTop50$media)
print(wc)

options(scipen=999)
print(paste("Tamanho de efeito ", effectSize))
print(paste("p-value ", wc$p.value))

print(wc$p.value < 0.05)