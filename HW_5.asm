# Eric Chen
# 11381898
# HW 5 QuickSort
# 3/12/2015
# sample array: 5,1,4,10,3,6.

.data
arr:	.space	24	# integer array
space:	.asciiz	" "

.text
.globl main
main:

STORE: 
li	$s7, 4
la	$t0, arr

li	$t1, 5
sw	$t1, 0($t0)		# 5

li	$t1, 1
sw	$t1, 4($t0)		# 1

li	$t1, 4
sw	$t1, 8($t0)		# 4

li	$t1, 10
sw	$t1, 12($t0)		# 10


<information omitted to prevent direct referencing>

j	LOOP1

RECURSIVE:
div	$t0, $t0, 4
div	$t1, $t1, 4

IF2:
bge	$a0, $t1, ELIF
move	$a1, $t1
jal	QUICKSORT

ELIF:
lw	$a0, 4($sp)
lw	$a1, 8($sp)

IF3:	
bge	$t0, $a1, ELIF2
move	$a0, $t0
jal	QUICKSORT

ELIF2:
lw	$a0, 4($sp)
lw	$a1, 8($sp)
lw	$ra, 0($sp)		# return address
lw	$a0, 4($sp)		# initial left
lw	$a1, 8($sp)		# initial right
addi	$sp, $sp, 12		# 3 spaces on stack
jr	$ra
