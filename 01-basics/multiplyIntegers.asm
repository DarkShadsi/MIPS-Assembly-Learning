.data
	

.text
	# you can do multiplication in three different ways
	# 1. mul [destination], [number1], [number2] -> best for small numbers, ignore overflow and keep only the lower 32 bits
	# 2. mult [number1], [number2]
	# mflo [register] -> move the lower 32 bits from 'lo' to the register
	# mfhi [register] -> move the upper 32 bits from 'hi' to the register
	# 3. sll [destination], [number1], [shift] -> best for multiplying by powers of 2; Shift Left Logical by 2 bits.)
	
	#================== mul ==============================#
	
	addi $s0, $zero, 10 # adding a constant value to a register without needing the use of RAM 
	addi $s1, $zero, 4
	
	mul $t0, $s0, $s1
	
	li $v0, 1
	move $a0, $t0
	#syscall
	
	#==================== mult ============================#
	
	addi $t0, $zero, 20000000
	addi $t1, $zero, 4
	
	mult $t0, $t1
	
	mflo $s0
	mfhi $s1
	
	# hi result
	li $v0, 1
	move $a0, $s1
	# syscall
	
	# low result
	li $v0, 1
	move $a0, $s0
	# syscall
	
	#================ sll ============================#
	# 5*8
	
	addi $t0, $zero, 5
	
	 sll  $a0, $t0, 3 # because 2^3 = 8
	 
	 li $v0, 1
	 #syscall