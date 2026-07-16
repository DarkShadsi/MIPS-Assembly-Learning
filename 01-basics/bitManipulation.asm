.data
	prompt: .asciiz "Enter an integer: "
	prompt2: .asciiz "\nEnter bit position you want removed: "
	bitRepMessage: .asciiz "Binary representation: "
	clearedBit: .asciiz "Cleared n'th bit: "

.text
	# - This program demonstrates 'Clear Nth Bit', a bit manipulation where you remove a certain part of the binary
	# - For example: 1011 becomes 1010 when we clear the first bit
	main:
		# get user input (the number)
		li $v0, 4
		la $a0, prompt
		syscall
		li $v0, 5
		syscall
		# store user input
		move $a2, $v0 # original number: should not be modified
		addi $t0, $a2, 0 # copy the original number
		
		# print bit representation
		li $v0, 4
		la $a0, bitRepMessage
		syscall
		jal printBitRep
		
		# get user input (position)
		li $v0, 4
		la $a0, prompt2
		syscall
		li $v0, 5
		syscall
		# store user input
		addi $a1, $v0, -1
		
		# clear the n'th bit
		addi $t0, $a2, 0 # copy the original number
		jal removeBit
		
		# print the resulting bit
		li $v0, 4
		la $a0, clearedBit
		syscall
		jal printBitRep
		
		li $v0, 10
		syscall
		
	removeBit:
		# -  Idea: we make a mask with all 1's except the desired bit position
		# - Then we 'and' it with the user input 
		
		# make the mask
		li $t1, 1 # start with a single 1 in the righmost part: 0001
		sllv $t1, $t1, $a1 # shift the bits n places to the left that is the place we want to mask out: 0100
		nor $t2, $t1, $zero # 'nor' out to flip the bits: 1011. We now have the mask
		
		# 'and' the two numbers
		and $t0, $t0, $t2
		
		jr $ra
		
	printBitRep:
		addi $t1, $zero, 32 # counter: 32 iterations for 32 bits total
		addi $t4, $zero, 0 # counter: for every 4 iterations add space for readabiltiy
		
		# store the return address
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		while:
			beq $t1, $zero, exit
			
			# - check the current leftmost bit
			# - when the MSB is 1: then t0 becomes negative else it is positive
			# - example: 1011 is negative so t0 < 0, thus t2 becomes 1
			slt $t2, $t0, $zero
		
			# print the isolated bit
			li $v0, 1
			move $a0, $t2
			syscall
			
			jal printSpace
		
			# - shift the bits 1 place to the left so we update our MSB
			# - example: 1011 -> 0110 so next check will make t2 = 0 since t0 is not less than 0
			sll $t0, $t0, 1  
			
			addi $t1, $t1, -1 # decrement counter
			
			j while
		
		exit:
			# retrieve the return address
			lw $ra, 0($sp)
			addi $sp, $sp, 4
			jr $ra
			
	printSpace:
		# if the bits printed are already 4, add space else do nothing
		beq $t4, 3, print
		
		addi $t4, $t4, 1 # increment by 1
		jr $ra
		print:
			li $v0, 11
			la $a0, ' '
			syscall
			
			addi $t4, $zero, 0 # reset the counter
			jr $ra