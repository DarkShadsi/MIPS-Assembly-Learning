.data
	prompt1: .asciiz "Enter first integer: "
	prompt2: .asciiz "Enter second integer: "
	eMessage: .asciiz "The numbers were equal."
	dMessage: .asciiz "The numbers were different."

.text
	main:
		# get number 1
		li $v0, 4
		la $a0, prompt1
		syscall
		li $v0, 5
		syscall
		move $t0, $v0
	
		# get number 2
		li $v0, 4
		la $a0, prompt2
		syscall
		li $v0, 5
		syscall
		move $t1, $v0
		
		# - beq stands for branch if equal: it jumps to a specific label if the condition is true,
		# - else, it executes the code below it
		# - similar method is the bne that stands for branch if not equal: its idea is the same as beq
		beq $t0, $t1, equalNumbers
		b diffNumbers	# - b is branch: it unconditionally jumps to the specific label
				# - here, it will only brnach to diffNumbers if beq is false
				
	# - Note: We need to tell the equalNumbers label to jump to exitProgram label because mips does not actually care
	# - about label, if we don't when equalNumbers is called, it will execute everything including those below it like
	# - the diffNumbers label. On the other hand we do not have to do that for diffNumbers label because it will naturally
	# - go down to exitProgram anyway, but if we do not want it to exit the program yet, weshoukd add a jump to.
		
	# branch to be called
	equalNumbers:
		li $v0, 4
		la $a0, eMessage
		syscall
		
		j exitProgram # jumps to a specific label
		
	diffNumbers:
		li $v0, 4
		la $a0, dMessage
		syscall
		
	exitProgram:	
		# tell the end of the program	
		li $v0, 10
		syscall