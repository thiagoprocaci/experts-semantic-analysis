# Vargha & Delaney's A12
vargha.delaney <- function(r1, r2) {
  m <- length(r1);
  n <- length(r2);
  return ((sum(rank(c(r1, r2))[seq_along(r1)]) / m - (m + 1) / 2) / n);
}

rootDir <- "data-recommedation"
initialFiles <- dir(rootDir)

discart <- FALSE

entityList <- c()
for (f in initialFiles) {
  filePath <- paste(rootDir,f,sep = "/")
  data <- read.csv(filePath, header=TRUE, sep = ';')
  totalRecUser <- as.numeric(unique(data$totalTeoricoRecomendado))
  if(discart & totalRecUser < 20) {
    next
  }
  surface <- unique(as.character(data$entity))
  entityList <- c(entityList, surface)
}

col <- c("USER_REC", "USER_ANSWERED_QUESTION", "PERCENT", "AVG_ANSWERS", "AVG_VOTE_UP", "AVG_VOTE_DOWN", "PV", "EFFECT_SIZE")

numLines <- length(entityList)
numCol <- length(col)


tableResult <- matrix(nrow=numLines, ncol=numCol, dimnames=list(entityList,col))

answerList <- c()
voteUpList <- c()
voteDownList <- c()
for (f in initialFiles) {
  filePath <- paste(rootDir,f,sep = "/")
  data <- read.csv(filePath, header=TRUE, sep = ';')
  totalRecUser <- as.numeric(unique(data$totalTeoricoRecomendado))
  if(discart & totalRecUser < 20) {
    next
  }
  totalUser <- length(data$usuario)
  entity <- as.character(unique(data$entity))
  numberAnswers <- as.numeric(data$totalResposta)
  voteUp <- as.numeric(data$somaUp)/numberAnswers
  voteDown <- as.numeric(data$somaDown)/numberAnswers
  
  porcentagemAcerto <- (totalUser * 100)/totalRecUser
  
  tableResult[entity, "USER_REC"] <- totalRecUser
  tableResult[entity, "USER_ANSWERED_QUESTION"] <- totalUser
  tableResult[entity, "PERCENT"] <- paste(round(porcentagemAcerto), "%", sep = "")
  tableResult[entity, "AVG_ANSWERS"] <- paste(round(mean(numberAnswers)), "+-", format(sd(numberAnswers),nsmall = 2, digits = 1), sep = "")
  tableResult[entity, "AVG_VOTE_UP"] <- paste(round(mean(voteUp)), "+-", format(sd(voteUp),nsmall = 2, digits = 1), sep = "")
  tableResult[entity, "AVG_VOTE_DOWN"] <- paste(format(mean(voteDown),nsmall = 2, digits = 1), "+-", format(sd(voteDown),nsmall = 2, digits = 1), sep = "")
  answerList <- c(answerList, mean(numberAnswers))
  voteUpList <- c(voteUpList, mean(voteUp))
  voteDownList <- c(voteDownList, mean(voteDown))
  
  tableResult[entity, "EFFECT_SIZE"] <- paste(round(vargha.delaney(voteUp,voteDown) * 100), sep = "", "%")
  pv <- wilcox.test(voteUp,voteDown)$p.value
  
  if(is.nan(pv)) { #as vezes da NaN!
    tableResult[entity, "PV"]  <- '-'
    next
  }
  if(pv < 0.001) {
    tableResult[entity, "PV"]  <- '< 0,001'
    next
  } 
  tableResult[entity, "PV"]  <- as.character(format(round(pv, digits = 4), nsmall = 4))
}

print(tableResult)
#write.table(tableResult, file = "tableresult") 

percentList <- as.numeric(gsub("%", "", as.character(tableResult[,"PERCENT"])))


print("Summary Percents")
print(summary(percentList))
boxplot(percentList, main = "% correct recommedation", xlab = "Percent")

print("Summary Avg. Answers")
print(summary(answerList))

print("Summary Avg. vote up")
print(summary(voteUpList))

print("Summary Avg. vote down")
print(summary(voteDownList))

