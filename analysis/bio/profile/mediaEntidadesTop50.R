#entidades dos top 50 (perguntas e respostas)
userEntities = read.csv("C:\\Users\\thiag_000\\Desktop\\experts-semantic-analysis\\analysis\\bio\\profile\\userProfile.csv", header = TRUE, sep = ';')

#media de entidades 
users <- as.character(unique(userEntities$idUsuario))

colunas <- c("NUM_ENTIDADE")
numeroLinhas <- length(users)
numeroColunas <- length(colunas)

tabela <- matrix(nrow=numeroLinhas, ncol=numeroColunas, dimnames=list(users,colunas))

for(i in 1:nrow(userEntities)) {
  row <- userEntities[i,] 
  usuario <- as.character(row$idUsuario)
  if(is.na(tabela[usuario, "NUM_ENTIDADE"])) {
    tabela[usuario, "NUM_ENTIDADE"] <- 0
  }
  tabela[usuario, "NUM_ENTIDADE"] <- 1 + tabela[usuario, "NUM_ENTIDADE"]
}

numeroEntidadeList <- c()
for(usuario in users) {
  numeroEntidadeList <- c(numeroEntidadeList, tabela[usuario, "NUM_ENTIDADE"])
}

print(summary(numeroEntidadeList))
print(sum(numeroEntidadeList))
boxplot(numeroEntidadeList)






