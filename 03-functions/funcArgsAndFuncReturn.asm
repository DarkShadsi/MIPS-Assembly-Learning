.data

.text
	# Note: By conventions, we use $a registers to pass arguments
	# Note: By conventions, $v registers are used for return values
	main:
		# load arguments
		addi $a1, $zero, 50
		addi $a2, $zero, 100
		
		jal addNumbers
		
		li $v0, 1
		move $a0, $v1
		syscall
		
	
	# Tell the system that the program is done
	li $v0, 10
	syscall
	
	# receives the arguments $a1 and $a2 and then return the variable $v1
	addNumbers:
		add $v1, $a1, $a2
		
		jr $ra