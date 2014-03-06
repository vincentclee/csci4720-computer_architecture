#QtSpim
#Version: 9.1.9
#Compiled for: redhat-linux-gnu (x86_64)

#Author: Vincent Lee
#Filename: program2.s
#Assignment 5
#Program 2

.data
p1:	.asciiz "Enter string: "
p2:	.asciiz "Enter character to replace: "
p3:	.asciiz "Enter character to be replaced with: "
p4:	.asciiz "Original string: "
p5:	.asciiz "Substitute "
p55:	.asciiz " -> "
p6:	.asciiz "Result string: "
p7:	.asciiz "\n"
p8:	.asciiz "NOTE: This program is case sensitive.\n"

s1:	.space 50	#string input

##registers##
#t0 character
#t1 pointer
#t2 counter
#t3 character to be replaced with

##syscall##
#1 print_int		$a0 = integer to print
#4 print_string		$a0 = address of null-terminated string to print
#8 read_string		$a0 = address of input buffer
#			$a1 = maximum number of characters to read
#11 print_character	$a0 = character to print
#12 read_character	$v0 contains character read

.text
main:
	#print out prompt 8 - "NOTE: This program is case sensitive."
	la $a0, p8
	li $v0, 4
	syscall

	#print out prompt 1 - "Enter string: "
	la $a0, p1
	li $v0, 4
	syscall
	
	#get string
	la $a0, s1
	li $a1, 50
	li $v0, 8
	syscall

	#print out prompt 2 - "Enter character to replace: "
	la $a0, p2
	li $v0, 4
	syscall

	#get character
	li $v0, 12
	syscall
	move $t0, $v0
	
	#print out space new line - "\n"
	la $a0, p7
	li $v0, 4
	syscall
	
	#print out prompt 3 - "Enter character to be replaced with: "
	la $a0, p3
	li $v0, 4
	syscall

	#get character to be replace with
	li $v0, 12
	syscall
	move $t3, $v0
	
	#print out space new line - "\n"
	la $a0, p7
	li $v0, 4
	syscall

	#print out space new line - "\n"
	la $a0, p7
	li $v0, 4
	syscall	

	#print out prompt 4 - "Original string: "
	la $a0, p4
	li $v0, 4
	syscall
	
	#print out string
	la $a0, s1
	li $v0, 4
	syscall





	#main logic
	la $t1, s1 #load address of the string into $t1
	li $a3, '\n' #new line character
loop:
	lb $a0, 0($t1) #load byte with pointer $t1
	beq $a0, $a3, exit #if character is new line goto exit
	beq $a0, $zero, exit1 #exit if character is end of string
	
	bne $a0, $t0, else #if character in string is same as character switch byte with one in $t3, and increment $t2
	sb $t3, 0($t1) #substitute character
	addi $t2, $t2, 1
else:
	addi $t1, $t1, 1
	j loop #jump back to loop
	#end main logic



exit1:
	#print out space new line - "\n"
	la $a0, p7
	li $v0, 4
	syscall

exit:
	#print out prompt 5 - "Substitute "
	la $a0, p5
	li $v0, 4
	syscall

	#print out character
	move $a0, $t0
	li $v0, 11
	syscall

	#print out prompt 55 - " -> "
	la $a0, p55
	li $v0, 4
	syscall

	#print out character to be replaced
	move $a0, $t3
	li $v0, 11
	syscall

	#print out space new line
	la $a0, p7
	li $v0, 4
	syscall	

	#print out prompt 6 - "Result string: "
	la $a0, p6
	li $v0, 4
	syscall

	#print out modified string
	la $a0, s1
	li $v0, 4
	syscall

	#exit system call
	li $v0, 10
	syscall
