.text 
.globl main

main: 
li	$a0, 3
li	$v0, 1		# base case
li	$v1, 0 		# base case

recursive:
beq	$a0, $1, EXIT	# for (n-1)

mul	$t0,$v0,3	# 3(g(n-1))
sub	$t0,$t0,1	# 3(g(n-1))-1

move	$v0, $t0
mul	$v1, $v0, 2	# 2(g(1))
addi	$v1, $v1, 1	# f(n)
	
sub	$a0, $a0, 1 

j recursive
EXIT:
