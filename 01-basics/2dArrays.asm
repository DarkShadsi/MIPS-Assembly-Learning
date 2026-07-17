.data
	prompt1: .asciiz "Enter number of rows: "
	prompt2: .asciiz "Enter number of columns: "
	prompt3: .asciiz "Input the elements (it will be stored L-R, T-B)\n"
	prompt4: .asciiz "Enter number: "
	message: .asciiz "Here is your array:\n"

.text
	# - Note: in mips we only have linear memory so we have to do the math ourselves to assign the memory address
	# - We have two orders to store the 2d array elements: row-major and columns-major order
	# - Row-major: addr = baseAddr + (((rowIndex*totColumns) + columnIndex) * elementSize)
	
	main:
		# ask the array dimensions then initialize
		jal initArr
		
		# prompt the user to input the elements
		jal askInput
		
		# print the array
		jal printArr
		
		li $v0, 10
		syscall
		
	initArr:
		li $v0, 4
		la $a0, prompt1
		syscall
		li $v0, 5
		syscall
		move $s1, $v0
		
		li $v0, 4
		la $a0, prompt2
		syscall
		li $v0, 5
		syscall
		move $s2, $v0
		
		# compute the size
		mul $t0, $s1, $s2 # t0 = row*column
		sll $a0, $t0, 2 # shift two bits to the left: it is the same as multiplying by 4. It a0 holds the total size needed in bytes
		
		li $v0, 9 # syscall 9: sbrk, allocate the space
		syscall
		
		move $s0, $v0 # s0 is the base address of the array
		
		jr $ra
	
	askInput:
		li $v0, 4
		la $a0, prompt3
		syscall
		
		addi $t0, $zero, 0 # rowIndex
		addi $t1, $zero, 0 # column index
		addi $t2, $zero, 0 # iteration counter
		mul $t3, $s1, $s2 # max iterations (total num.of elements)
		
		inputWhile:
			beq $t2, $t3, return
			
			# prompt user
			li $v0, 4
			la $a0, prompt4
			syscall
			li $v0, 5
			syscall
			
			# calculate the address
			mul $t4, $t0, $s2 # rowIndex*totColumns
			add $t4, $t4, $t1 # (rowIndex*totColumns) + columnIndex
			sll $t4, $t4, 2 # shift two positions to the  left (index * bytes)
			add $t4, $t4, $s0 # base address + the size
			
			# store the input to the calculated address
			sw $v0, 0($t4)
			
			# increment counter
			addi $t2, $t2, 1 # iteration counter
			
			# - this updates our rowIndex and column index
			# - when we divide the iteration counter by the total columns, we can know which index we
			# - Ex: at t2 = 5, when our totColumns = 3, we know we are at row 1 column 2
			div $t2, $s2
			mflo $t0
			mfhi $t1
			
			j inputWhile
			
	printArr:
		li $v0, 4
		la $a0, message
		syscall
		
		addi $t0, $zero, 0 # rowIndex
		addi $t1, $zero, 0 # column index
		addi $t2, $zero, 0 # iteration counter
		mul $t3, $s1, $s2 # max iterations (total num.of elements)
		
		printWhile:
			beq $t2, $t3, return
			
			# calculate the address
			mul $t4, $t0, $s2 # rowIndex*totColumns
			add $t4, $t4, $t1 # (rowIndex*totColumns) + columnIndex
			sll $t4, $t4, 2 # shift two positions to the  left (index * bytes)
			add $t4, $t4, $s0 # base address + the size
			
			# retrieve the element
			lw $v0, 0($t4)
			move $a0, $v0
			
			# print the element
			li $v0, 1
			syscall
			
			# print space
			li $v0, 11
			li $a0, ' '
			syscall
			
			# check if we need to print a new line
			addi $t5, $t1, 1 # adds 1 to the current columnIndex to see if this is the last element of the row
			beq $t5, $s2, printNewLine # if we are about to jump to new row print a new line
			j skipNewLine
			
			printNewLine:
				li $v0, 11
				li $a0, '\n'
				syscall
				
			skipNewLine:
				# increment counter
				addi $t2, $t2, 1 # iteration counter
			
				# - this updates our rowIndex and column index
				# - when we divide the iteration counter by the total columns, we can know which index we
				# - Ex: at t2 = 5, when our totColumns = 3, we know we are at row 1 column 2
				div $t2, $s2
				mflo $t0
				mfhi $t1
			
				j printWhile
	
	return:
		jr $ra
	
	
	# I use this list to help me track the registers I am using
	# :: s0 - base address of the array
	# :: s1 - total rows
	# :: s2 - total columns
	# :: t0 - rowIndex
	# :: t1 - columnIndex
	# :: t2 - iteration counter
	# :: t3 - total number of elements
	# :: t4 - address