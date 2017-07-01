.data
	array1: .word 20
	prompt: .asciiz "Informe os elementos do vetor:\n"
	message: .asciiz "Vetor ordenado: "
	space: .asciiz " "
	endline: .asciiz "\n"
.text

# $t7 = elemento[i] do vetor
# $t0 = indice i (leitura do vetor)
# $t1 = indice k (percorre todo o vetor)
# $t2 = indice m (indice menor)
# $t4 = indice k' (percorre array no menor)
# $t5 = elemento[k'] do vetor
# $t6 = elemento[m] do vetor
# $t8 = elemento[k] do vetor

main:  
	li $v0, 4 #imprime prompt
	la $a0, prompt
	syscall 
	
	addi $t0, $zero, 0 # i = 0
	
input: 
	bgt $t0, 16, continue # if i > 16
	
	li $v0, 5 #Input
	syscall #tacando input em v0:
	
	move $t7, $v0 #colando input no vetor:
	sw $t7, array1($t0) #$t7 = elemento do vetor
	addi $t0, $t0, 4 # i = i + 4:
	j input
	
continue: 
	addi $t1, $zero, 0 # k = 0
	
ordena: 
	bgt $t1, 12, continue2 # if k > 12
	addi $t2, $t1, 0 # m = k
	addi $t4, $t1, 4 # k' = k + 4
		
menor:
	bgt $t4, 16, swap # if k' > 16
	lw $t5, array1($t4) # array[k']
	lw  $t6, array1($t2) # array[m]
	blt $t5, $t6, posicaomenor # if array[k'] < array[m]
	j incrementa
			
posicaomenor:
	addi $t2, $t4, 0 # m = k'
	j incrementa
	
incrementa:
	addi $t4, $t4, 4 # k' = k' + 4:
	j menor
				
swap:
	lw $t5, array1($t1) # array[k]
	lw $t6, array1($t2) # array[m]
	
	sw $t6, array1($t1) # array[k] = array[m]
	sw $t5, array1($t2) # array[m] = array[k]
	addi $t1, $t1, 4 # k = k + 4
	j ordena	
		
continue2:	
	li $v0, 4 #imprime message:
	la $a0, message
	syscall
	
	addi $t0, $zero, 0 # i = 0
		
imprime:
	bgt $t0, 16, end # if i > 16
	lw $t7, array1($t0) #array[i]
	li $v0, 1
	addi $a0, $t7, 0
	syscall
	
	li $v0, 4 #imprime space
	la $a0, space
	syscall 
	
	addi $t0, $t0, 4 # i = i + 4
	j imprime
	
end:
	li $v0, 4 #imprime endline:
	la $a0, endline
	syscall 

	li $v0, 10 #finaliza programa
	syscall