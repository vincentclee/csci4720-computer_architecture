#QtSpim
#Version: 9.1.9
#Compiled for: redhat-linux-gnu (x86_64)

#Author: Vincent Lee
#Filename: copy.s
#Assignment 6
#2.33.1 a

.data
lista:	.word 8, 3, 5, 1, 7, 6, 2, 9, 4
listb:	.word 2, 9, 4, 6, 3, 8, 5, 1, 7
n:	.word 9

##registers##
#t0 i
#t1 array a index
#t2 array b index
#t3 index * int 4 bytes
#t4 int at index

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

	sll $t3, $t0, 2 #multiply i by 4

	add $t2, $t3, $a1 #add start of listb
	add $t1, $t3, $a0 #add start of lista
	
	lw $t4, 0($t2) #get listb[i]
	sw $t4, 0($t1) #set lista[i] with listb[i]

	addi $t0, $t0, 1 #increment counter

	j loop #go back to loop

return:
	jr $ra #go back to main function
