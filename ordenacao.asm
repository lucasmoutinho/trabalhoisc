.data
	array1: .word 20
	prompt: .asciiz "Informe os elementos do vetor: "
	message: .asciiz "Fim loop"
.text

main:  
	li $v0, 4 #mensagem para entrada:
	la $a0, prompt
	syscall 
	addi $t0, $zero, 0 #zerando a variavel de controle do loop:
	
while: #lopp:
	bgt $t0, 16, continue #condicao
	li $v0, 5 #Input
	syscall #tacando input em v0:
	move $t7, $v0 #colando input no vetor:
	sw $t7, array1($t0) #incremento loop:
	addi $t0, $t0, 4
	j while
	
continue: 
	
	addi $t3, $zero, 0
	j while2
	
while2:
	bgt $t3, 16, continue2 #menor:
	addi $t0, $t3, 0
	addi $t2, $t0, 0
		
while3: #condicao while
	bgt $t0, 16, continue3 #incremento
	addi $t0, $t0, 4 #compara arrays:
	lw $t5, array1($t0)
	lw  $t6, array1($t2)
	blt $t5, $t6, posicaomenor	
	j while3
			
posicaomenor:
	addi $t2, $t0, 0
				
continue3: #fim menor
	lw $t9, array1($t3) #troca:
	lw $t8, array1($t2)
	sw $t9, array1($t2)
	sw $t8, array1($t3) #fim troca
	addi $t3, $t3, 4
	j while2	
		
continue2:	
	addi $t0, $zero, 0
		
while4:
	bgt $t0, 16, exit4
	lw $t1, array1($t0)
	li $v0, 1
	addi $a0, $t1, 0
	syscall
	addi $t0, $t0, 4
	j while4
	
exit4:
	li $v0, 10
	syscall

