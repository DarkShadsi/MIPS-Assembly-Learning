.data
	v1Message: .asciiz "Version 1: "
	v2Message: .asciiz "\nVersion 2: "
	qoutientMessage: .asciiz "\n	Qoutient: "
	remainderMessage: .asciiz "\n	Remainder: "
	newLine: .byte '\n'

.text
	addi $t0, $zero, 30
	addi $t1, $zero, 5
	
	#============= first version ==============#
		# result is strored in s0
		div $s0, $t0, 5
		
		# print first version
		li $v0, 4 
		la $a0, v1Message
		syscall
	
		li $v0, 1
		move $a0, $s0
		syscall
	
	#=========== second version ==============#
		addi $t1, $zero, 7 # we change the divisor we get a remainder 
		
		# result is stored in the special registers LO and HI
		div $t0, $t1
	
		mflo $s0 # qoutient
		mfhi $s1 # remainder
		
		# print second version
		li $v0, 4
		la $a0, v2Message
		syscall
		
		# print qoutient		
		li $v0, 4
		la $a0, qoutientMessage
		syscall
		li $v0, 1
		move $a0, $s0
		syscall
		
		# print remainder
		li $v0, 4
		la $a0, remainderMessage
		syscall
		li $v0, 1
		move $a0, $s1
		syscall
		
	