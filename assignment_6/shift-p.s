#QtSpim
#Version: 9.1.9
#Compiled for: redhat-linux-gnu (x86_64)

#Author: Vincent Lee
#Filename: shift-p.s
#Assignment 6
#2.33.3 b

.data
lista:	.word 8, 3, 5, 1, 7, 6, 2, 9, 4
n:	.word 9

##registers##
#t0 i
#t1 int

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

	lw $t1, 4($a0) #get *(lista+1)
	sw $t1, 0($a0) #set *(lista) with *(lista+1)

	addi $a0, $a0, 4 #increment pointer
	addi $t0, $t0, 1 #increment counter

	j loop #go back to loop

return:
	jr $ra #go back to main function
