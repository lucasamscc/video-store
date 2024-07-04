#!/bin/bash

export LC_CTYPE="pt_BR.UTF-8"
export LC_ALL="pt_BR.UTF-8"

# Configuração da API
BASE_URL="http://localhost:8080"

# Função para listar todos os clientes
listar_clientes() {
    echo "Listando clientes:"
    response=$(curl -s "$BASE_URL/customers")
    
    # Verifica se há clientes retornados
    if [[ $(echo "$response" | jq length) -eq 0 ]]; then
        echo "Nenhum cliente encontrado."
    else
        # Formata a saída para cada cliente
        echo "$response" | jq -r '.[] | "ID: \(.id), Nome: \(.name), Email: \(.email)"'
    fi
}

# Função para criar um novo cliente
criar_cliente() {
    echo "Digite o nome do cliente:"
    read -r nome

    echo "Digite o email do cliente:"
    read -r email

    # Usar jq para construir o JSON de forma segura
    json_data=$(jq -n --arg nome "$nome" --arg email "$email" '{name: $nome, email: $email}')
    
    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json_data" "$BASE_URL/customers")
    echo "Cliente criado:"
    echo "$response"
}

# Função para deletar um cliente pelo ID
deletar_cliente() {
    echo "Listando clientes disponíveis:"
    listar_clientes

    echo "Digite o ID do cliente que deseja deletar:"
    read -r id

    response=$(curl -s -X DELETE "$BASE_URL/customers/$id")
    echo "Cliente deletado:"
    echo "$response"
}

# Função para listar todos os filmes
listar_filmes() {
    echo "Listando filmes:"
    response=$(curl -s "$BASE_URL/movies")
    
    # Verifica se há filmes retornados
    if [[ $(echo "$response" | jq length) -eq 0 ]]; then
        echo "Nenhum filme encontrado."
    else
        # Formata a saída para cada filme
        echo "$response" | jq -r '.[] | "ID: \(.id), Titulo: \(.title), Genero: \(.genre), Ano: \(.year), Diretor: \(.director), Disponivel: \(.available)"'
    fi
}

# Função para listar todos os filmes disponíveis
listar_filmes_disponiveis() {
    echo "Listando filmes disponíveis:"
    response=$(curl -s "$BASE_URL/movies")
    
    # Verifica se há filmes retornados
    if [[ $(echo "$response" | jq length) -eq 0 ]]; then
        echo "Nenhum filme disponível."
    else
        # Filtra os filmes disponíveis e formata a saída
        echo "$response" | jq -r '.[] | select(.available == true) | "ID: \(.id), Título: \(.title), Genero: \(.genre), Ano: \(.year), Diretor: \(.director)"'
    fi
}

# Função para criar um novo filme
criar_filme() {
    echo "Digite o título do filme:"
    read -r titulo

    echo "Digite o gênero do filme:"
    read -r genero

    echo "Digite o ano do filme:"
    read -r ano

    echo "Digite o diretor do filme:"
    read -r diretor

    # Usar jq para construir o JSON de forma segura
    json_data=$(jq -n --arg titulo "$titulo" --arg genero "$genero" --argjson ano $ano --arg diretor "$diretor" '{title: $titulo, genre: $genero, year: $ano, director: $diretor}')

    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json_data" "$BASE_URL/movies")
    echo "Filme criado:"
    echo "$response"
}

# Função para deletar um filme pelo ID
deletar_filme() {
    echo "Listando filmes disponíveis:"
    listar_filmes

    echo "Digite o ID do filme que deseja deletar:"
    read -r id

    response=$(curl -s -X DELETE "$BASE_URL/movies/$id")
    echo "Filme deletado:"
    echo "$response"
}

# Função para listar todos os aluguéis
listar_alugueis() {
    echo "Listando aluguéis:"
    response=$(curl -s "$BASE_URL/rentals")

    # Verifica se há aluguéis retornados
    if [[ $(echo "$response" | jq length) -eq 0 ]]; then
        echo "Nenhum aluguel encontrado."
    else
        # Formata a saída para cada aluguel
        echo "$response" | jq -r '.[] | "ID: \(.id), Cliente: \(.customer.name), Filme: \(.movie.title), Data de Aluguel: \(.rentDate), Data de Devolucao: \(.returnDate // "Nao devolvido")"'
    fi
}

# Função para criar um novo aluguel
criar_aluguel() {
    echo "Listando clientes disponíveis:"
    listar_clientes

    echo "Digite o ID do cliente:"
    read -r customerId

    echo "Listando filmes disponíveis:"
    listar_filmes_disponiveis  # Utiliza a função atualizada para listar apenas os filmes disponíveis

    echo "Digite o ID do filme:"
    read -r movieId

    # Usar jq para construir o JSON de forma segura
    json_data=$(jq -n --argjson customerId "$customerId" --argjson movieId "$movieId" '{customerId: $customerId, movieId: $movieId}')
    
    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json_data" "$BASE_URL/rentals")
    echo "Aluguel criado:"
    echo "$response"
}


