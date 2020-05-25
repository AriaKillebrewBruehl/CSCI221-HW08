	# HW08 Exercise 4 Aria Killebrew Bruehl
	#
	# CSCI 221 F19
	#
	# This takes an allocated array of link list nodes,
	# stored separately (with "next" field's set to the
	# nullptr). It inserts them into a linked list 
	# structure, by order of their "data" field. It then
	# traverses that structure and outputs their values
	# (in sorted order, as a result).
	#
	# Since both the "data" and "next" fields are 32 bits
	# in the MIPS32 architecture, they are both of type
	# .word. So the nodes are laid out in the .data segment
	# contiguously.
	#
	# Thus, a linked list node is just 4 bytes of an integer
	# data value, and then 4 bytes of a next pointer value.
	#
	
        .data
eoln:           .asciiz "\n"
num_nodes:      .word   5
nodes:          .word   35, 0x0000, 6, 0x0000, 17, 0x0000, 3, 0x0000, 20 0x0000

        .globl main
        .text

main:
        la      $a1, nodes		# first = the first node in the array
        addiu   $a2, $a1, 8		# others = first + sizeof(llist_node)
        lw      $a3, num_nodes		# 
        addiu   $a3, $a3, -1		# to_insert = num_nodes-1

insert_each:
        beqz    $a3, done_insert	# if to_insert == 0 go to done_insert

insert_in_order:	
        lw      $t3, ($a2)		# load node->data
        move    $t4, $a1		# curr  = first
        li      $t5, 0x0000		# prev  = null
find_place:
        beqz    $t4, insert		# if curr == nullptr goto insert
        lw      $t6, ($t4)		# load curr->data
        ble     $t3, $t6, insert	# if node->data < curr->data goto insert
        move    $t5, $t4		# prev = curr
        lw      $t4, 4($t4)		# curr = curr->next
        b       find_place
insert:
        addiu   $a3, $a3, -1		# to_insert -= 1	
        sw      $t4, 4($a2)		# node->next = curr
        beqz    $t5, insert_in_front	# if prev == nullptr goto insert_at_front
insert_middle:
        sw      $a2, 4($t5)		# prev->next = node
        b       bump_node
insert_in_front:
        move    $a1, $a2		# first = node
bump_node:
        addiu   $a2, $a2, 8		# node = next node in the node array
        b       insert_each
done_insert:

	
print:
        move    $t4, $a1		# curr = first
        li      $t5, 0          # running_sum = 0 
print_loop:	
        beqz    $t4, done_print	# if curr == nullptr go to done_print
print_data:	
        lw      $t6, ($t4)      # load curr->data into $t6 
        addu    $t5, $t5, $t6   # running_sum = running_sum + curr->data
        move    $a0, $t5		# move running_sum into $a0
        li      $v0, 1			# print(running sum)
        syscall
        la      $a0, eoln		#
        li      $v0, 4			# print("\n")
        syscall
	
        lw	$t4, 4($t4)		    # curr = curr->next
        b       print_loop
done_print:

end:	
        li      $v0, 0			# return 0
        jr       $ra			#
	
