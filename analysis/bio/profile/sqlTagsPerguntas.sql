
select * from (

select *, (select p.usuarioID from pergunta p where p.id = pt.perguntaID) as idUsuario  
from tag t, perguntatag pt where pt.tagID = t.id  and lower(REPLACE(t.nome, "-", " ")) in (

 select distinct(lower(A.surface)) from (
select 
	a.id_text as idText,
	a.tipo as tipo,
	a.score as score,
	e.uri as uri,
	e.surface as surface,
	(select p.usuarioID from pergunta p where p.id = a.id_text) as idUsuario,
	(select 'BIO' from dual ) as comunidade
from anotacoes a
	inner join entidades e on a.id_entidade = e.id
where  a.id_text like '1_%' and (a.tipo = 'titulo_pergunta' or a.tipo = 'texto_pergunta') 
and a.id_text in (select p.id from pergunta p where p.usuarioID in (
'1_3632', 
'1_1320', 
'1_69', 
'1_430', 
'1_1306', 
'1_107', 
'1_1231', 
'1_4101', 
'1_115', 
'1_66', 
'1_5144', 
'1_6', 
'1_560', 
'1_28', 
'1_1590', 
'1_389', 
'1_806', 
'1_3340', 
'1_81', 
'1_4108', 
'1_307', 
'1_740', 
'1_535', 
'1_43', 
'1_112', 
'1_444', 
'1_1757', 
'1_166', 
'1_1122', 
'1_57', 
'1_948', 
'1_3615', 
'1_3952', 
'1_577', 
'1_3624', 
'1_72', 
'1_219', 
'1_2938', 
'1_3776', 
'1_3059', 
'1_177', 
'1_3971', 
'1_67', 
'1_12', 
'1_1136', 
'1_48', 
'1_1005', 
'1_239', 
'1_204', 
'1_5754'
)) 

union all


select 
	a.id_text as idText,
	a.tipo as tipo,
	a.score as score,
	e.uri as uri,
	e.surface as surface,
	(select p.usuarioID from resposta p where p.id = a.id_text) as idUsuario,
	(select 'BIO' from dual ) as comunidade
from anotacoes a
	inner join entidades e on a.id_entidade = e.id
where  a.id_text like '1_%' and (a.tipo = 'texto_resposta' ) 
and a.id_text in (select p.id from resposta p where p.usuarioID in (
'1_3632', 
'1_1320', 
'1_69', 
'1_430', 
'1_1306', 
'1_107', 
'1_1231', 
'1_4101', 
'1_115', 
'1_66', 
'1_5144', 
'1_6', 
'1_560', 
'1_28', 
'1_1590', 
'1_389', 
'1_806', 
'1_3340', 
'1_81', 
'1_4108', 
'1_307', 
'1_740', 
'1_535', 
'1_43', 
'1_112', 
'1_444', 
'1_1757', 
'1_166', 
'1_1122', 
'1_57', 
'1_948', 
'1_3615', 
'1_3952', 
'1_577', 
'1_3624', 
'1_72', 
'1_219', 
'1_2938', 
'1_3776', 
'1_3059', 
'1_177', 
'1_3971', 
'1_67', 
'1_12', 
'1_1136', 
'1_48', 
'1_1005', 
'1_239', 
'1_204', 
'1_5754'
)) 


) A ) ) B where B.idUsuario is not null