# Vargha & Delaney's A12
vargha.delaney <- function(r1, r2) {
  m <- length(r1);
  n <- length(r2);
  return ((sum(rank(c(r1, r2))[seq_along(r1)]) / m - (m + 1) / 2) / n);
}


rootDir <- "data"
initialFiles <- dir(rootDir)

entityList <- c()
for (f in initialFiles) {
  filePath <- paste(rootDir,f,sep = "/")
  data <- read.csv(filePath, header=TRUE, sep = ';')
  surface <- unique(as.character(data$surface))
  entityList <- c(entityList, surface)
}


col <- c("VOTE_UP_MEAN", "VOTE_DOWN_MEAN", "PV", "EFFECT_SIZE", "NUMBER_USER")

numLines <- length(entityList)
numCol <- length(col)


tableResult <- matrix(nrow=numLines, ncol=numCol, dimnames=list(entityList,col))

for (f in initialFiles) {
  filePath <- paste(rootDir,f,sep = "/")
  data <- read.csv(filePath, header=TRUE, sep = ';')
  surface <- unique(as.character(data$surface))
  voteUpList <- as.numeric(data$votosPositivos)
  voteDownList <- as.numeric(data$votosNegativos)
  users <- unique(as.character(data$idUsuario))
  
  tableResult[surface, "NUMBER_USER"] <- length(users)
  tableResult[surface, "VOTE_UP_MEAN"] <- paste(format(mean(voteUpList), nsmall = 4, digits = 4), sep = "+-", format(round(sd(voteUpList), digits = 2), nsmall = 2))
  tableResult[surface, "VOTE_DOWN_MEAN"] <- paste(format(mean(voteDownList), nsmall = 4, digits = 4), sep = "+-", format(round(sd(voteDownList), digits = 2), nsmall = 2))
  tableResult[surface, "EFFECT_SIZE"] <- paste(round(vargha.delaney(voteUpList,voteDownList) * 100), sep = "", "%")
  pv <- wilcox.test(voteUpList,voteDownList)$p.value
  
  if(is.nan(pv)) { #as vezes da NaN!
    tableResult[surface, "PV"]  <- '-'
    next
  }
  if(pv < 0.001) {
    tableResult[surface, "PV"]  <- '< 0,001'
    next
  } 
  tableResult[surface, "PV"]  <- as.character(format(round(pv, digits = 4), nsmall = 4))
  
}

print(tableResult)
#write.table(tableResult, file="profileEval2.csv", sep=";")

config_original = par(no.readonly = TRUE)
par(mfrow = c(4,3), pty = "s", mar = c(2, 2, 2, 2))

for (f in initialFiles) {
  filePath <- paste(rootDir,f,sep = "/")
  data <- read.csv(filePath, header=TRUE, sep = ';')
  surface <- unique(as.character(data$surface))
  voteUpList <- as.numeric(data$votosPositivos)
  voteDownList <- as.numeric(data$votosNegativos)
  
  boxplot(voteUpList, voteDownList, names = c("vote up", "vote down"), main  = surface, ylab = "Evaluations")
}
par(config_original)

