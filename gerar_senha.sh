#!/bin/bash

# Função para gerar uma senha segura
generate_password() {
    local length=$1
    local lower_case="abcdefghijklmnopqrstuvwxyz"
    local upper_case="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local numbers="0123456789"
    local special="!@#$%^&*()+?><:{}[]"

    local all_chars="${lower_case}${upper_case}${numbers}${special}"

    # Garantindo pelo menos um de cada tipo necessário
    local password
    password+=${lower_case:RANDOM%${#lower_case}:1}
    password+=${upper_case:RANDOM%${#upper_case}:1}
    password+=${numbers:RANDOM%${#numbers}:1}
    password+=${special:RANDOM%${#special}:1}

    # Preenchendo o restante da senha com caracteres aleatórios
    for ((i=${#password}; i<length; i++)); do
        password+=${all_chars:RANDOM%${#all_chars}:1}
    done

    # Embaralhando a senha
    password=$(echo "$password" | fold -w1 | shuf | tr -d '\n')

    echo "$password"
}

# Solicita o tamanho da senha ao usuário
read -p "Quantos caracteres você deseja para a senha? " length

# Verifica se a entrada é um número válido e dentro do intervalo permitido
if ! [[ "$length" =~ ^[0-9]+$ ]] || [ "$length" -lt 8 ] || [ "$length" -gt 32 ]; then
    echo "Por favor, insira um número válido entre 8 e 32."
    exit 1
fi

# Gera e exibe a senha
password=$(generate_password "$length")
echo "Sua senha gerada é: $password"
