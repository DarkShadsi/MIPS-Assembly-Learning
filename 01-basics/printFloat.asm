.data
	PI: .float 3.14 # how we declare a float

.text
	li $v0, 2 # 2 is the code for printing a float. Remember, integer is 1, and string is 4
	lwc1 $f12, PI # You use lwc1 because you are loading a floating-point constant (PI) and 
	syscall		# it must reside in a floating-point register ($f12) for the float-printing syscall to find it.
	
