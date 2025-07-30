
-- Tabela de Endereços
CREATE TABLE Endereco (
    id_endereco        SERIAL PRIMARY KEY,
    rua                VARCHAR(80)  NOT NULL,
    numero             VARCHAR(10)  NOT NULL,
    bairro             VARCHAR(40)  NOT NULL,
    cidade             VARCHAR(60)  NOT NULL
);

-- Tabela de Restaurantes
CREATE TABLE Restaurante (
    id_restaurante        SERIAL PRIMARY KEY,
    nome                  VARCHAR(100) NOT NULL,
    data_fundacao         DATE         NOT NULL,
    id_endereco           INTEGER      NOT NULL REFERENCES Endereco(id_endereco),
    tipo_cozinha          VARCHAR(40)  NOT NULL,
    selo_sustentabilidade BOOLEAN      NOT NULL
);

-- Telefones de Restaurante (1:N)
CREATE TABLE TelefoneRestaurante (
    id_telefone     SERIAL PRIMARY KEY,
    id_restaurante  INTEGER      NOT NULL REFERENCES Restaurante(id_restaurante),
    numero          VARCHAR(15)  NOT NULL
);

-- Funcionários (1:N)
CREATE TABLE Funcionario (
    id_funcionario    SERIAL PRIMARY KEY,
    id_restaurante    INTEGER      NOT NULL REFERENCES Restaurante(id_restaurante),
    nome              VARCHAR(100) NOT NULL,
    cargo             VARCHAR(40)  NOT NULL,
    data_admissao     DATE         NOT NULL,
    cpf               VARCHAR(11)  NOT NULL UNIQUE,
    email             VARCHAR(80)  NOT NULL UNIQUE,
    data_nascimento   DATE         NOT NULL,
    salario           NUMERIC(10,2) NOT NULL
);

-- Gerentes (1:1)
CREATE TABLE GerenteRestaurante (
    id_restaurante  INTEGER PRIMARY KEY REFERENCES Restaurante(id_restaurante),
    id_funcionario  INTEGER      NOT NULL UNIQUE REFERENCES Funcionario(id_funcionario)
);

-- Cardápios (1:N)
CREATE TABLE Cardapio (
    id_cardapio     SERIAL PRIMARY KEY,
    id_restaurante  INTEGER      NOT NULL REFERENCES Restaurante(id_restaurante),
    nome            VARCHAR(80)  NOT NULL,
    descricao       VARCHAR(200) NOT NULL,
    data_inicio     DATE         NOT NULL,
    data_fim        DATE,
    publico_alvo    VARCHAR(50)  NOT NULL,
    eh_vegano       BOOLEAN      NOT NULL
);

-- Receitas (1:N)
CREATE TABLE Receita (
    id_receita        SERIAL PRIMARY KEY,
    id_cardapio       INTEGER      NOT NULL REFERENCES Cardapio(id_cardapio),
    nome              VARCHAR(100) NOT NULL,
    descricao         VARCHAR(200) NOT NULL,
    tempo_preparo     INTEGER      NOT NULL,
    dificuldade       VARCHAR(20)  NOT NULL,
    eh_saudavel       BOOLEAN      NOT NULL,
    quantidade_porcoes INTEGER     NOT NULL
);

-- Ingredientes
CREATE TABLE Ingrediente (
    id_ingrediente     SERIAL PRIMARY KEY,
    nome               VARCHAR(80)  NOT NULL,
    tipo               VARCHAR(30)  NOT NULL,
    origem             VARCHAR(50)  NOT NULL,
    organico           BOOLEAN      NOT NULL,
    fornecedor         VARCHAR(100) NOT NULL,
    quantidade_estoque NUMERIC(8,2) NOT NULL,
    unidade_medida     VARCHAR(10)  NOT NULL,
    validade           DATE         NOT NULL
);

-- Associação Receita–Ingrediente (N:N)
CREATE TABLE ReceitaIngrediente (
    id_receita         INTEGER      NOT NULL REFERENCES Receita(id_receita),
    id_ingrediente     INTEGER      NOT NULL REFERENCES Ingrediente(id_ingrediente),
    quantidade_utilizada NUMERIC(8,2) NOT NULL,
    unidade_medida       VARCHAR(10)  NOT NULL,
    PRIMARY KEY (id_receita, id_ingrediente)
);
```
