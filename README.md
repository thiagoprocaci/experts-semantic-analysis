# Project experts-semantic-analysis
## Summary
This project is part of a scientific research. We are interested in knowing how to find experts in online community.
You can find here the analysis of the paper "Finding Topical Experts based on Reputation and Semantic Annotations 
in Question & Answer Communities" published at "xxxx".
In other words, you will find everything you need to reproduce this research.


## Setup the environment
- Install R version 3.1.1 (available at https://www.r-project.org/)
- Install mySQL database version 5.6.21 (available at http://dev.mysql.com/downloads/)

## Loading data into MySQL
- Download the scripts from https://github.com/thiagoprocaci/qarepo
- Run createDatabase.sql
- Run the scripts from BiologiaInsert.zip

## Comments about the database tables
The names of the table were written in Portuguese. 
We translated the names in order to help you to understand.

Table name         | Translation (english)
------------------ | ------------------
usuario            | user
pergunta           | question
resposta           | answer
comentariopergunta | comments on question
comentarioresposta | comments on answer
forum              | forum
anotacoes          | annotations
entidades          | entities
tag                | tag
perguntatag        | question tag

We also translated some important table fields:

Field name         | Translation (english)
------------------ | ------------------
id                 | id
reputacao          | reputation
nome               | name
titulo             | title
texto              | text
usuarioID          | user id
forumID            | forum id
perguntaID         | question id
respostaID         | answer id
tagID              | tag id
dataCriacao        | creation date
votosPositivos     | number of votes up
votosNegativos     | number of votes down
numeroVisualizacao | number of visualizations
tipo               | type
titulo_pergunta    | Question title
texto_pergunta     | Question text
texto_resposta     | Answer text
comentario_pergunta| Comment on question text
comentario_resposta| Comment on answer text



## Analysis
To build each analysis, follow the instructions:
### TABLE I. 	OVERVIEW OF THE BQA REPUTATION SCORE 
- Go to folder table-I-reputation
- Run reputation.sql
- Export sql data to csv file (like reputation.csv)
- Run table-1-reputation.R
- The results should look like:

Min. | 1st Qu. |  Median | Mean | 3rd Qu. |  Max. 
-----|---------|---------|------|---------|-------
1.0  |  17.0   |  101.0  | 193.5|   136.0 |16660.0 

### TABLE II and III. 	Correlation (Spearman and Kendall)
- Go to folder table-II-III-correlation
- Run correlation.sql
- Export sql data to csv file (like correlation.csv)
- Run correlation.R
- The resulys should look like:

attribute            |method     |correlation         |p-value                       |valid |desc      
---------------------|-----------|--------------------|------------------------------|------|-------
QUESTIONS            |"spearman" |"0.190391450769118" |"0.185379772049513"           |"No"  |"weak"    
ANSWERS              |"spearman" |"0.765476070024332" |"0.0000000000951391018063494" |"Yes" |"strong"  
COMMENTS_ON_QUESTION |"spearman" |"0.607756034714175" |"0.00000285881187179338"      |"Yes" |"moderate"
COMMENTS_ON_ANSWERS  |"spearman" |"0.717891463777467" |"0.00000000441627523848938"   |"Yes" |"strong"  


                     
attribute            |method     |correlation         |p-value                       |valid |desc      					 
---------------------|-----------|--------------------|------------------------------|------|-------
QUESTIONS            |"kendall"  |"0.136604275184825" |"0.172782763180915"           |"No"  |"weak"    
ANSWERS              |"kendall"  |"0.577659514570134" |"0.00000000399321886668247"   |"Yes" |"moderate"
COMMENTS_ON_QUESTION |"kendall"  |"0.431902165608286" |"0.00000998873197555206"      |"Yes" |"moderate"
COMMENTS_ON_ANSWERS  |"kendall"  |"0.521100053348757" |"0.00000010271813755125"      |"Yes" |"moderate"
