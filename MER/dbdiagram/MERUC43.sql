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

Table esporte {
  cd_esporte integer [increment]
  nm_esporte varchar(255) [not null]
  ds_esporte varchar(2048) [not null]

  indexes {
    (cd_esporte) [pk]
  }
}



Table competicao {
  cd_competicao integer [not null]
  cd_criador integer [not null]
  nm_competicao varchar(255) [not null]


  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  dt_inicio timestamp [not null]
  dt_encerramento timestamp [not null]
  
  indexes {
    (cd_competicao, cd_criador) [pk]
  }
}

/*
    As tabelas de formato, modalidade e esporte servem para
    termos as informações em um lugar só, sem termos que 
    repetir elas 
*/
Table formato{
  cd_formato integer [not null]
  nm_formato varchar(30) [not null]
  ds_formato varchar(2048) [not null]

  indexes {
    (cd_formato) [pk]
  }
}

Table modalidade {
  cd_modalidade integer [not null]
  ds_restr_genero char(5) 
  ds_restr_idade char(5) 

  indexes {
    (cd_modalidade) [pk]
  }

  Note: '''
  CHECK (ds_genero IN ('H', 'M', 'MISTO') OR ds_genero IS NULL)
  CHECK (ds_idade IN ('sub') OR ds_idade IS NULL)
  '''
}

/* PARTIDA:
   Partida, apesar de tudo serve mais como a chave principal
   uma vez que incluir todas as informações e uma única tabela 
   fosse impossível, por cada partida de uma competição ter suas
   variações, por exemplo, esporte, modalidade e formato são 
   possíveis de incluir pois são informações genéricas.

   Porém, coisas como arbitros, pontuação e tempos são dependentes
   de outras informações como o esporte e formato.
 */
Table partida{
  cd_partida integer [not null]
  cd_competicao integer [not null]
  cd_esporte varchar [not null]
  cd_modalidade integer [not null]
  cd_formato integer [not null]

  indexes {
    (cd_partida) [pk]
  }
}

Table info_partida{
  cd_partida integer [not null]
  dt_partida timestamp [not null]
  local_partida varchar(1024) [not null]
 
  indexes {
    (cd_partida) [pk]
  }
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

//Responsável é o técnico do time (Professor)
Table responsavel {
  cd_responsavel integer [increment]
  cd_usuario integer [not null]
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]
  
  indexes {
    (cd_responsavel, cd_usuario) [pk]
  }
}

/*
    Descreve a função do integrante de um time, por exemplo:
    Caso o time seja de vôlei:
    1
    2(esporte)
    Libero
    "descrição dessa função"
*/
Table funcao_integrante {
  cd_funcao_integrante integer [pk, increment]
  cd_esporte integer [not null]
  nm_funcao varchar(150) [not null]
  ds_funcao varchar(150) [not null]
}

//Vincula um técnico à um time
Table vinculo_responsavel_time {
  cd_responsavel integer [not null]
  cd_time integer [not null]
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]

  indexes {
    (cd_responsavel, cd_time) [pk]
  }
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

/*
    Vincula um usuário à um time com uma função, por exemplo:
    Bryan
    VarzeaFC
    Zagueiro
    True
    timestamp
*/
Table vinculo_time_integrante {
  cd_usuario integer [not null]
  cd_time integer [not null]
  cd_funcao_integrante integer [not null]
  ativo boolean [not null, default: true]
  criado_em timestamp [not null, default: `CURRENT_TIMESTAMP`]

  indexes {
    (cd_usuario, cd_time, cd_funcao_integrante) [pk]
  }
}

/*FIM RF03 E RF04*/

/* RELACIONAMENTOSENTRE AS TABELAS */

//  RF01 E RF02

Ref: vinculo_usuario_escola.cd_usuario > usuario.cd_usuario [delete: cascade]
Ref: vinculo_usuario_escola.cd_escola > escola.cd_escola [delete: cascade]
Ref: vinculo_usuario_escola.cd_papel > papel.cd_papel [delete: restrict]

Ref: aluno.cd_usuario > usuario.cd_usuario [delete: cascade]

// RF 03 E 04

Ref: info_partida.cd_partida - partida.cd_partida


Ref: partida.cd_competicao > competicao.cd_competicao
Ref: partida.cd_modalidade > modalidade.cd_modalidade
Ref: partida.cd_formato > formato.cd_formato
Ref: partida.cd_esporte > esporte.cd_esporte

Ref: funcao_integrante.cd_esporte > esporte.cd_esporte

Ref: vinculo_time_escola.cd_escola > escola.cd_escola
Ref: vinculo_time_escola.cd_time > time.cd_time

Ref: vinculo_responsavel_time.cd_responsavel > responsavel.cd_responsavel
Ref: vinculo_responsavel_time.cd_time > time.cd_time

Ref: vinculo_time_integrante.cd_time > time.cd_time
Ref: vinculo_time_integrante.cd_usuario > usuario.cd_usuario
Ref: vinculo_time_integrante.cd_funcao_integrante > funcao_integrante.cd_funcao_integrante