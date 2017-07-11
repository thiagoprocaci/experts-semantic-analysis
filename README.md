# Project experts-semantic-analysis
## Summary
This project is part of a scientific research. We are interested in knowing how to find experts in online community.
You can find here the analysis of the paper "Finding Topical Experts in Question & Answer Communities" published at "The 16th IEEE International Conference on Advanced Learning Technologies - ICALT 2016" (http://ieeexplore.ieee.org/document/7757009/).
In other words, you will find here everything you need to reproduce this research.

If you use anything related to this research, please cite:

```
@inproceedings{topical-experts-2016,

  title={Finding Topical Experts in Question \& Answer Communities},

  author={Procaci, Thiago B and Nunes, Bernardo Pereira and Nurmikko-Fuller, Terhi and Siqueira, Sean WM},

  booktitle={Advanced Learning Technologies (ICALT), 2016 IEEE 16th International Conference on},

  pages={407--411},

  year={2016},

  organization={IEEE}
}
```

## Setup the environment
- Install R version 3.1.1 (available at https://www.r-project.org/)
- Install mySQL database version 5.6.21 (available at http://dev.mysql.com/downloads/)

## Loading data into MySQL
- Download the scripts from https://github.com/thiagoprocaci/qarepo
- Run createDatabase.sql
- Run the other scripts and follow the instructions avaliable at https://github.com/thiagoprocaci/qarepo.
- If you want to use the raw data, take a look at rawdata/dadosBio.zip. However, we recommend using the sql scripts.

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

### TABLE IV. 	Users Grouped by Expertise
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

### TABLE V. 	Users Grouped by Expertise - No reputation
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

### TABLE VI. 	Recommendation Testing
- Go to folder table-V-recommendation
- Execute all sqls in folder sql-recommendation and sql-recommendation2
- Export sql data to csv data file (like the CSVs in the folder recommedation)
- Run recommedation-test.R
- The results should look like:

entity                |"USER_REC" |"USER_ANSWERED_QUESTION" |"PERCENT" |"AVG_ANSWERS" |"AVG_VOTE_UP" |"AVG_VOTE_DOWN" |"PV"     |"EFFECT_SIZE"
----------------------|-----------|-------------------------|----------|--------------|--------------|----------------|---------|--------------
"aerobic respiration" |"12"       | "4"                     | "33%"    | "2+-0.58"    |"4+-1.84"     | "0.00+-0.00"   |"0.0202" | "100%"
"amphibians"          | "7"       | "2"                     |"29%"     | "1+-0.00"    |"2+-3.54"     |"0.00+-0.00"    |"0.6171" | "75%"
"bacteria"            |"47"       |"40"                     |"85%"     | "5+-5.60"    |"4+-3.67"     |"0.06+-0.18"    |"< 0,001"| "97%"
"blood"               |"12"       |"5"                      |"42%"     |"1+-0.89"     |"4+-2.98"     |"0.00+-0.00"    |"0.0254" |"90%"
"brain"               |"42"       |"34"                     |"81%"     |"3+-2.72"     |"4+-2.96"     |"0.05+-0.18"    |"< 0,001"| "98%"
"cancer"              |"30"       |"22"                     |"73%"     |"2+-1.37"     |"4+-2.50"     |"0.00+-0.00"    |"< 0,001"| "100%"
"chromosomes"         |"40"       |"33"                     |"82%"     |"2+-2.10"     |"4+-3.59"     |"0.06+-0.24"    |"< 0,001"| "100%"
"dna"                 |"45"       |"44"                     |"98%"     |"7+-7.82"     |"4+-2.63"     |"0.03+-0.09"    |"< 0,001"| "100%"
"enzymes"             |"39"       |"29"                     |"74%"     |"3+-3.99"     |"3+-2.34"     |"0.01+-0.06"    |"< 0,001"| "98%"
"evolutionary"        |"47"       |"44"                     |"94%"     |"7+-8.97"     |"5+-3.53"     |"0.09+-0.19"    |"< 0,001"| "100%"
"gene"                |"48"       |"44"                     |"92%"     |"7+-7.27"     |"3+-2.00"     |"0.02+-0.07"    |"< 0,001"| "100%"
"genetic code"        |"24"       |"15"                     | "62%"    |"2+-0.72"     | "4+-2.26"    |"0.07+-0.26"    |"< 0,001"| "100%"
"genomes"             |"45"       |"36"                     |"80%"     |"4+-4.15"     |"4+-3.34"     |"0.04+-0.17"    |"< 0,001"| "98%"
"hormones"            |"25"       |"15"                     |"60%"     |"3+-2.37"     |"4+-2.98"     |"0.00+-0.00"    |"< 0,001"| "97%"
"humans"              |"50"       |"50"                     |"100%"    |"9+- 9.50"    |"5+-6.52"     |"0.05+-0.13"    |"< 0,001"| "100%"
"muscle"              |"24"       |"13"                     |"54%"     |"2+-1.50"     |"4+-2.06"     |"0.08+-0.28"    |"< 0,001"| "100%"
"organisms"           |"45"       |"42"                     |"93%"     |"5+-5.76"     |"5+-3.92"     |"0.09+-0.27"    |"< 0,001"| "100%"
"plants"              |"40"       |"38"                     |"95%"     |"4+-4.49"     |"4+-3.35"     |"0.03+-0.10"    |"< 0,001"| "99%"
"protein"             |"44"       |"39"                     |"89%"     |"8+-9.02"     |"4+-2.42"     |"0.007+-0.03"   |"< 0,001"| "96%"
"ribosome"            |"41"       |"30"                     |"73%"     |"2+-2.09"     |"3+-2.16"     |"0.08+-0.32"    |"< 0,001"| "96%"
"rna"                 |"38"       |"25"                     |"66%"     |"3+-3.34"     |"4+-2.97"     |"0.05+-0.20"    |"< 0,001"| "100%"
"species"             |"44"       |"42"                     |"95%"     |"6+-5.97"     |"5+-3.57"     |"0.12+-0.36"    |"< 0,001"| "98%"
"vaccine"             |"15"       |"7"                      |"47%"     |"1+-0.38"     |"6+-8.32"     |"0.00+-0.00"    |"0.0037" |"93%"
"virus"               |"33"       |"25"                     |"76%"     |"3+-2.33"     |"4+-2.72"     |"0.00+-0.00"    |"< 0,001"| "98%"

