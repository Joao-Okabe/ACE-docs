/*RF01 E RF02*/
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

Table time {
  cd_time integer [pk, increment]
  nm_time varchar(50) [not null, unique] 
  path_brasao varchar(255) [not null]
  ativo boolean [not null, default: true]
  principal boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  atualizado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
}


//Vincula um time à uma escola
Table vinculo_time_escola {
  cd_escola integer [not null]
  cd_time integer [not null]
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]

  indexes {
    (cd_escola, cd_time) [pk]
  }
}

/*FIM RF03 E RF04*/

/* RELACIONAMENTOSENTRE AS TABELAS */
// RF 03 E 04

Ref: vinculo_time_escola.cd_escola > escola.cd_escola
Ref: vinculo_time_escola.cd_time > time.cd_time