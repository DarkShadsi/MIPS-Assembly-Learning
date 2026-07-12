.data
	oldValueMessage: .asciiz "\nOld value: "
	incrementedValueMessage: .asciiz "Incremented Value: "
.text
	# Note: The callee cannot modify the value of an $s register
	main: 
		addi $s0, $zero, 10
		
		jal incrementRegister
		
		# print the old value
		li $v0, 4
		la $a0, oldValueMessage
		syscall
		move $a1, $s0
		jal printValue
		
		
		
	
	# Tell the system that the program is done
	li $v0, 10
	syscall
	
	# - Note: Nested functions (functions inside a callee function) you need
	# - to know where the address to return to
	# - you do not want to go back to main but to the function that called it
		
	incrementRegister:
		addi $sp, $sp, -8 # we allocate 8 bytes since we need to store two words
		
		# saves the value in  s0 to the first location in the stack pointer
		sw $s0, 0($sp) # 0 is offset
		# saves the return address of main
		sw $ra, 4($sp)
		
		addi $s0, $s0, 30
		
		# print the new value of s0
		li $v0, 4
		la $a0, incrementedValueMessage
		syscall
		move $a1, $s0
		jal printValue
		
		# retrieve back the original value of s0 from the stack
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 4
						
		jr $ra
	
	# Helper function to print values
	printValue:
		li $v0, 1
		move $a0, $a1
		syscall
		
		jr $ra