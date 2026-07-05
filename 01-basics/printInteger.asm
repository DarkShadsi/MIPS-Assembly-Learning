.data
	age: .word 23 #this a word or intiger

.text
	li $v0, 1
	lw $a0, age #instead of load address (la) we use load word (lw)
	syscall