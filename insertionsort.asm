.data
	array1: .word 20
	prompt: .asciiz "Informe os elementos do vetor: "
	message: .asciiz "Fim loop"
.text

# $t7 = elemento[i] do vetor
# $t0 = indice i (leitura do vetor)
# $t1 = indice k (percorre todo o vetor)
# $t2 = indice m (indice menor)
# $t4 = indice k' ou indice y (percorre array no menor)
# $t5 = elemento[k'] do vetor
# $t6 = elemento[m] do vetor

main:  
	li $v0, 4 #mensagem para entrada:
	la $a0, prompt
	syscall 
	addi $t0, $zero, 0 #zerando a variavel de controle do loop:
	
input: #lopp:
	bgt $t0, 16, continue #condicao
	li $v0, 5 #Input
	syscall #tacando input em v0:
	move $t7, $v0 #colando input no vetor:
	sw $t7, array1($t0) #$t7 = elemento do vetor
	addi $t0, $t0, 4 #incremento loop:
	j input
	
continue: 
	addi $t1, $zero, 0
	
ordena: 
	bgt $t1, 12, continue2 #menor:
	addi $t2, $t1, 0
	addi $t4, $t1, 4
		
menor: #condicao while
	bgt $t4, 16, swap #incremento
	lw $t5, array1($t4)
	lw  $t6, array1($t2)
	blt $t5, $t6, posicaomenor
	addi $t4, $t4, 4 #compara arrays:	
	j menor
			
posicaomenor:
	addi $t2, $t4, 0
				
swap: #fim menor
	lw $t5, array1($t1) #troca:
	lw $t6, array1($t2)
	sw $t6, array1($t1)
	sw $t5, array1($t2) #fim troca
	addi $t1, $t1, 4
	j ordena	
		
continue2:	
	addi $t0, $zero, 0
		
imprime:
	bgt $t0, 16, end
	lw $t7, array1($t0)
	li $v0, 1
	addi $a0, $t7, 0
	syscall
	addi $t0, $t0, 4
	j imprime
	
end:
	li $v0, 10
	syscall

