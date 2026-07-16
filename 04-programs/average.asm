# - A simple program that takes numbers from a user and then computes the average
.data
	prompt1: .asciiz "Enter how many number: "
	prompt2: .asciiz "Enter number: "
	averageMessage: .asciiz "The average is: "
	zeroFloat: .float 0.0 # we will use this for initializing float values

.text
	main:
		# ask how many numbers to input
		li $v0, 4
		la $a0, prompt1
		syscall
		li $v0, 5
		syscall
		move $s0, $v0 # store the user input
		
		# allocate the memory for the array
		mul $a0, $s0, 4 # 4*n bytes
		li $v0, 9 # syscall 9 = sbrk
		syscall
		move $s1, $v0 # store the base address
		
		# ask the numbers
		jal inputNums
		
		# add the numbers
		jal addNums
		
		# calculate average
		mtc1 $s0, $f0 # move the integer fron cpu into coprocessor 1 to allow float operations
		cvt.s.w $f0, $f0 # convert a word(integer) into single precision(float)
		div.s $f12, $f1, $f0
		
		# print the result
		li $v0, 4
		la $a0, averageMessage
		syscall
		li $v0, 2
		syscall
	
		li $v0, 10
		syscall
		
	inputNums:
		addi $t0, $zero, 0 # counter (i)
		add $t1, $s1, $zero # moving address pointer
		inputWhile:
			beq $t0, $s0, return
			
			# ask user input
			li $v0, 4
			la $a0, prompt2
			syscall
			li $v0, 6
			syscall
			
			swc1 $f0, 0($t1)
			
			addi $t1, $t1, 4 # advance to the next index
			addi, $t0, $t0, 1 # increment counter
			j inputWhile
			
	addNums:
		# initialize the 'sum variable'
		lwc1 $f1, zeroFloat # current value is 0
		addi $t0, $zero, 0 # counter (i)
		add $t1, $s1, $zero # moving address pointer
		addWhile:
			beq $t0, $s0, return
			
			# retrieve the value at the current address
			lwc1 $f12, 0($t1)
			
			# add to the total sum
			add.s $f1, $f1, $f12
			
			addi $t1, $t1, 4
			addi $t0, $t0, 1
			
			j addWhile
	
	return:
		jr $ra
	
	# For my own sake, I will put a list here to track what my registers contain
	# :: s0 - (n) the count of numbers to add
	# :: s1 - base address of the array
	# :: f1 - sum of all numbers