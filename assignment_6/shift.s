#QtSpim
#Version: 9.1.9
#Compiled for: redhat-linux-gnu (x86_64)

#Author: Vincent Lee
#Filename: shift.s
#Assignment 6
#2.33.1 b

.data
lista:	.word 8, 3, 5, 1, 7, 6, 2, 9, 4
n:	.word 9

##registers##
#t0 i
#t1 index * int 4 bytes
#t2 int at index

#arguments##
#a0 array a
#a1 n

.text
main:
	j shift #call shift function

	#exit system call
	li $v0, 10
	syscall


shift:
	move $t0, $zero #set i to 0

	la $a0, lista #list a
	lw $a1, n #n

	addi $a1, -1 #n-1

loop:
	beq $t0, $a1, return #if i != n-1

	sll $t1, $t0, 2 #multiply i by 4
	add $t1, $t1, $a0 #add start of lista

	lw $t2, 4($t1) #get lista[i+1]
	sw $t2, 0($t1) #set lista[i] with lista[i+1]

	addi $t0, $t0, 1 #increment counter

	j loop #go back to loop

return:
	jr $ra #go back to main function
