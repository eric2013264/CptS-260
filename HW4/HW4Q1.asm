.text 
.globl main
				
main: 
li 	$a0, 3
move	$t0, $a0
f:
bgt	$a0, 0, recursive
li	$v0, 1			## set up return value for base case
jr	$ra	 		## return home

recursive:
addi	$sp, $sp, -8
sw	$a0, 0($sp)
sw	$ra, 4($sp)
addi	$a0, $a0, -1		## complete f(n-1)
jal f 				## value of f(n-1) is in $v0

calculate:
beq	$a0, $t0, EXIT	
mul 	$v0, $v0, 2		## 2 * $v0 + 1 = $v0
addi	$v0, $v0, 1
addi 	$a0, $a0, 1	

jal calculate

EXIT:
lw 	$ra, 4($sp)		## restore
lw 	$a0, 0($sp)
addi	$sp, $sp, 8

.data