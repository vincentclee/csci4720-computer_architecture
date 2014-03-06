#QtSpim
#Version: 9.1.9
#Compiled for: redhat-linux-gnu (x86_64)

#Author: Vincent Lee
#Filename: program3.s
#Assignment 5
#Program 3

.data
p1:	.asciiz "Please enter a value for n: "
p2:	.asciiz "\nThe sum of the "
p22:	.asciiz " integers is "
p3:	.asciiz "\nThe minimum value is "
p4:	.asciiz "\nThe maximum value is "
p5:	.asciiz "Enter number: "

##registers##
#t0 n
#t1 sum
#t2 minimum
#t3 maximum
#t4 counter

##syscall##
#1 print_int	$a0 = integer to print
#4 print_string	$a0 = address of null-terminated string to print
#5 read_int	$v0 contains integer read

.text
main:
	#print out prompt 1 - value for n
	la $a0, p1
	li $v0, 4
	syscall
	
	#get n value
	li $v0, 5
	syscall
	move $t0, $v0 #set t0 to first number
	
	#print out prompt 5 - enter number
	la $a0, p5
	li $v0, 4
	syscall
	
	#get number
	li $v0, 5
	syscall
	move $t1, $v0 #set t1 to first number
	move $t2, $v0 #set t2 to first number
	move $t3, $v0 #set t3 to first number
	
	#incriment counter
	addi $t4, $t4, 1
	
loop:
	beq $t0, $t4, exit #branch to 'exit' if  $t0 = $t4
	
	#print out prompt 5 - enter number
	la $a0, p5
	li $v0, 4
	syscall
	
	#get number
	li $v0, 5
	syscall
	add $t1, $t1, $v0 #$t1 = $t1 + $v0
	bge $v0, $t2, else #branch to 'else' if  $v0 >= $t2
	move $t2, $v0
else:
	ble $v0, $t3, else1 #branch to 'else1' if  $v0 <= $t3
	move $t3, $v0
else1:
	
	#increment counter
	addi $t4, $t4, 1
	
	#unconditional jump to program label 'loop'
	j loop
	
	

exit:
	#print out prompt 2 - 'The sum of the '
	la $a0, p2
	li $v0, 4
	syscall

	#print out n
	li $v0, 1
	move $a0, $t0
	syscall

	#print out prompt 22 - ' integers is '
	la $a0, p22
	li $v0, 4
	syscall

	#print out sum
	li $v0, 1
	move $a0, $t1
	syscall

	#print out prompt 4 - 'The maximum value is '
	la $a0, p4
	li $v0, 4
	syscall

	#print out maximum
	li $v0, 1
	move $a0, $t3
	syscall

	#print out prompt 3 - 'The minimum value is '
	la $a0, p3
	li $v0, 4
	syscall

	#print out minimum
	li $v0, 1
	move $a0, $t2
	syscall

	#exit system call
	li $v0, 10
	syscall
