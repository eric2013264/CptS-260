.text 
.globl main

main: 
li	$a0, 3 
li	$v0, 1		#f(n-2)
li	$v1, 2		#f(n-1)

recursive:
beqz	$a0, EXIT	# a0 is starting value

mul	$t0, $v1, 2 	# v1 = 2f(n-1)
mul	$t1, $v0, 3 	# v0 = 3f(n-2)
addi	$t1, $t1, 1 	# t1 = 3f(n-2)+1
add	$t0, $t0, $t1 	# 2f(n-1))+(3f(n-2) + 1)
move	$v0, $v1 	# store v1 in v0
move	$v1, $t0

sub	$a0, $a0, 1

j recursive
EXIT:
