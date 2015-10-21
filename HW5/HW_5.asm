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

li	$t1, 3
sw	$t1, 16($t0)		# 3

li	$t1, 6
sw	$t1, 20($t0)		# 6

li	$a0, 0			# left
li	$a1, 5			# right
jal	QUICKSORT		# function call

PRINT:
li	$t0, 0

LOOP: 
bge	$t0, 24, FINISH
lw	$t1, arr($t0)
move	$a0, $t1
li	$v0, 1
syscall

la	$a0, space		# print space
li	$v0,4
syscall


addi	$t0, $t0, 4
j	LOOP

FINISH:
li	$v0, 10
syscall

QUICKSORT:
addi	$sp, $sp, -12		# save 3 items on stack
sw	$ra, 0($sp)		# 0=return address
sw	$a0, 4($sp)		# 4=left
sw	$a1, 8($sp)		# 8=right
	
move	$t0, $a0		# i=left
move	$t1, $a1		# j=right
mult	$t0, $s7
mflo	$t0
mult	$t1, $s7
mflo	$t1
add	$t2, $a0, $a1		# left+right
div	$t2, $t2, 2		# (left+right)/2
mult	$t2, $s7
mflo	$t2			# pivot
lw	$t2, arr($t2)		# pivot

LOOP1:
bgt	$t0, $t1, RECURSIVE 	# while i <= j

LOOP2:				# while arr[i] < pivot
lw	$t3, arr($t0)
bge	$t3, $t2, WHILE3
addi	$t0, $t0, 4
j	LOOP2

WHILE3:
lw	$t4, arr($t1)		# j
bge	$t2, $t4, IF		# while arr[j] > pivot
subi	$t1, $t1, 4		# decrement j
j	WHILE3
	
IF:
bgt	$t0, $t1, RECURSIVE	# SWAP
lw	$t5, arr($t0)		# x=i
lw	$t6, arr($t1)		# x2=j
sw	$t6, arr($t0)		# i=x2
sw	$t5, arr($t1)		# j=x
addi	$t0, $t0, 4		# increment i
subi	$t1, $t1, 4		# decrement i
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
