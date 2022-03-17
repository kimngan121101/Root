.data
msg0:	.asciiz "a: "
msg1:	.asciiz "b: "
msg2:	.asciiz "c: "
msg4:	.asciiz " +/- "
msg5:	.asciiz "i"
msg6:	.asciiz "No roots computed (error)!!!"
msg7:	.asciiz "There are two roots: "
msg8:	.asciiz "There is one root: "
msg9:	.asciiz "There are two complex roots: "
msg10:	.asciiz ", "
msg11: .asciiz "Quadratic Solver\n"
endl:	.asciiz "\n"

.text
main:
la	$a0, msg11
li	$v0, 4		# print msg0
syscall

la	$a0, msg0
li	$v0, 4		# print msg0
syscall

li	$v0, 6		# read a from user
syscall
mov.s	$f1, $f0	# a

la	$a0, msg1
li	$v0, 4		# print msg1
syscall

li	$v0, 6		# read b from user
syscall
mov.s	$f2, $f0	# b

la	$a0, msg2
li	$v0, 4		# print msg2
syscall

li	$v0, 6		# read c from user
syscall
mov.s	$f3, $f0	# c

addi	$sp, $sp, -12
s.s	$f1, ($sp)
s.s	$f2, 4($sp)
s.s	$f3, 8($sp)
jal	root

l.s	$f1, ($sp)
l.s	$f2, 4($sp)
lw	$t0, 8($sp)	# status
addi	$sp, $sp, 12

beq	$t0, 3, noRoot
beq	$t0, 2, compRoot
beq	$t0, 1, oneRoot
beq	$t0, $0, real2Root

j	terminate

real2Root:
	la	$a0, msg7
	li	$v0, 4		# print msg7
	syscall
	
	li	$v0, 3
	cvt.d.s	$f12, $f1	# print root1
	syscall

	li	$v0, 4
	la	$a0, msg10	# print msg10
	syscall

	li	$v0, 3
	cvt.d.s	$f12, $f2	# print root2
	syscall
	j	terminate

oneRoot:
	la	$a0, msg8
	li	$v0, 4		# print msg8
	syscall
	
	li	$v0, 3
	cvt.d.s	$f12, $f1	# print root
	syscall
	j	terminate


compRoot:
	la	$a0, msg9
	li	$v0, 4		# print msg9
	syscall
	
	li	$v0, 2
	mov.s	$f12, $f1	# print real part
	syscall

	li	$v0, 4
	la	$a0, msg4	# print msg4
	syscall

	li	$v0, 2
	mov.s	$f12, $f2	# print imaginary part
	syscall
	
	li	$v0, 4
	la	$a0, msg5	# print msg5
	syscall
	j	terminate
	

noRoot:
	la	$a0, msg6
	li	$v0, 4		# print msg6
	syscall

terminate:
	li	$v0, 10	# terminate program
	syscall

