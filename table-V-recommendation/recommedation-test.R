
rootDir <- "data-recommedation"
initialFiles <- dir(rootDir)

entityList <- c()
for (f in initialFiles) {
  filePath <- paste(rootDir,f,sep = "/")
  data <- read.csv(filePath, header=TRUE, sep = ';')
  surface <- unique(as.character(data$entity))
  entityList <- c(entityList, surface)
}

col <- c("USER_REC", "USER_ANSWERED_QUESTION", "PERCENT", "AVG_ANSWERS", "AVG_VOTE_UP", "AVG_VOTE_DOWN")

numLines <- length(entityList)
numCol <- length(col)


tableResult <- matrix(nrow=numLines, ncol=numCol, dimnames=list(entityList,col))


for (f in initialFiles) {
  filePath <- paste(rootDir,f,sep = "/")
  data <- read.csv(filePath, header=TRUE, sep = ';')
  totalRecUser <- as.numeric(unique(data$totalTeoricoRecomendado))
  totalUser <- length(data$usuario)
  entity <- as.character(unique(data$entity))
  numberAnswers <- as.numeric(data$totalResposta)
  voteUp <- as.numeric(data$somaUp)/numberAnswers
  voteDown <- as.numeric(data$somaDown)/numberAnswers
  
  porcentagemAcerto <- (totalUser * 100)/totalRecUser
  
  tableResult[entity, "USER_REC"] <- totalRecUser
  tableResult[entity, "USER_ANSWERED_QUESTION"] <- totalUser
  tableResult[entity, "PERCENT"] <- paste(round(porcentagemAcerto), "%", sep = "")
  tableResult[entity, "AVG_ANSWERS"] <- round(mean(numberAnswers))
  tableResult[entity, "AVG_VOTE_UP"] <- round(mean(voteUp))
  tableResult[entity, "AVG_VOTE_DOWN"] <- format(mean(voteDown),nsmall = 2, digits = 1)
  
}

print(tableResult)

percentList <- as.numeric(gsub("%", "", as.character(tableResult[,"PERCENT"])))
answerList <- as.numeric(tableResult[,"AVG_ANSWERS"])
voteUpList <- as.numeric(tableResult[,"AVG_VOTE_UP"])

print("Summary Percents")
print(summary(percentList))
boxplot(percentList, main = "% correct recommedation", xlab = "Percent")

print("Summary Avg. Answers")
print(summary(answerList))

print("Summary Avg. vote up")
print(summary(voteUpList))

