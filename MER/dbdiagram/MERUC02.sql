Table papel {
  cd_papel integer [pk, increment]
  nome varchar(50) [not null, unique]
  descricao text
}

Table usuario {
  cd_usuario integer [pk, increment]
  email varchar(255) [not null, unique]
  senha varchar(255) [not null]
  foto_perfil varchar(255) [not null]
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  atualizado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
}

Table escola {
  cd_escola integer [pk, increment]
}

Table vinculo_usuario_escola {
  cd_usuario integer [not null]
  cd_escola integer [not null]
  cd_papel integer [not null]
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]

  indexes {
    (cd_usuario, cd_escola, cd_papel) [pk]
  }
}

Ref: vinculo_usuario_escola.cd_usuario > usuario.cd_usuario [delete: cascade]
Ref: vinculo_usuario_escola.cd_escola > escola.cd_escola [delete: cascade]
Ref: vinculo_usuario_escola.cd_papel > papel.cd_papel [delete: restrict]
