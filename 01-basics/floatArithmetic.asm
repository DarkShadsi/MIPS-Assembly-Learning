.data
	float1: .float 3.14
	float2: .float 2.71
	double1: .double 3.141592653589793
	double2: .double 1.11

.text
	# load the floats into registers using lwc1 (load word coprocessor 1)
	lwc1 $f1, float1
	lwc1 $f2, float2
	
	add.s $f12, $f1, $f2 # instruction to add floating points
	
	li $v0, 2
	syscall
	
	# print a newline for readability
	li $a0, '\n'
	li $v0, 11 # code to print a single character
	syscall 
	
	# load the doubles using ldc1 (load double coprocessor 1)
	# Note: store doubles in even registers because they occupy two registers
	
	ldc1 $f4, double1
	ldc1 $f6, double2
	
	sub.d $f12, $f4, $f6 # instruction to subtract doubles
	
	li $v0, 3
	syscall
	
	