# Função para finalizar um aluguel pelo ID
finalizar_aluguel() {
    echo "Listando aluguéis disponíveis:"
    listar_alugueis

    echo "Digite o ID do aluguel que deseja finalizar:"
    read -r id

    response=$(curl -s -X PUT "$BASE_URL/rentals/$id/end")
    echo "Aluguel finalizado:"
    echo "$response"
}

# Função para listar filmes com mais de 10 anos
listar_filmes_mais_de_10_anos() {
    echo "Listando filmes com mais de 10 anos:"
    response=$(curl -s "$BASE_URL/reports/old-movies")

    # Verifica se há filmes retornados
    if [[ $(echo "$response" | jq length) -eq 0 ]]; then
        echo "Nenhum filme com mais de 10 anos encontrado."
    else
        # Formata a saída para cada filme com mais de 10 anos
        echo "$response" | jq -r '.[] | "Titulo: \(.Movie), Ano: \(.Year)"'
    fi
}

# Função para listar o histórico de aluguéis
listar_historico_alugueis() {
    echo "Listando o histórico de aluguéis:"
    response=$(curl -s "$BASE_URL/reports/rental-history")

    # Verifica se há histórico de aluguéis retornados
    if [[ $(echo "$response" | jq length) -eq 0 ]]; then
        echo "Nenhum histórico de aluguel encontrado."
    else
        # Formata a saída para cada entrada no histórico de aluguéis
        echo "$response" | jq -r '.[] | "ID: \(.RentalId), Cliente: \(.Customer), Filme: \(.Movie), Data de Aluguel: \(.RentDate), Data de Devolucao: \(.ReturnDate // "Não devolvido")"'
    fi
}

# Função para listar filmes atualmente alugados
listar_filmes_alugados_atualmente() {
    echo "Listando filmes alugados atualmente:"
    response=$(curl -s "$BASE_URL/reports/currently-rented-movies")

    # Verifica se há filmes alugados atualmente retornados
    if [[ $(echo "$response" | jq length) -eq 0 ]]; then
        echo "Nenhum filme alugado atualmente encontrado."
    else
        # Formata a saída para cada filme alugado atualmente
        echo "$response" | jq -r '.[] | "Titulo: \(.MovieTitle), Genero: \(.Genre), Ano: \(.Year), Diretor: \(.Director)"'
    fi
}

# Menu principal
while true; do
    echo "Escolha uma opção:"
    echo "1. Clientes"
    echo "2. Filmes"
    echo "3. Aluguéis"
    echo "4. Relatórios"
    echo "5. Sair"

    read -r opcao

    case $opcao in
        1)
            echo "Menu de clientes:"
            echo "1. Listar clientes"
            echo "2. Criar novo cliente"
            echo "3. Deletar cliente"
            echo "4. Voltar"

            read -r opcao_cliente

            case $opcao_cliente in
                1) listar_clientes ;;
                2) criar_cliente ;;
                3) deletar_cliente ;;
                4) echo "Voltando ao menu principal..." ;;
                *) echo "Opção inválida" ;;
            esac
            ;;
        2)
            echo "Menu de filmes:"
            echo "1. Listar filmes"
            echo "2. Criar novo filme"
            echo "3. Deletar filme"
            echo "4. Voltar"

            read -r opcao_filme

            case $opcao_filme in
                1) listar_filmes ;;
                2) criar_filme ;;
                3) deletar_filme ;;
                4) echo "Voltando ao menu principal..." ;;
                *) echo "Opção inválida" ;;
            esac
            ;;
        3)
            echo "Menu de aluguéis:"
            echo "1. Listar aluguéis"
            echo "2. Criar novo aluguel"
            echo "3. Finalizar aluguel"
            echo "4. Voltar"

            read -r opcao_aluguel

            case $opcao_aluguel in
                1) listar_alugueis ;;
                2) criar_aluguel ;;
                3) finalizar_aluguel ;;
                4) echo "Voltando ao menu principal..." ;;
                *) echo "Opção inválida" ;;
            esac
            ;;
        4)
            echo "Menu de relatórios:"
            echo "1. Listar filmes com mais de 10 anos"
            echo "2. Listar histórico de aluguéis"
            echo "3. Listar filmes alugados atualmente"
            echo "4. Voltar"

            read -r opcao_relatorio

            case $opcao_relatorio in
                1) listar_filmes_mais_de_10_anos ;;
                2) listar_historico_alugueis ;;
                3) listar_filmes_alugados_atualmente ;;
                4) echo "Voltando ao menu principal..." ;;
                *) echo "Opção inválida" ;;
            esac
            ;;
        5)
            echo "Saindo..."
            break
            ;;
        *) echo "Opção inválida" ;;
    esac

    echo ""
done
