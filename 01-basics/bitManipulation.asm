.data
	prompt: .asciiz "Enter an integer: "
	bitRepMessage: .asciiz "Binary representation: "
	clearedBit: .asciiz "Cleared bit zero: "

.text
	# - This program demonstrates 'Clear Bit Zero', a bit manipulation where you remove the LSB (the rightmost)
	# - For example: 1011 becomes 1010
	# - This makes any bit an even one because odd bits became even and even bits stays even
	main:
		# get user input
		li $v0, 4
		la $a0, prompt
		syscall
		li $v0, 5
		syscall
		
		# store user input
		move $t0, $v0
		
		# print bit representation
		li $v0, 4
		la $a0, bitRepMessage
		syscall
		jal printBitRep
		
		li $v0, 10
		syscall
		
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