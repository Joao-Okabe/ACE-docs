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

Table usuario_papel {
  cd_usuario integer [not null]
  cd_papel integer [not null]
  ativo boolean [not null, default: true]

  indexes {
    (cd_usuario, cd_papel) [pk]
  }
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

Table formato {
  cd_formato integer [pk, increment]
  nm_formato varchar(30) [not null]
  ds_formato text
}

Table modalidade {
  cd_modalidade integer [pk, increment]
  sexo varchar(5) [not null]
  categoria varchar(10) [not null]

  indexes {
    (sexo, categoria) [unique]
  }

  Note: 'sexo: M, F ou MISTO, categoria: Sub14, Sub18 ou MISTO'
}

Table esporte {
  cd_esporte integer [pk, increment]
  nm_esporte varchar(30) [not null]
  ds_esporte text
}

// ============================================================
// 6. COMPETIÇÃO
// ============================================================

Table competicao {
  cd_competicao integer [pk, increment]
  nm_competicao varchar(150) [not null]
  cd_criador integer
  cd_esporte integer [not null]
  cd_modalidade integer [not null]
  cd_formato integer [not null]
  cd_escola integer
  inicio_em timestamp
  fim_em timestamp
  status varchar(30) [not null, default: 'PLANEJADA']
  descricao text
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]

  Note: 'status: PLANEJADA, INSCRICOES, EM_ANDAMENTO, FINALIZADA ou CANCELADA'
}


// Competição
Ref: competicao.cd_criador > usuario.cd_usuario
Ref: competicao.cd_esporte > esporte.cd_esporte
Ref: competicao.cd_modalidade > modalidade.cd_modalidade
Ref: competicao.cd_formato > formato.cd_formato
Ref: competicao.cd_escola > escola.cd_escola
