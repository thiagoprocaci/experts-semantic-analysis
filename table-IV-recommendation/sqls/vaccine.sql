select userProfile.*, p.votosPositivos, p.votosNegativos from (


SELECT *
FROM (
SELECT 
	a.id_text AS idText,
	a.tipo AS tipo,
	a.score AS score,
	e.uri AS uri,
	e.surface AS surface,
	(
SELECT p.usuarioID
FROM pergunta p
WHERE p.id = a.id_text) AS idUsuario,
	(
SELECT 'BIO'
FROM DUAL) AS comunidade
FROM anotacoes a
INNER JOIN entidades e ON a.id_entidade = e.id
WHERE a.id_text LIKE '1_%' AND (a.tipo = 'titulo_pergunta' OR a.tipo = 'texto_pergunta') AND a.id_text IN (
SELECT p.id
FROM pergunta p
WHERE p.usuarioID IN (
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
'1_5754',
''
)) UNION ALL
SELECT 
	a.id_text AS idText,
	a.tipo AS tipo,
	a.score AS score,
	e.uri AS uri,
	e.surface AS surface,
	(
SELECT p.usuarioID
FROM resposta p
WHERE p.id = a.id_text) AS idUsuario,
	(
SELECT 'BIO'
FROM DUAL) AS comunidade
FROM anotacoes a
INNER JOIN entidades e ON a.id_entidade = e.id
WHERE a.id_text LIKE '1_%' AND (a.tipo = 'texto_resposta') AND a.id_text IN (
SELECT p.id
FROM resposta p
WHERE p.usuarioID IN (
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
'1_5754',
''
)) 


) A ) userProfile, pergunta p where lower(userProfile.surface) = 'vaccine'
		and p.id = userProfile.idText

union all

select userProfile.*, p.votosPositivos, p.votosNegativos from (


SELECT *
FROM (
SELECT 
	a.id_text AS idText,
	a.tipo AS tipo,
	a.score AS score,
	e.uri AS uri,
	e.surface AS surface,
	(
SELECT p.usuarioID
FROM pergunta p
WHERE p.id = a.id_text) AS idUsuario,
	(
SELECT 'BIO'
FROM DUAL) AS comunidade
FROM anotacoes a
INNER JOIN entidades e ON a.id_entidade = e.id
WHERE a.id_text LIKE '1_%' AND (a.tipo = 'titulo_pergunta' OR a.tipo = 'texto_pergunta') AND a.id_text IN (
SELECT p.id
FROM pergunta p
WHERE p.usuarioID IN (
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
'1_5754',
''
)) UNION ALL
SELECT 
	a.id_text AS idText,
	a.tipo AS tipo,
	a.score AS score,
	e.uri AS uri,
	e.surface AS surface,
	(
SELECT p.usuarioID
FROM resposta p
WHERE p.id = a.id_text) AS idUsuario,
	(
SELECT 'BIO'
FROM DUAL) AS comunidade
FROM anotacoes a
INNER JOIN entidades e ON a.id_entidade = e.id
WHERE a.id_text LIKE '1_%' AND (a.tipo = 'texto_resposta') AND a.id_text IN (
SELECT p.id
FROM resposta p
WHERE p.usuarioID IN (
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
'1_5754',
''
)) 


) A ) userProfile, resposta p where lower(userProfile.surface) = 'vaccine'
		and p.id = userProfile.idText