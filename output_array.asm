	# sample MIPS32 assembly program
	#
	# CSCI 221 F19
	#
	# This scans through an integer array in the data
	# segment, outputting each array item's value.
	#
	
        .data
array:  .word 1, 7, 1, 2, 1, 3, 7, 3
length: .word 8
eoln:	.asciiz "\n"
	
        .globl main
        .text

main:
        la      $t0, array      # load the "base" address of the array
        li      $t1, 0          # use $t0 as an integer index
        lw      $t2, length

loop:
        bge     $t1, $t2, end   # check if the index isn't larger than the array size
	
        sll     $a1, $t1, 2	# multiply the index by 4 to compute the offset
        addu    $a1, $t0, $a1   # compute a pointer to that word in the array (base + offset)
        lw      $a0, ($a1)      # get the next item in the array
        li      $v0, 1
        syscall
        li      $v0, 4          # print it	
        la      $a0, eoln	
        syscall			
        addiu   $t1, $t1, 1
        b       loop

end:	
        li      $v0, 0
        jr      $ra
	
