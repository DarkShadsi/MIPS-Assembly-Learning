.data
	countMessage: .asciiz "\niteration: "
	doneMessage: .asciiz "\nWhile loop is done."

.text
	main:
		addi $t0, $zero, 1
		
		# Note: It is required to have a while label and an exit label for while loops
		while:
			bgt $t0, 10, exit # jump to exit when t0 value is 10
			
			li $v0, 4
			la $a0, countMessage
			syscall
			li $v0, 1
			add $a0, $t0, $zero # we add zero just s we can copy t0 value
			syscall
			
			add $t0, $t0, 1
			j while # jump back to while label as long as the condition is not satisfied
		
		exit:
			li $v0, 4
			la $a0, doneMessage
			syscall
			
			j exitProgram
			
		exitProgram:
			li $v0, 10
			syscall