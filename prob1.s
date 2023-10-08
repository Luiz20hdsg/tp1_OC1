.data
vetor: .word 2, 5, 8, 3

##### START MODIFIQUE AQUI START #####

tamanho_vetor: .word 4

##### END MODIFIQUE AQUI END #####

.text
la t2, vetor         # Endereço do vetor
lw t3, tamanho_vetor # Tamanho do vetor

jal x1, contador
addi x14, x0, 2 # utilizado para correção
beq x14, x10, FIM # Verifica # de pares
beq x14, x11, FIM # Verifica # de ímpares

##### START MODIFIQUE AQUI START #####
contador:
    addi s10, x1, 0
    # Inicializa os contadores
    li t0, 0         # Inicializa contador de pares (t0)
    li t1, 0         # Inicializa contador de ímpares (t1)

    # Carrega os parâmetros
    #lw t2, 0(x1)     # Endereço do vetor (t2)
    #lw t3, 4(x1)     # Tamanho do vetor (t3)

    loop:
        lw x14, 0(t2) # Carrega o próximo número do vetor
        andi x15, x14, 1 # Checa se o número é par ou ímpar (bit menos significativo)
        beqz x15, numero_impar # Se o resultado for 0 (número par), vá para numero_impar
        addi t1, t1, 1 # Incrementa contador de ímpares
        j proximo_numero

    numero_impar:
        addi t0, t0, 1 # Incrementa contador de pares
        j proximo_numero

    proximo_numero:
        addi t2, t2, 4 # Avança para o próximo número do vetor
        addi t3, t3, -1 # Decrementa o contador de elementos do vetor
        bnez t3, loop # Se ainda há números no vetor, continue o loop

    # Armazena os resultados nos registradores de retorno
    mv x10, t0         # Armazena o contador de pares em x10 (registrador de retorno para pares)
    mv x11, t1         # Armazena o contador de ímpares em x11 (registrador de retorno para ímpares)
    beq zero, zero, fim


	fim:
  		addi a0, t0, 0
        addi a1, t1, 0
  		jr s10 # retorna para a chamada da função

##### END MODIFIQUE AQUI END #####

FIM: addi x0, x0, 1
