# Locadora REST API

Esta é uma aplicação REST API para uma locadora de filmes, desenvolvida em Spring Boot e utilizando o Neo4j como banco de dados. Este projeto também inclui um script de shell para interagir com a API.
Aqui esta um vídeo demonstração do projeto: https://youtu.be/Lty3mriiO2I

## Pré-requisitos

- Java 17 ou superior
- Maven
- Neo4j Community Edition 4.x ou superior
- Bash (para rodar o script de shell)
- jq (para formatação de JSON no script de shell)

## Configuração do Neo4j

1. Baixe e instale o Neo4j em sua máquina.
2. Inicie o Neo4j e configure um usuário e senha.
3. Acesse o console do Neo4j (http://localhost:7474) e crie um banco de dados chamado `locadora`.

## Configuração da Aplicação

1. Clone este repositório.
2. Edite o arquivo `application.properties` localizado em `src/main/resources` para incluir as configurações do seu banco de dados Neo4j:

```properties
spring.neo4j.uri=bolt://localhost:7687
spring.neo4j.authentication.username=seu-usuario
spring.neo4j.authentication.password=sua-senha
```
3. Abra um terminal neste projeto
```properties
mvn install
````
4. Gerando o arquivo `videostore-0.0.1-SNAPSHOT.jar`
```properties
java -jar videostore-0.0.1-SNAPSHOT.jar
```
5. Caso queira um script com alguns registros, execute essa query em sua aplicação do Neo4j
```properties
// Criar clientes
CREATE (:Customer {id: 1, name: 'John Doe', email: 'john.doe@example.com'});
CREATE (:Customer {id: 2, name: 'Jane Smith', email: 'jane.smith@example.com'});
CREATE (:Customer {id: 3, name: 'Michael Johnson', email: 'michael.johnson@example.com'});
CREATE (:Customer {id: 4, name: 'Emily Davis', email: 'emily.davis@example.com'});
CREATE (:Customer {id: 5, name: 'David Wilson', email: 'david.wilson@example.com'});

// Criar filmes
CREATE (:Movie {id: 1, title: 'The Matrix', genre: 'Sci-Fi', year: 1999, director: 'Lana Wachowski', available: true});
CREATE (:Movie {id: 2, title: 'Inception', genre: 'Sci-Fi', year: 2010, director: 'Christopher Nolan', available: true});
CREATE (:Movie {id: 3, title: 'The Dark Knight', genre: 'Action', year: 2008, director: 'Christopher Nolan', available: true});
CREATE (:Movie {id: 4, title: 'Forrest Gump', genre: 'Drama', year: 1994, director: 'Robert Zemeckis', available: true});
CREATE (:Movie {id: 5, title: 'The Godfather', genre: 'Crime', year: 1972, director: 'Francis Ford Coppola', available: true});
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
