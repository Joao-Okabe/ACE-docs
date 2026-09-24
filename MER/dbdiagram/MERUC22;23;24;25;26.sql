
// ============================================================
// 2. USUÁRIOS
// ============================================================

Table usuario {
  cd_usuario integer [pk, increment]
  nm_usuario varchar(150) [not null]
  email varchar(150) [not null, unique]
  senha varchar(255) [not null]
  path_ft_usuario varchar
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  atualizado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
}
// ============================================================
// 3. ESCOLA
// ============================================================

Table escola {
  cd_escola integer [pk, increment]
  nm_escola varchar(150) [not null]
  numero varchar(20)
  cep varchar(9)
  telefone varchar(20)
  email varchar(150)
  categoria_administrativa varchar(20) [not null]
  path_brasao text
  criada_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  ativa boolean [not null, default: true]

  Note: 'categoria_administrativa: Escola Municipal, Escola Estadual ou Privada'
}

// ============================================================
// 5. CONFIGURAÇÕES ESPORTIVAS
// ============================================================

Table esporte {
  cd_esporte integer [pk, increment]
  nm_esporte varchar(30) [not null]
  ds_esporte text
}

// ============================================================
// 7. TIMES
// ============================================================

Table time {
  cd_time integer [pk, increment]
  nm_time varchar(100) [not null]
  cd_esporte integer [not null]
  descricao text
  principal boolean [not null, default: false]
  path_escudo varchar(255)
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  atualizado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
}

Table funcao_integrante {
  cd_funcao_integrante integer [pk, increment]
  cd_esporte integer [not null]
  nm_funcao varchar(100) [not null]
  ds_funcao text

  indexes {
    (cd_esporte, nm_funcao) [unique]
  }
}

Table vinculo_time_escola {
  cd_time integer [not null]
  cd_escola integer [not null]
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]

  indexes {
    (cd_time, cd_escola) [pk]
  }
}

Table vinculo_time_integrante {
  cd_vinculo_time_integrante integer [pk, increment]
  cd_time integer [not null]
  cd_usuario integer [not null]
  cd_funcao_integrante integer
  numero_camisa integer
  capitao boolean [not null, default: false]
  ativo boolean [not null, default: true]

  indexes {
    (cd_time, cd_usuario) [unique]
  }

  Note: 'numero_camisa deve ser maior que 0 quando informado'
}


// ============================================================
// 8. RESPONSÁVEIS
// ============================================================

Table responsavel {
  cd_responsavel integer [pk, increment]
  cd_usuario integer [not null, unique]
  ativo boolean [not null, default: true]
}

Table vinculo_time_responsavel {
  cd_time integer [not null]
  cd_responsavel integer [not null]
  ativo boolean [not null, default: true]

  indexes {
    (cd_time, cd_responsavel) [pk]
  }
}
// ============================================================
// RELACIONAMENTOS
// ============================================================

// Times
Ref: time.cd_esporte > esporte.cd_esporte
Ref: funcao_integrante.cd_esporte > esporte.cd_esporte

Ref: vinculo_time_escola.cd_time > time.cd_time
Ref: vinculo_time_escola.cd_escola > escola.cd_escola

Ref: vinculo_time_integrante.cd_time > time.cd_time
Ref: vinculo_time_integrante.cd_usuario > usuario.cd_usuario
Ref: vinculo_time_integrante.cd_funcao_integrante > funcao_integrante.cd_funcao_integrante

// Responsáveis
Ref: responsavel.cd_usuario > usuario.cd_usuario
Ref: vinculo_time_responsavel.cd_time > time.cd_time
Ref: vinculo_time_responsavel.cd_responsavel > responsavel.cd_responsavel