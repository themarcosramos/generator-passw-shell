#!/usr/bin/env bash
#
# gerador_de_senhas.sh - Script para geração de senhas seguras
#
# Site:       https://github.com/themarcosramos/generator-passw-shell
# Autor:      Marcos Ramos 
# Manutenção: Marcos Ramos
#
# ------------------------------------------------------------------------ #
#  Este programa gera senhas seguras baseadas no comprimento informado pelo usuário.
#  Ele pode rodar tanto com `dialog` (se instalado) quanto sem interface gráfica.
#
#  Exemplos:
#      $ ./gerador_de_senhas.sh
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 06/10/2023, Seu Nome:
#       - Implementação inicial com interface `dialog` opcional
# ------------------------------------------------------------------------ #
# Testado em:
#     bash 5.1.16
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
DIALOG_INSTALADO=false
[ -x "$(command -v dialog)" ] && DIALOG_INSTALADO=true  # Verifica se `dialog` está instalado

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
RESET="\033[0m"

# ------------------------------- FUNÇÃO PARA GERAR SENHA ----------------------------------------- #
generate_password() {
    local length=$1
    local lower_case="abcdefghijklmnopqrstuvwxyz"
    local upper_case="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local numbers="0123456789"
    local special="!@#$%^&*()+?><:{}[]"
    
    local all_chars="${lower_case}${upper_case}${numbers}${special}"

    # Garantindo pelo menos um caractere de cada tipo
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
while true; do
    if [ "$DIALOG_INSTALADO" = true ]; then
        length=$(dialog --title "Gerador de Senha" --inputbox "Quantos caracteres deseja para a senha? (Entre 8 e 32)" 8 50 3>&1 1>&2 2>&3)
    else
        read -p "Quantos caracteres deseja para a senha? (Entre 8 e 32): " length
    fi

    # Verifica se a entrada é válida
    if [[ "$length" =~ ^[0-9]+$ ]] && [ "$length" -ge 8 ] && [ "$length" -le 32 ]; then
        break  # Sai do loop se for válido
    fi

    if [ "$DIALOG_INSTALADO" = true ]; then
        dialog --title "Erro" --msgbox "O comprimento da senha deve estar entre 8 e 32 caracteres. Tente novamente." 6 50
    else
        echo -e "${VERMELHO}Erro: O comprimento da senha deve estar entre 8 e 32 caracteres. Tente novamente.${RESET}"
    fi
done

# ------------------------------- GERANDO E EXIBINDO A SENHA ----------------------------------------- #
password=$(generate_password "$length")

if [ "$DIALOG_INSTALADO" = true ]; then
    dialog --title "Senha Gerada" --msgbox "Sua senha gerada é:\n$password" 8 50
    clear
else
    echo -e "${VERDE}Sua senha gerada é: $password${RESET}"
fi
