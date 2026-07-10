.data
	message: .asciiz "Hello, World!"
	name: .asciiz "\nI am darkshadsi!"
.text
	# Remember: A label is just a name with a colon"
	
	# main procedure
	main:
		jal displayMessage # jump to the procedure 'displayMessage'
		
		# print name
		li $v0, 4
		la $a0, name
		syscall
		
	
	# Tell the system that the program is done
	li $v0, 10
	syscall
	
	# a procedure that prints a message
	displayMessage:
		li $v0, 4
		la $a0, message
		syscall
		
		jr $ra # return back to the caller
