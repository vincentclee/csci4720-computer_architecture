#QtSpim
#Version: 9.1.9
#Compiled for: redhat-linux-gnu (x86_64)

#Author: Vincent Lee
#Filename: program1.s
#Assignment 5
#Program 1

.data
p1:	.asciiz "Enter string: "
p2:	.asciiz "Enter character: "
p3:	.asciiz "Character "
p33:	.asciiz " occurs in string "
p333:	.asciiz " "
p3333:	.asciiz " times"
p4:	.asciiz "\n"
p5:	.asciiz "NOTE: This program is case sensitive.\n"

s1:	.space 50	#string input

##registers##
#t0 character
#t1 pointer
#t2 counter

##syscall##
#1 print_int 		$a0 = integer to print
#4 print_string 	$a0 = address of null-terminated string to print
#8 read_string 		$a0 = address of input buffer
#			$a1 = maximum number of characters to read
#11 print_character 	$a0 = character to print
#12 read_character 	$v0 contains character read

.text
main:
	#print out prompt 5 - "NOTE: This program is case sensitive."
	la $a0, p5
	li $v0, 4
	syscall

	#print out prompt 1 - "Enter string: "
	la $a0, p1
	li $v0, 4
	syscall
	
	#get string - s1
	la $a0, s1
	li $a1, 50
	li $v0, 8
	syscall

	#print out prompt 2 - "Enter character: "
	la $a0, p2
	li $v0, 4
	syscall

	#get character
	li $v0, 12
	syscall
	move $t0, $v0

	#print out space new line - "\n"
	la $a0, p4
	li $v0, 4
	syscall

	#main logic
	la $t1, s1 #load address of the string into $t1
	li $a3, '\n' #new line character
loop:
	lb $a0, 0($t1) #load byte with pointer $t1
	beq $a0, $a3, exit #if character is new line goto exit
	beq $a0, $zero, exit #exit if character is end of string
	
	bne $a0, $t0, else #if character in string is same as character increment $t2
	addi $t2, $t2, 1
else:
	addi $t1, $t1, 1
	j loop #jump back to loop
	#end main logic

exit:
	#print out prompt 3 - "Character "
	la $a0, p3
	li $v0, 4
	syscall

	#print out character
	move $a0, $t0
	li $v0, 11
	syscall

	#print out prompt 33 - " occurs in string "
	la $a0, p33
	li $v0, 4
	syscall

	#print out string
	la $t1, s1 #load address of the string into $t1
	li $a3, '\n' #new line character
loop1:
	lb $a0, 0($t1) #load byte with pointer $t1
	beq $a0, $a3, exit1 #if character is new line goto exit1
	beq $a0, $zero, exit1 #exit if character is end of string
	li $v0, 11 #print char instruction
	syscall

	addi $t1, $t1, 1 #increment pointer
	j loop1 #jump back to loop1
	#end print out string

exit1:
	#print out prompt 333 - " "
	la $a0, p333
	li $v0, 4
	syscall

	#print out counter
	move $a0, $t2
	li $v0, 1
	syscall

	#print out prompt 3333 - " times"
	la $a0, p3333
	li $v0, 4
	syscall

	#exit system call
	li $v0, 10
	syscall
