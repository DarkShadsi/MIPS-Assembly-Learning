.data
	prompt: .asciiz "Enter a double value: "	
	message: .asciiz "Your double is: "

.text
	# Note: doubles takes up two registers

	# print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	# get user input
	li $v0, 7 # code for getting a double value
	syscall
	
	# print the double
	li $v0, 4
	la $a0, message
	syscall
	li $v0, 3
	mov.d $f12, $f0 # moves the value from f0/f1 to f12/f13
	syscall