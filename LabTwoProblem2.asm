########################################################################
# Student: Eric Schenck						Date: 11/9/17
# Description: LabTwoProblem2.asm - write an efficient algorithm to perform 
#		the following tasks: Create an array A size 20, all elements initial 4.
#		for every element in array, if index i is even, perform A[i] = A[i] - i
#		if its index i is odd, perform A[i] = A[i] + 2*i.
#		swap elements A[i] and A[19 - i], such that, A[0] with A[19], A[1] with A[18], etc.
#		Print out the resulting array.
#		Count how many cycles need to execute program and write it down in readme.txt
#		Note: efficient program means use as less cycles as possible, but not necessary to be 
#		minimum number of cycles possible.. 						
#
# Registers Used:
#	$a0: Used for various Arguments
#	$a1: Used for size of array arguments
#	$s0: Used as counter for loop
#	$s1: Used to keep track of i
#	$t0: Used for counters and other temporary uses
#	$t1: Used to hold min/max data in Functions 
#	$v0: Used for return variables and other uses
#
#
########################################################################
		.data

A:		.word 4:20			# array size 20 with all entries intial 4
space:		.asciiz ", "			

		.text
		.globl main
		
main: 		
		la $a0, A			# loading address of A into $a0
		li $s0, 20			# size of array for counter
		li $s1, 0			# counter starting at 0
		
loop:		lw $t0, 0($a0)			# loading A[i]
		
		andi $t1, $s1, 1		# if $t1 = 1 then $t0 is odd
		beqz $t1, Even			# if $t1 = 0 then $t0 is even
		sll $t1, $s1, 1			# $t1 = 2*i
		add $t1, $t0, $t1		# $t1 = A[i] + 2*i
		sw $t1, 0($a0)			# A[i] = $t1
		j Update				

Even:		sub $t1, $zero, $s1		# $t1 = - i 
		add $t1, $t0, $t1		# $t1 = A[i] - i
		sw $t1, 0($a0)			# A[i] = $t1
			

Update:		addi $s1, $s1, 1		# incrimenting i by 1
		addi $a0, $a0, 4		# adjusting address to get next cell in array
		addi $s0, $s0, -1		# decrimenting counter by 1
		bgtz $s0, loop			# more elements to go through

endLoop:

		la $a0, A			# loading address of A into $a0
		la $a1, A			# loading address of A into $a1
		
		addi $a1, $a1, 76		# $a1 will be last position in array
		li $s0, 10			# array counter, only 10 iterations 
swap:		
		
		lw $t0, 0($a0)			# loading value at A[i]
		lw $t1, 0($a1)			# loading value at A[19 - i]
		
		sw $t1, 0($a0)			# swapping A[i] = A[19 - i]
		sw $t0, 0($a1)			# A[19 - i] = A[i] 

		addi $a0, $a0, 4		# to access A[i+1]
		addi $a1, $a1, -4		# to access A[19 - 2i]
		addi $s0, $s0, -1		# decriment counter by one
		
		bgez $s0, swap			# if ($s0 >= 0) continue to swap



		la $a1, A			# loading address from starting index again
		li $s0, 20			# re-setting total index counter
						
printLoop:	lw $t0, 0($a1)			# loading A[i]
			
		li $v0, 1			# code to print integer
		move $a0, $t0 			
		syscall
		
		li $v0, 4			# code to print string
		la $a0, space
		syscall
		
		addi $a1, $a1, 4		# adjusting address to get next cell in array
		addi $s0, $s0, -1		# decrimenting counter by 1
		bgtz $s0, printLoop		# more elements to go through


						
Exit:		li $v0, 10 			# System code to exit
		syscall				# make system call 




