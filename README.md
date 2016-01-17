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
We translate the names in order to help you to understand.

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


## Analysis
### TABLE I. 	OVERVIEW OF THE BQA REPUTATION SCORE 
