.data
	myDouble: .double 7.202

.text	
	# loads the double from memory to coprocessor 1
	# note: always use even register numbers
	ldc1 $f2, myDouble  # will take up two spaces, f2 and f3
	
	 li $v0, 3 # 3 is the code for printing double
	 # Copy the double from $f2 to $f12 safely, since we assign
	 # the double in f2 but the syscall will try to find it in f12
	 mov.d $f12, $f2
	 syscall