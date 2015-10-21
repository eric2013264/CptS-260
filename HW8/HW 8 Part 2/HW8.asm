# Eric Chen 11381898 HW8

# Memory mapped address of device registers.
# 0xFFFF0000 receieve control
# 0xFFFF0004 receieve data
# 0xFFFF0008 transmit control
# 0xFFFF000c transmit data

.text
main:	
move	$t9, $sp
lui	$t0, 0xFFFF		# Upper 16 bytes
lw	$t1, 0($t0)		# Receiver control
ori	$t1, $t1,  0x0002	# Lower 16 bytes
sw	$t1, 0($t0)		# Interupts
	 
LOOP:	
beq	$t2, '=', FIN		# Wait for "="
j LOOP

FIN:
addi	$sp, $sp, 4		# Pop = off the stack
li	$t8, 9
li	$t7, 1			
li	$t6, 10

LOOP2:	
lw	$s0, 0($sp)		# Load 1 byte char
addi	$sp, $sp, 4		# Next in stack
sub	$s0, $s0, 48		# Ascii offset
bltz	$s0, ELSE		# While (input==int)
bgt	$s0, $t8, ELSE
mult	$s0, $t7		# Append
mflo	$s1	
add	$s2, $s2, $s1
mult	$t7, $t6
mflo	$t7
j LOOP2

ELSE:
move	$s3, $s0		# op
li	$t7, 1

LOOP3:	
lw	$s0, 0($sp)		# Load 1 byte char
addi	$sp, $sp, 4		# Next in stack
sub	$s0, $s0, 48		# Ascii offset
bltz	$s0, compute		# While (input==int)
bgt	$s0, $t8, compute
mult	$s0, $t7		# *10 append
mflo	$s1	
add	$s4, $s4, $s1
mult	$t7, $t6
mflo	$t7
j LOOP3

compute:	
beq	$s3, -5, addition	# $s3 = op
beq	$s3, -3, subtraction
j GOTO

addition:
add	$s5, $s4, $s2		# $s4 = c2, $s2 = c1
j done

subtraction:
sub	$s5, $s4, $s2

done:
sw	$s5, 12($t0)
li	$v0, 11
li	$v0, 1
move	$a0, $s5
syscall
j LOOP

#EXIT:
#li	$v0, 10
#syscall

GOTO:
li	$s2, 0
li	$s4, 0
move	$sp, $t9
li	$t2, 0
j LOOP

.data 

.ktext 0x80000180	# Interrupt handler
lw	$t2, 4($t0)	# Load 1 byte char from keyboard
addi	$sp, $sp, -4	# Stack
sw	$t2, 0($sp)	# Push
mfc0	$k0, $14
addi	$k0, $k0, 4	# Pop
eret 			# Return from exeception
jr	$k0		# Jump to before interrupt
