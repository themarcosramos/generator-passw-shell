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
    password="$(
        echo -n "${lower_case:RANDOM%${#lower_case}:1}"
        echo -n "${upper_case:RANDOM%${#upper_case}:1}"
        echo -n "${numbers:RANDOM%${#numbers}:1}"
        echo -n "${special:RANDOM%${#special}:1}"
        tr -dc "$all_chars" < /dev/urandom | fold -w1 | head -c "$((length - 4))"
    )"

    # Embaralhando a senha
    password=$(echo "$password" | fold -w1 | shuf | tr -d '\n')

    echo "$password"
}

# Loop para garantir que o usuário informe um número válido
while true; do
    read -p "Quantos caracteres você deseja para a senha? (Entre 8 e 32) " length

    # Verifica se a entrada é um número válido e dentro do intervalo permitido
    if [[ "$length" =~ ^[0-9]+$ ]] && [ "$length" -ge 8 ] && [ "$length" -le 32 ]; then
        break  # Se for válido, sai do loop
    fi

    echo "Erro: O comprimento da senha deve estar entre 8 e 32 caracteres. Tente novamente."
done

# Gera e exibe a senha
password=$(generate_password "$length")
echo "Sua senha gerada é: $password"
