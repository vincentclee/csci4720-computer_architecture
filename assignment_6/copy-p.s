#QtSpim
#Version: 9.1.9
#Compiled for: redhat-linux-gnu (x86_64)

#Author: Vincent Lee
#Filename: copy-p.s
#Assignment 6
#2.33.3 a

.data
lista:	.word 8, 3, 5, 1, 7, 6, 2, 9, 4
listb:	.word 2, 9, 4, 6, 3, 8, 5, 1, 7
n:	.word 9

##registers##
#t0 i
#t1 int


#arguments##
#a0 array a
#a1 array b
#a2 n

.text
main:
	j copy #call copy function

	#exit system call
	li $v0, 10
	syscall


copy:
	move $t0, $zero #set i to 0

	la $a0, lista #list a
	la $a1, listb #list b
	lw $a2, n #n

loop:
	beq $t0, $a2, return #if i != n

	lw $t1, 0($a1) #get *listb
	sw $t1, 0($a0) #set *lista with *listb


	#increment pointer
	addi $a0, $a0, 4
	addi $a1, $a1, 4

	addi $t0, $t0, 1 #increment counter

	j loop #go back to loop

return:
	jr $ra #go back to main function
