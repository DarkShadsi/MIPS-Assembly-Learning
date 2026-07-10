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
		li $v0, 1
		move $a0, $s0
		syscall
		
		
		
	
	# Tell the system that the program is done
	li $v0, 10
	syscall
	
	# A function to increase the value of a register
	incrementRegister:
		addi $sp, $sp, -4 # 'sp' stands for stack pointer
		
		# saves the value in  s0 to the first location in the stack pointer
		sw $s0, 0($sp) # 0 is offset
		
		addi $s0, $s0, 30
		
		# print the new value of s0
		li $v0, 4
		la $a0, incrementedValueMessage
		syscall
		li $v0, 1
		move $a0, $s0
		syscall
		
		jr $ra