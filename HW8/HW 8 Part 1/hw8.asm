# Eric Chen 11381898 HW 6

# *** SEE README.TXT ***

# Memory mapped address of device registers.
# 0xFFFF0000 receieve control
# 0xFFFF0004 receieve data
# 0xFFFF0008 transmit control
# 0xFFFF000c transmit data

.text
main:		
jal	getc			# get c1
#subi 	$v0, $v0, 48		# ascii offset
ori	$a0, $v0, 0
ori	$t2, $a0, 0		# $t2 = c1

jal	getc			# get operand
ori	$a0, $v0, 0
ori	$t3, $a0, 0		# $t3 = op

jal	getc			# get c2
#subi 	$v0, $v0, 48		# ascii offset
ori	$a0, $v0, 0
ori	$t4, $a0, 0		# $t4 = c2

jal	getc			# get "="
ori	$a0, $v0, 0		# put "=" into $a0
ori	$t9, $a0, 0		# put "=" into $t9

beq	$t3, 45, subtraction	# branch depending on op
beq	$t3, 43, addition
	
addition:
add	$a0, $t2, $t4
#add	$a0, $a0, 48		# ascii offset
jal	putc
j 	exit
	
subtraction:
sub	$a0, $t2, $t4
#add	$a0, $a0, 48		# ascii offset
jal	putc
j	exit
	
getc:	# v0 = received byte		
lui     $t0, 0xffff		
gcloop:
lw	$t1, 0($t0)	        # read receieve control
andi	$t1, $t1, 0x0001	# extract ready bit
beq	$t1, $0, gcloop		# keep polling untill ready
lw	$v0, 4($t0)		# read data and return
jr	$ra		
	
putc: 	# a0 = byte to transmit	
lui     $t0, 0xffff
pcloop:
lw	$t1, 8($t0)		# read receieve control
andi	$t1, $t1, 0x0001  	# extract ready bit 
beq	$t1, $0, pcloop		# keep polling untill ready
sw	$a0, 0xc($t0)		# write data
jr	$ra			# read data and return

exit:
jal	putc

.data
