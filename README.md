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
The names of the tables were written in Portuguese. 
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
- The results should look like:

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

### TABLE IV. 	User Recommendation - strategy
- Go to folder table-IV-recommendation
- Execute all sqls in folder sqls
- Export sql data to csv data file (like the CSVs in the folder data)
- Run table-IV.R
- The results should look like:

entity              |VOTE_UP_MEAN   |VOTE_DOWN_MEAN  |PV        |EFFECT_SIZE |NUMBER_USER
--------------------|---------------|----------------|----------|------------|-------------
aerobic respiration |"5.7714+-4.70" |"0.08571+-0.28" |"< 0,001" |"97%"       |"14"       
amphibians          |"2.1333+-1.68" |"0.1333+-0.35"  |"< 0,001" |"93%"       |"6"        
bacteria            |"4.6567+-4.34" |"0.0469+-0.21"  |"< 0,001" |"98%"       |"46"       
blood               |"3.0909+-2.07" |"0.0000+-0.00"  |"< 0,001" |"93%"       |"12"       
brain               |"4.2732+-3.49" |"0.1183+-0.41"  |"< 0,001" |"98%"       |"37"       
cancer              |"3.8389+-3.33" |"0.02778+-0.22" |"< 0,001" |"97%"       |"26"       
chromosomes         |"4.2553+-3.68" |"0.1081+-0.31"  |"< 0,001" |"96%"       |"38"       
DNA                 |"4.7837+-4.83" |"0.04171+-0.23" |"< 0,001" |"98%"       |"46"       
enzymes             |"4.6010+-4.86" |"0.0146+-0.12"  |"< 0,001" |"98%"       |"38"       
evolutionary        |"5.3216+-4.83" |"0.0924+-0.36"  |"< 0,001" |"97%"       |"47"       
gene                |"3.9551+-3.28" |"0.04289+-0.26" |"< 0,001" |"97%"       |"46"       
genetic code        |"6.0120+-6.97" |"0.04217+-0.20" |"< 0,001" |"99%"       |"25"       
genomes             |"4.1137+-3.15" |"0.04046+-0.24" |"< 0,001" |"98%"       |"45"       
hormones            |"4.9606+-4.70" |"0.1102+-0.65"  |"< 0,001" |"95%"       |"26"       
humans              |"4.8293+-4.60" |"0.08302+-0.37" |"< 0,001" |"97%"       |"50"       
muscle              |"3.2138+-2.98" |"0.06207+-0.24" |"< 0,001" |"96%"       |"23"       
organisms           |"4.9665+-5.12" |"0.09152+-0.33" |"< 0,001" |"97%"       |"45"       
plants              |"5.7218+-8.35" |"0.06031+-0.37" |"< 0,001" |"98%"       |"37"       
protein             |"4.3315+-3.69" |"0.04375+-0.25" |"< 0,001" |"98%"       |"45"       
ribosome            |"3.7261+-3.62" |"0.03043+-0.17" |"< 0,001" |"96%"       |"41"       
RNA                 |"5.6694+-6.22" |"0.04918+-0.25" |"< 0,001" |"98%"       |"39"       
species             |"4.3077+-4.47" |"0.07835+-0.30" |"< 0,001" |"98%"       |"42"       
vaccine             |"5.9744+-5.80" |"0.01282+-0.11" |"< 0,001" |"95%"       |"11"       
Virus               |"4.4777+-4.52" |"0.02077+-0.16" |"< 0,001" |"97%"       |"31" 

### TABLE V. 	User Recommendation
- Go to folder table-V-recommendation
- Execute all sqls in folder sqls
- Export sql data to csv data file (like the CSVs in the folder data)
- Run table-V.R
- The results should look like:

entity              |VOTE_UP_MEAN   |VOTE_DOWN_MEAN  |PV        |EFFECT_SIZE |NUMBER_USER
--------------------|---------------|----------------|----------|------------|-------------
aerobic respiration |"5.2424+-4.06" |"0.06061+-0.24" |"< 0,001" |"97%"       |"12"       
amphibians          |"2.2500+-1.69" |"0.1250+-0.34"  |"< 0,001" |"94%"       |"7"        
bacteria            |"4.0720+-3.78" |"0.04974+-0.22" |"< 0,001" |"97%"       |"47"       
blood               |"2.7200+-2.07" |"0.0000+-0.00"  |"< 0,001" |"94%"       |"12"       
brain               |"4.0494+-3.55" |"0.07716+-0.31" |"< 0,001" |"97%"       |"42"       
cancer              |"3.6755+-3.25" |"0.0266+-0.22"  |"< 0,001" |"97%"       |"30"       
chromosomes         |"3.6863+-2.75" |"0.1025+-0.30"  |"< 0,001" |"95%"       |"40"       
DNA                 |"4.5462+-4.73" |"0.0375+-0.22"  |"< 0,001" |"98%"       |"45"       
enzymes             |"4.1162+-4.41" |"0.01695+-0.13" |"< 0,001" |"98%"       |"39"       
evolutionary        |"5.1257+-4.54" |"0.08461+-0.35" |"< 0,001" |"97%"       |"47"       
gene                |"3.7699+-3.20" |"0.04084+-0.25" |"< 0,001" |"97%"       |"48"       
genetic code        |"5.8121+-6.88" |"0.04242+-0.20" |"< 0,001" |"99%"       |"24"       
genomes             |"3.7837+-3.02" |"0.04436+-0.25" |"< 0,001" |"97%"       |"45"       
hormones            |"4.7054+-4.90" |"0.1250+-0.57"  |"< 0,001" |"94%"       |"25"       
humans              |"4.6830+-4.66" |"0.06575+-0.30" |"< 0,001" |"97%"       |"50"       
muscle              |"3.0855+-2.94" |"0.04605+-0.21" |"< 0,001" |"96%"       |"24"       
organisms           |"4.6674+-5.04" |"0.07296+-0.30" |"< 0,001" |"97%"       |"45"       
plants              |"5.5293+-8.37" |"0.05455+-0.36" |"< 0,001" |"98%"       |"40"       
protein             |"4.1062+-3.60" |"0.03443+-0.22" |"< 0,001" |"97%"       |"44"       
ribosome            |"3.2035+-3.10" |"0.01732+-0.13" |"< 0,001" |"95%"       |"41"       
RNA                 |"5.1458+-5.94" |"0.03836+-0.23" |"< 0,001" |"98%"       |"38"       
species             |"4.1569+-4.48" |"0.07703+-0.30" |"< 0,001" |"97%"       |"44"       
vaccine             |"5.5698+-5.67" |"0.01163+-0.11" |"< 0,001" |"95%"       |"15"       
Virus               |"4.2332+-4.34" |"0.02145+-0.16" |"< 0,001" |"97%"       |"33"  