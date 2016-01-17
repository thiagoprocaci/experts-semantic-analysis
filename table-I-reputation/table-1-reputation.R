data <- read.csv(file = "reputation.csv", header = TRUE, sep = ";")

reputationList <- as.numeric(data$reputacao)

print("TABLE I. OVERVIEW OF THE BQA REPUTATION SCORE ")
print(summary(reputationList))