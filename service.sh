#!/bin/bash

# Função para verificar se o Docker Compose está instalado
check_docker_compose() {
    if ! command -v docker-compose &> /dev/null
    then
        echo "Docker Compose não encontrado. Instalando..."
        sudo apt-get update && sudo apt-get install -y docker-compose
        if ! command -v docker-compose &> /dev/null; then
            echo "Erro ao instalar Docker Compose. Por favor, instale manualmente."
            exit 1
        fi
    fi
}

# Função para construir as imagens e iniciar os containers
start_containers() {
    echo "Construindo as imagens..."
    docker-compose build
    echo "Iniciando os containers..."
    docker-compose up -d
    echo "Containers em execução:"
    docker ps
}

# Função para parar, remover containers, redes, volumes e imagens
stop_and_remove_all() {
    echo "Parando e removendo containers, redes, volumes e imagens..."
    docker-compose down --volumes --remove-orphans --rmi all
    echo "Containers e imagens removidos:"
    docker ps -a
}

# Verificar o número de argumentos passados
if [ $# -ne 1 ]; then
    echo "Uso: $0 [iniciar|deletar]"
    exit 1
fi

# Verifica se o Docker Compose está instalado
check_docker_compose

# Executa a ação baseada no comando fornecido
case $1 in
    iniciar)
        start_containers
        ;;
    deletar)
        stop_and_remove_all
        ;;
    *)
        echo "Comando inválido. Use 'iniciar' para iniciar os containers ou 'deletar' para removê-los."
        exit 1
        ;;
esac