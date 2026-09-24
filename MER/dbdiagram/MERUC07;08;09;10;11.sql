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

Table usuario {
  cd_usuario integer [pk, increment]
  nm_usuario varchar(255) [not null]
  email varchar(255) [not null, unique]
  senha varchar(255) [not null]
  foto_perfil varchar(255) [not null]
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  atualizado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
}

/*
    Papel descreve as funções dos usuários
    como: aluno, professor, coordenador, diretor e etc
*/
Table papel {
  cd_papel integer [pk, increment]
  nome varchar(50) [not null, unique]
  descricao text
}

/*
    Embora o papel aluno exista, ele não guarda algumas informações
    necessárias pelo sistema, como a idade e o RA 
*/
Table aluno {
  cd_aluno integer [not null]
  cd_usuario integer [not null]
  ra varchar(20) [not null, unique]
  data_nascimento date [not null]
  sexo char(1)
  telefone varchar(20)
  cep varchar(9)
  foto_perfil text
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  atualizado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]

  indexes {
    (cd_aluno, cd_usuario) [pk]
  }

  Note: '''
  CHECK (sexo IN ('M', 'F', 'O') OR sexo IS NULL)
  '''
}

/*
    Vincula um usuário com uma escola e um papel
    deste modo é possível que o mesmo usuário possua diferentes 
    papéis em diferentes escolas, por exemplo:

    Vinculo 1
    cd_usuario THIAGO
    cd_escola ETEC de Itanhaém
    cd_papel Coordenador

    Vinculo 2 
    cd_usuario THIAGO
    cd_escola Albert Einstein
    cd_papel Professor
*/
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
/*FIM DO RF01 E RF02*/


/* RELACIONAMENTOSENTRE AS TABELAS */

//  RF01 E RF02

Ref: vinculo_usuario_escola.cd_usuario > usuario.cd_usuario [delete: cascade]
Ref: vinculo_usuario_escola.cd_escola > escola.cd_escola [delete: cascade]
Ref: vinculo_usuario_escola.cd_papel > papel.cd_papel [delete: restrict]

Ref: aluno.cd_usuario > usuario.cd_usuario [delete: cascade]
