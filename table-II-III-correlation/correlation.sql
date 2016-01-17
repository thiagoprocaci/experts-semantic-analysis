select 
u.id as idUsuario,
u.reputacao as reputacao,
(select count(distinct r.id) from resposta r where r.usuarioID = u.id ) as respostas,
(select count(distinct r.id) from pergunta r where r.usuarioID = u.id ) as perguntas,
(select count(distinct r.id) from comentariopergunta r where r.usuarioID = u.id ) as comentariospergunta,
(select count(distinct r.id) from comentarioresposta r where r.usuarioID = u.id ) as comentariosresposta,
(select 'BIO' from dual) as comunidade
 from usuario u where u.id like '1_%' order by 2 desc