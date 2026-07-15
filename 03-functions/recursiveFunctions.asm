.data
	prompt: .asciiz "Enter a positive integer: "
	errorMessage: .asciiz "Please input a number greater than or equal to zero"
	answer: .asciiz "Its factorial is: "

.text
	main:
		# as user input
		jal askInput
		
		# store user input
		move $a0, $v0 # this is our n
		
		# call the function
		jal factorial
		
		# print result
		li $v0, 4
		la $a0, answer
		syscall
		li $v0, 1
		move $a0, $v1
		syscall
		
		j exitProgram
	
	# a0 - the n
	# v1 - result
	factorial:
		addi $sp, $sp, -8 # allocate two words (the n and the return address)
		
		sw $ra, 0($sp)  # store the return address of the caller (here it would be the one that was called before the current)
		sw $a0, 4($sp) # store the current n value
		
		slti $t1, $a0, 1 # if the n is less than 1, set v1 to 1
		beq $t1, $zero, recurse # if t1 is not zero, call recurse
		
		# this code will only execute if t1 = 1 i.e. when the n less than 1
		addi $v1, $zero, 1 # set v1 to 1 (base case)
		addi $sp, $sp, 8 # pop the unused stack
		jr $ra # go back to the most recent function call
		
	recurse:
		addi $a0, $a0, -1
		
		jal factorial
		
		lw $a0, 4($sp) # retrieve back the n
		lw $ra, 0($sp) # retrieve back the return address
		addi $sp, $sp, 8 # pop the stack
		
		# now multiply n*((n-1)!)
		
		# at this point v1 has the value of (n-1)!
		mul $v1, $a0, $v1
		
		jr $ra
		
	# a helper function to validate user input
	askInput:
		# ask user input
		li $v0, 4
		la $a0, prompt
		syscall
		li $v0, 5
		syscall
		
		while:
			bgt $v0, -1, exit
			
			li $v0, 4
			la $a0, errorMessage
			syscall
			
			li $v0, 11
			la $a0, '\n'
			syscall
			
			li $v0, 4
			la $a0, prompt
			syscall
			li $v0, 5
			syscall
			
			j while
			
		exit:
			jr $ra
			
	
	exitProgram:
		li $v0, 10
		syscall