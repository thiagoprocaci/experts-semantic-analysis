select * from (

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
where  a. id_text like '1_%' and a.tipo = 'titulo_pergunta'

union all 

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
where  a. id_text like '1_%' and a.tipo = 'texto_pergunta'

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
where  a. id_text like '1_%' and a.tipo = 'texto_resposta'

union all

select 
	a.id_text as idText,
	a.tipo as tipo,
	a.score as score,
	e.uri as uri,
	e.surface as surface,
	(select p.usuarioID from comentariopergunta p where p.id = a.id_text) as idUsuario,
	(select 'BIO' from dual ) as comunidade
from anotacoes a
	inner join entidades e on a.id_entidade = e.id
where  a. id_text like '1_%' and a.tipo = 'comentario_pergunta'

union all

select 
	a.id_text as idText,
	a.tipo as tipo,
	a.score as score,
	e.uri as uri,
	e.surface as surface,
	(select p.usuarioID from comentarioresposta p where p.id = a.id_text) as idUsuario,
	(select 'BIO' from dual ) as comunidade
from anotacoes a
	inner join entidades e on a.id_entidade = e.id
where  a. id_text like '1_%' and a.tipo = 'comentario_resposta'


) w where w.idUsuario is not null
