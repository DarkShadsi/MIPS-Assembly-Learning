.data
	arr: .space 20 # an array with 5 integer elements
	commaSpace: .asciiz ", "

.text
	# This program will demomstrate how we can make use of loops in accessing an array
	
	main:
		jal addElements
			
		jal printElements
		
		j exitProgram
		
	# Note: We cannot have two while loops of the same name.		
	addElements:
		addi $t0, $zero, 0 # counter
		addWhile:
			beq $t0, 5, exitAdd # while t0 is not equal to 4, add elements to the array else return to main
			
			mul $t1, $t0, 4 # t1 will manage the current index
			addi $t0, $t0, 1 # increment the counter by 1
			
			sw $t0, arr($t1) # insert the value of t0 to the array specified by the index on t1
			
			j addWhile
		exitAdd:
			jr $ra
			
	printElements:
		addi $t0, $zero, 0 # counter
		printWhile:
			beq $t0, 5, exitPrint # while t0 is not equal to 4, print the elements in the array else return to main
			
			mul $t1, $t0, 4 # t1 will manage the current index
			addi $t0, $t0, 1 # increment the counter by 1
			
			lw $a0, arr($t1) # load the value on the current index into a0
			
			# print the retrieved value
			li $v0, 1
			syscall
			li $v0, 4
			la $a0, commaSpace
			syscall
			
			j printWhile
		exitPrint:
			jr $ra
			
	
	exitProgram:
		li $v0, 10
		syscall
	