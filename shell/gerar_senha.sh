#!/usr/bin/env bash
#
# gerador_de_senhas.sh - Script para geração de senhas seguras
#
# Site:       https://github.com/themarcosramos/generator-passw-shell
# Autor:      Marcos Ramos
# Manutenção: Marcos Ramos
#
# ------------------------------------------------------------------------ #
#  Este projeto implementa um gerador de senhas aleatórias utilizando Shell Script.
# 
#
#  Exemplos:
#      $ ./gerador_de_senhas.sh
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 06/10/2023, Seu Nome:
#       
# ------------------------------------------------------------------------ #
# Testado em:
#     bash 5.1.16
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #


# ------------------------------- FUNÇÃO PARA GERAR SENHA ----------------------------------------- #
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


# ------------------------------- SOLICITANDO O TAMANHO DA SENHA ----------------------------------------- #

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

# ------------------------------- GERANDO E EXIBINDO A SENHA ----------------------------------------- #
echo "Sua senha gerada é: $password"
