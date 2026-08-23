Table escola {
  cd_escola integer [pk, increment]
  nome varchar(150) [not null]
  telefone varchar(20)
  cep varchar(9)
  numero varchar(20)
  categoria_administrativa varchar(20) [not null, note: 'PUBLICA ou PRIVADA']
  img_logo text
  criada_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  ativa boolean [not null, default: true]

  Note: '''
  CHECK (categoria_administrativa IN ('PUBLICA', 'PRIVADA'))
  '''
}