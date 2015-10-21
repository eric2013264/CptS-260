# Eric Chen 11381898 HW 6

.data
seven: .double 7.00
divisor: .double 0.01
increment: .double 0.01
zero: .double 0.00

.text 
.globl main
				
main: 

ldc1	$f0, seven	# load 32-bit floating point into F0	this is 7.00
ldc1	$f2, divisor	# 0.01 
ldc1	$f8, increment 	# 0.01 static
ldc1	$f10, zero

LOOP:
mul.d	$f4, $f2, $f2 	# x^2
mul.d	$f4, $f4, $f2	# x^3
sub.d	$f6, $f0, $f4	# $f6 = 7/x^3

c.le.d	$f6, $f10	# if 7/x^3 <= 0.00 MATCH
bc1t	EXIT		# 0 true

add.d	$f2, $f2, $f8	# not match, increment 0.01
j LOOP
												
EXIT:
mov.d	$f12, $f2
li	$v0, 3
syscall



