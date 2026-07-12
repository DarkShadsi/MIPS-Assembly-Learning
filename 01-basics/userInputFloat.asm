.data
	prompt: .asciiz "Enter a float value: "	
	message: .asciiz "Your float is: "

.text
	# Note: unlike integers, floating values are not stored in v0 but to f0
	
	# print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	# get user float input
	li $v0, 6 # code for getting float inputs
	syscall
	
	# print the float
	li $v0, 4
	la $a0, message
	syscall
	li $v0, 2
	mov.s $f12, $f0
	syscall