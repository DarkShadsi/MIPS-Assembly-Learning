.data
	prompt1: .asciiz "Enter first integer: "
	prompt2: .asciiz "Enter second integer: "
	lMessage: .asciiz "The first number is less than second number."
	nLMessage: .asciiz "The first number is not less than second number."
	
.text
	main:
		# get number 1
		li $v0, 4
		la $a0, prompt1
		syscall
		li $v0, 5
		syscall
		move $t0, $v0
	
		# get number 2
		li $v0, 4
		la $a0, prompt2
		syscall
		li $v0, 5
		syscall
		move $t1, $v0
		
		# - slt stands for set less than
		# - here, s0 will hold a binary value 0 - false (strictly not less than) 1 - (less than)
		slt $s0, $t0, $t1
		
		# we then use beq (branch  if equal) to determine interpret the result
		beq $s0, 0, notLessThan
		b lessThan
		
	lessThan:
		li $v0, 4
		la $a0, lMessage
		syscall
		j exitProgram
		
	notLessThan:
		li $v0, 4
		la $a0, nLMessage
		syscall
		j exitProgram
		
	exitProgram:	
		# tell the end of the program	
		li $v0, 10
		syscall