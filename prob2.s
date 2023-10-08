.data
vetor: .word 200, 190, 340, 100 # Exemplo de salários

##### START MODIFIQUE AQUI START #####
limiar: .word 200 # Limiar desejado
reajuste: .word 50
porcentagem: .word 100
tam: .word 4 # Tamanho do vetor
##### END MODIFIQUE AQUI END #####

.text
jal ra, main

##### START INSTRUÇÃO DE CORREÇÃO/VERIFICAÇÃO #####
#nessa comfiguração do exemplo aplenas 3 salarios vão ficar acima do limiar no reajuste salarial
addi a4, x0, 3 # Configurando a quantidade de salários acima do limiar de 200 são 3.
beq a4, t0, FIM # Verifica a quantidade de salários acima do limiar.
##### END INSTRUÇÃO DE CORREÇÃO/VERIFICAÇÃO #####

main:
    addi sp, sp, -4     # Aloca espaço na pilha para salvar o endereço de retorno
    sw ra, 0(sp)        # Salva o endereço de retorno na pilha
    la a0, vetor        # Carrega o endereço do vetor para a0
    lw a1, tam          # Tamanho do vetor
    lw a2, limiar       # Carrega o limiar para a2
    lw t1, reajuste
    lw a4, porcentagem
    jal ra, aplica_reajuste
    lw ra, 0(sp)        # Restaura o endereço de retorno da pilha
    addi sp, sp, 4      # Libera o espaço na pilha
    jr ra

aplica_reajuste:
    li t2, 0            # Inicializa o contador de salários acima do limiar para t2
    li t3, 0            # Inicializa o índice do vetor para t3
    li t5, 0               # Inicialização de variavel auxiliar

loop:
    lw t4, 0(a0)        # Carrega o próximo salário do vetor
    addi t5, zero, 0
    add t5, t5, t4 
    mul t5, t5, t1      # multiplica o valor do salario pelo reajuste
    div t5, t5, a4      # calcula a porcentagem do reajuste
    add t4, t4, t5
    sw t4, 0(a0)        # armazena o salario reajustado
    blt t4, a2, salario_abaixo_limiar # Se o salário for menor que o limiar, vá para salario_abaixo_limiar
    addi t2, t2, 1      # Incrementa o contador de salários acima do limiar

salario_abaixo_limiar:
    addi t3, t3, 1      # Avança para o próximo índice do vetor
    addi a0, a0, 4      # Avança para o próximo salário no vetor
    blt t3, a1, loop    # Se ainda há salários no vetor, continue o loop

    mv t0, t2           # Armazena a quantidade de salários acima do limiar em t0 (registrador de retorno)

    jr ra

FIM: addi x0, x0, 1
