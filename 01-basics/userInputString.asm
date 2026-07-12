.data
	prompt: .asciiz "Enter your name: "
	message: .asciiz "Hello, "
	name: .space 20 # variable to hold the user input (20 bytes)
.text
	# print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	# get user string input
	li $v0, 8 # code to get string inputs
	la $a0, name # tell program where to store the input
	li $a1, 20 # tell the program th max bytes to accept
	syscall
	
	# print user input
	li $v0, 4
	la $a0, message
	syscall
	li $v0, 4
	la $a0, name
	syscall
