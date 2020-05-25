	# HW08 Exercise 3 Aria Killebrew Bruehl 
	#
	# CSCI 221 F19
	#
	# This scans through an integer array in the data
	# segment, outputting each array item's value.
	#
	
        .data
array:  .word , 7, 1, 2, 1, 3, 7, 3
length: .word 8
eoln:	.asciiz "\n"
dup:    .asciiz "duplicates"
no_dup:  .asciiz "no duplicates"
	
        .globl main
        .text

main:
        la      $t0, array      # load the "base" address of the array
        li      $t1, 0          # use $t1 as an integer index
        lw      $t2, length

loop:
        bge     $t1, $t2, print_nodup   # check that the index isn't larger than the array size
	
        sll     $a1, $t1, 2	# multiply the index by 4 to compute the offset
        addu    $a1, $t0, $a1   # compute a pointer to that word in the array (base + offset)
        lw      $a0, ($a1)      # get the next item in the array and store in $a0

        li      $t3, 0          # use $t3 as counter to check everything before $a0 in array 
check_loop:
        beq     $t1, $t3, incre # if position in array = position in loop go to increment 

        sll     $a2, $t3, 2	# multiply the index by 4 to compute the offset
        addu    $a2, $t0, $a2   # compute a pointer to that word in the array (base + offset)
        lw      $a3, ($a2)      # get the next item in the array and store in $a3

        beq     $a0, $a3, print_dup # if data in $a0 = data in $a3 go to print_dup

        addiu   $t3, $t3, 1     # increment $t3 
        b       check_loop 

incre:       
        addiu    $t1, $t1, 1 
        j       loop 

print_dup:
        la      $a0, dup        # load dup into $a0 if there were duplicates 
        j       end 

print_nodup:
        la      $a0, no_dup     # load no_dup into $a0 if there weren't duplicates 

end:	
        li      $v0, 4          # output message 
        syscall
        li      $v0, 0
        jr      $ra