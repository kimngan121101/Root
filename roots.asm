.data
zero:	.float 0.0
four:	.float 4.0
two:	.float 2.0
.text
.globl root
root:
	l.s	$f1, ($sp)	# a
	l.s	$f2, 4($sp)	# b 
	l.s	$f3, 8($sp)	# c
	addi	$sp, $sp, 12
	l.s	$f4, zero	# load 0.0
	c.eq.s	$f1, $f4	# if a == 0 goto return_status3
	bc1t	return_status3
	l.s	$f5, four	# load 4.0
	mul.s	$f6, $f2, $f2	# b * b
	
	mul.s	$f7, $f1, $f3	# a * c
	mul.s	$f7, $f7, $f5	# 4 * a * c
	sub.s	$f7, $f6, $f7	# d = b * b - 4 * a * c
	abs.s	$f8, $f7	# abs(d)
	sqrt.s	$f8, $f8	# sqrt(abs(d))
	c.lt.s	$f4, $f7	# check here that if d > 0
	bc1f	else_if1
	
	sub.s	$f9, $f4, $f2	# -b
	add.s	$f10, $f9, $f8	# -b + sqart_val
	l.s	$f11, two	# load 2.0
	mul.s	$f11, $f11, $f1	# 2 * a
	div.s	$f12, $f10, $f11	# (-b + sqart_val) / 2 * a
	
	sub.s	$f10, $f9, $f8	# -b - sqart_val
	div.s	$f13, $f10, $f11	# (-b + sqart_val) / 2 * a
	
	addi	$sp, $sp, -12
	s.s	$f12, ($sp)
	s.s	$f13, 4($sp)
	sw	$0, 8($sp)	# put status 0 on stack
	jr	$ra	# return back
	
	else_if1:
	c.eq.s	$f7, $f4
	bc1f	else
	sub.s	$f9, $f4, $f2	# -b	
	l.s	$f11, two	# load 2.0
	mul.s	$f11, $f11, $f1	# 2 * a
	div.s	$f11, $f9, $f11
	addi	$sp, $sp, -12
	s.s	$f11, ($sp)
	s.s	$f11, 4($sp)
	li	$s0, 1
	sw	$s0, 8($sp)	# put status 1 on stack
	jr	$ra	# return back
	
	else:
	sub.s	$f9, $f4, $f2	# -b	
	l.s	$f11, two	# load 2.0
	mul.s	$f11, $f11, $f1	# 2 * a
	div.s	$f12, $f9, $f11	# -b / 2 * a
	div.s	$f13, $f8, $f11
	
	
	
	addi	$sp, $sp, -12
	s.s	$f12, ($sp)
	s.s	$f13, 4($sp)
	li	$s0, 2
	sw	$s0, 8($sp)	# put status 2 on stack
	jr	$ra	# return back
	
	return_status3:
		addi	$sp, $sp, -12
		li	$s0, 3
		sw	$s0, 8($sp)	# store status 3 on stack
		jr	$ra	# return back
