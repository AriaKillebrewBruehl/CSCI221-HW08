	# HW08 Exercise 2 Aria Killebrew Bruehl 
    # sample MIPS32 assembly program
	#
	# CSCI 221 F19
	#
	# Nibbles are 4-bit parts of a computer word. A byte contains
	# two nibbles, the lower order nibble of bits 0-3, and the
	# higher order nibbles of bits 4-7.
	#
	# Because a nibble is made up of 4 bits, it encodes a value
	# between 0 and 15 (unsigned). It is thus normally described
	# with a hexidecimal "digit", one of 0-9 and a-f.
	#
	# This code outputs the two nibbles of a character at the start
	# of a string in hexadecimal. It uses the .data string at the
	# top of the code (labelled with "hexdigit:") as a table of the
	# hexidecimal digit.
	#
	
        .data

hexdigit:       .asciiz "0123456789abcdef"
text:           .asciiz "Hello."	# This is character 77, i.e. 0x4D.

to_print:       .space 15       # I write the hex characters here.
eoln:           .asciiz "\n"
	

	.globl main
	.text

main:
	la      $t4, text       # move a pointer to the right end of the text
	la      $t2, to_print 
    
loop:
	lb      $t0, ($t4)      # Get both nibbles from the character byte. 
	beqz 	$t0, print		# if null char go to print 
	srl     $t1, $t0, 4     # Shift 4 bits right to get left nibble.
	andi    $t0, 15         # Exclude left nibble to get right nibble.

	la      $a0, hexdigit   # Load the hexdigit table's address.

	addu    $t0, $t0, $a0   # Get the hex character of the right nibble
	lb      $t0, ($t0)      # by looking it up in "hexdigits."

	addu    $t1, $t1, $a0   # Get the hex character of the left nibble
	lb      $t1, ($t1)      # by looking it up in "hexdigits."

	
	sb      $t1, ($t2)      # Write the left nibble character into "to_print". 
	addiu   $t2, $t2, 1     # 
	sb      $t0, ($t2)      # Write the right nibble character into "to_print".
	addiu   $t2, $t2, 1     #
	li      $t3, 32         #	Write the space character into "to_print".
	sb      $t3, ($t2)  
	addiu   $t2, $t2, 1     #    

	addiu   $t4, $t4, 1     # move to the next character	
	b 		loop 

print:
	la	$a0, to_print   # print(to_print)
	li	$v0, 4		    #
	syscall			    #
	la	$a0, eoln       # print(eoln)
	li	$v0, 4		    #
	syscall			    #

	li	$v0, 0		    # return 0
	jr	$ra		        #
