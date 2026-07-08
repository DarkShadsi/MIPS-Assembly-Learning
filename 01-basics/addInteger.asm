.data
	number1: .word 5
	number2: .word 10

.text
	# load the variables to the register
	lw $t0, number1($zero)
	lw $t1, number2($zero)
	
	add $t2, $t0, $t1 #t2 = t0 + t1
	
	li $v0, 1 # print an integer
	move $a0, $t2 # we need to move t2 value to a0 because that is where syscall will look
	syscall
	