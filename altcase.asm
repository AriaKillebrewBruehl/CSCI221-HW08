        # HW08 Exercise 1 Aria Killebrew Bruehl 
        # sample MIPS32 assembly program
        #
        # CSCI 221 F19
        #
        # This loops through the characters of a C string,
        # setting uppercase letters to lowercase ones.
        #
	
        .data
text:   .asciiz "This sentence, I'd say, should be converted."
eoln:   .asciiz "\n"
	
        .globl main
        .text

main:
li      $t4, 0 # binary low_var to indicate converting to lowercase  
print_before:
        li      $v0, 4                  # print the string before it's converted
        la      $a0, text
        syscall
        li      $v0, 4
        la      $a0, eoln
        syscall
	
lower:
        la      $t0, text               # move a pointer to the right end of the text	
        la      $t1, text

lower_loop:	
        lb      $t2, ($t1)              # load the next character
        beqz    $t2, lower_done         # if character is null goto lower_done
        beqz    $t4, convert_upper      # if low_var is 0 convert char to uppercase
convert_lower:
        li      $t4, 0                  # reset low_var var to 0
        addiu   $t3, $t2, -65           # subtract character code for 'A'
        bltz    $t3, lower_skip         # if character is below 'A', do nothing
        addiu   $t3, $t2, -90           # subtract character code for 'Z'
        bgtz    $t3, lower_skip         # if character is above 'Z', do nothing
        addiu   $t3, $t2, 32            # make uppercase lowercase
        sb      $t3, ($t1)              # replace the character
        b       lower_skip              # move to next char 
convert_upper:
        li      $t4, 1                  # change low_var var to 1 
        addiu   $t3, $t2, -97           # subtract character code for 'a'
        bltz    $t3, lower_skip         # if character is below 'a', do nothing
        addiu   $t3, $t2, -122          # subtract character code for 'z'
        bgtz    $t3, lower_skip         # if character is above 'z', do nothing
        addiu   $t3, $t2, -32           # make lowercase uppercase 
        sb      $t3, ($t1)              # replace the character
lower_skip:
        addiu   $t1, $t1, 1             # move to the next character	
        b       lower_loop
lower_done:


print_after:
        li              $v0, 4          # print the string after it's converted
        la              $a0, text
        syscall
        li              $v0, 4
        la              $a0, eoln
        syscall
	
end:	
        li              $v0, 0          # return 0
        jr              $ra             #
	
