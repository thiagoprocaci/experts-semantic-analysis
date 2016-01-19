rootDir <- "data"
initialFiles <- dir(rootDir)

sqlTemplate <-" select (select '#CONCEITO#' from dual) as entity, (select '#REF_RECOM#' from dual) as totalTeoricoRecomendado, r.usuarioID as usuario, count(*) as totalResposta, sum(r.votosPositivos) as somaUp, sum(r.votosNegativos) as somaDown from resposta r where r.perguntaID in ( 	 	select p.id from pergunta p  		inner join anotacoes a on p.id = a.id_text 		inner join entidades e on e.id = a.id_entidade 	where  (a.tipo = 'titulo_pergunta' or a.tipo = 'texto_pergunta') 		and lower(e.surface) = lower('#CONCEITO#') 		and p.id like '1_%' 	 	)  and r.usuarioID in ( 		#USER# 	 	) group by r.usuarioID order by 2 desc"
for (f in initialFiles) {
  filePath <- paste(rootDir,f,sep = "/")
  data <- read.csv(filePath, header=TRUE, sep = ';')
  surface <- tolower(unique(as.character(data$surface)))
  userList <- unique(as.character(data$idUsuario))
  if(length(userList) < 20) {
    next
  }
  u <- ""
  index <- 1
  for(user in userList) {
    u <- paste(u, "'", user, "'", sep = "")
    if(index < length(userList)) {
      u <- paste(u, ",", sep = "")
    }
    index <- index + 1
  }
  sql <- gsub("#USER#", u, sqlTemplate)
  sql <- gsub("#CONCEITO#", surface, sql)
  sql <- gsub('#REF_RECOM#', as.character(length(userList)), sql)
  cat(sql, file = paste("sql-recommendation\\",surface, '.sql', sep = ""))
}

