.data
	prompt: .asciiz "Enter an integer: "
	message: .asciiz "Your number is: "

.text
	# prompt user
	li $v0, 4
	la $a0, prompt
	syscall
	
	# get user input
	li $v0, 5 # code for getting integer input from the user 
	syscall
	
	# store the input to another variable
	move $t0, $v0
	
	# print the number
	li $v0, 4
	la $a0, message
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	