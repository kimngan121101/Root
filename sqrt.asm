.data
	c1: .float 0.5
	c2: .float 0.00001
	c3: .float 0.0
.text
.globl sqrt

sqrt:
	l.s	$f7, c3
	c.lt.s	$f20, $f7
	bc1t	return_NaN
	l.s	$f5, c1
	l.s	$f6, c2
	mov.s 	$f21, $f20	# x = n
	add.s	$f3, $f3, $f3	# root
	while:
		div.s	$f4, $f20, $f21	# n / x
		add.s	$f4, $f4, $f21	# x + (n / x)
		mul.s	$f3, $f4, $f5	# root = x + (n / x)
		sub.s	$f4, $f3, $f21	# root - x
		abs.s	$f4, $f4
		c.lt.s	$f4, $f6	# if abs(root - x) < c2 goto _break
		bc1t	_break
		mov.s	$f21, $f3	# x = root
		j	while		# jump on while
	_break:
	mov.s	$f22, $f3	# return root 
	jr $ra 
	return_NaN:
	li	$v1, 1		# return 1 means NaN
	jr	$ra
