.data
	arr: .space 12 # declare the array name and the space you want to alocate, here it is 3 elements for integer (4 bytes * 3)
	spaceComma: .asciiz ", "

.text
	# - Note: for simplicity, I did not use loops to make the code easier to digest
	
	# sample integers
	addi $s0, $zero, 4
	addi $s1, $zero, 10
	addi $s2, $zero, 12
	
	# t0 will act as our index counter
	addi $t0, $zero, 0 # right now it points to the first index
	
	# stroing the values
	sw $s0, arr($t0)
		addi $t0, $t0, 4 # update to point to the second index 
	sw $s1, arr($t0)
		addi $t0, $t0, 4 # add another 4 bytes again to pint to next index  
	sw $s2, arr($t0)
	
	addi $t0, $zero, 0 # now our counter points back to the first index
	
	
	# retrieving the values
	lw $t6, arr($t0)
		addi $t0, $t0, 4 # update to point to the second index 
	lw $t7, arr($t0)
		addi $t0, $t0, 4 # add another 4 bytes again to pint to next index  
	lw $t8, arr($t0)
	
	# print the values
	li $v0, 1
	move $a0, $t6
	syscall
	li $v0, 4
	la $a0, spaceComma
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	li $v0, 4
	la $a0, spaceComma
	syscall
	
	li $v0, 1
	move $a0, $t8
	syscall
	