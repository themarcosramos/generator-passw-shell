# Gerador de Password

Este projeto implementa um gerador de senhas aleatórias utilizando Shell Script. A senha gerada inclui caracteres minúsculos, maiúsculos, números e símbolos especiais, com a possibilidade de personalizar o comprimento da senha entre 8 e 32 caracteres.

## Tecnologias Utilizadas
- Shell Script (Bash)

## Como Executar o Projeto

1. **Dê permissão de execução ao script**:
   ```sh
   chmod +x gerador_senha.sh
   ```

2. **Execute a aplicação**:
   ```sh
   ./gerador_senha.sh
   ```

3. **A aplicação pedirá para inserir o número de caracteres desejado para a senha. O número deve ser entre 8 e 32 caracteres.**

4. **A senha gerada será exibida no terminal.**

## Como Funciona

O programa solicita ao usuário a quantidade de caracteres para a senha, validando se o valor está entre 8 e 32. Em seguida, gera uma senha com os seguintes critérios:
- Pelo menos 1 caractere minúsculo.
- Pelo menos 1 caractere maiúsculo.
- Pelo menos 1 caractere numérico.
- Pelo menos 1 caractere especial (como `!@#$%^&*`).
- O restante dos caracteres é aleatório, escolhido de uma lista de caracteres válidos.

A senha gerada é embaralhada para garantir que os caracteres obrigatórios não fiquem em posições fixas.

## Exemplo de Uso

1. O programa solicitará: **"Quantos caracteres você deseja para a senha?"**
2. O usuário insere um número, por exemplo: **12**.
3. A senha gerada será exibida, por exemplo:
   ```
   Sua senha gerada é:
   X1!vG7*bQz
   ```

## Melhorias Futuras
- Adicionar a opção de personalizar os tipos de caracteres incluídos na senha.
- Implementar um menu interativo para facilitar a personalização.
- Adicionar a opção de salvar senhas geradas em um arquivo seguro.

## Licença
Este projeto está sob a licença MIT.

