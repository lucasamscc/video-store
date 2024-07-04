# Locadora REST API

Esta é uma aplicação REST API para uma locadora de filmes, desenvolvida em Spring Boot e utilizando o Neo4j como banco de dados. Este projeto também inclui um script de shell para interagir com a API.

## Pré-requisitos

- Java 17 ou superior
- Maven
- Neo4j Community Edition 4.x ou superior
- Bash (para rodar o script de shell)
- jq (para formatação de JSON no script de shell)

## Configuração do Neo4j

1. Baixe e instale o Neo4j Community Edition: [Neo4j Downloads](https://neo4j.com/download/)
2. Inicie o Neo4j e configure um usuário e senha.
3. Acesse o console do Neo4j (http://localhost:7474) e crie um banco de dados chamado `locadora`.

## Configuração da Aplicação

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/locadora-rest-api.git
   cd locadora-rest-api
2. Edite o arquivo `application.properties` localizado em `src/main/resources` para incluir as configurações do seu banco de dados Neo4j:

```properties
spring.neo4j.uri=bolt://localhost:7687
spring.neo4j.authentication.username=seu-usuario
spring.neo4j.authentication.password=sua-senha
```



# Locadora utilizando Banco de Dados Neo4j

## Entidades (Nós)

### Customer (Cliente)
- Representa os clientes da locadora.
- Atributos:
  - `id`: Identificador único do cliente.
  - `name`: Nome do cliente.
  - `email`: Email do cliente.

### Movie (Filme)
- Representa os filmes disponíveis para locação na locadora.
- Atributos:
  - `id`: Identificador único do filme.
  - `title`: Título do filme.
  - `genre`: Gênero do filme.
  - `year`: Ano de lançamento do filme.
  - `director`: Diretor do filme.
  - `available`: Indica se o filme está disponível para locação.

### Rental (Aluguel)
- Representa uma transação de aluguel, onde um cliente aluga um filme.
- Atributos:
  - `id`: Identificador único do aluguel.
  - `rentDate`: Data do aluguel.
  - `returnDate`: Data de devolução.

## Relacionamentos

### Customer `RENTED_BY` -> Rental
- Tipo: `RENTED_BY`
- Direção: Do nó `Rental` para o nó `Customer`.
- Descrição: Indica que um aluguel foi realizado por um cliente específico.

### Rental `RENTS` -> Movie
- Tipo: `RENTS`
- Direção: Do nó `Rental` para o nó `Movie`.
- Descrição: Indica que um aluguel envolve um filme específico.
