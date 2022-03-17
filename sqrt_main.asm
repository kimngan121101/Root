.data
	m1: .asciiz "Value: "
	m2: .asciiz "Square Root: "
	m3: .asciiz "NaN"
.text
.globl main

main: 
	li 	$v0, 4
	la 	$a0, m1
	syscall
	
	li 	$v0, 6	# read num fron user
	syscall
	
	mov.s 	$f20, $f0
	jal 	sqrt
	bne	$v1, $0, print_NaN	# check NaN condition
	mov.s 	$f12, $f22
	
	li 	$v0, 4
	la 	$a0, m2	# print m2
	syscall
	
	li 	$v0, 2	# print sqrt value
	syscall
	j	terminate
print_NaN:
	li 	$v0, 4
	la 	$a0, m2	# printm2
	syscall
	
	li 	$v0, 4
	la 	$a0, m3	# print NaN
	syscall
	
terminate:
	li 	$v0, 10 
	syscall
	
