# Homework 08: more MIPS programming 

*Due: April 8th, 3pm*

In this lab we write MIPS code to work with basic data structures that
are stored in the `.data` segment of the program's memory. You'll
write code that tweaks null-terminated character strings, arrays of
integers, and linked lists of integers. The four exercises each work
from some sample code, similar to code from lecture, and have you
modify each to do something slightly different.

---

Exercise 1: AlTeRnAtInG cApItAls
--------------------------------

We saw that C strings are encoded as a sequence of byte values ending
with the 0 byte (the null character). The byte values are the
characters' [ASCII codes](https://www.ascii-code.com). Uppercase
letters are encoded as a byte value between 65 and 90. Lowercase
letters are encoded as a byte value between 97 and 122. The letter `A`
is encoded as 65 and the letter `Z` is encoded as 90. The letter `a`
is encoded as 97 and the letter `z` is encoded as 122.

I've included the code `lowercase.asm` that scans through a C string stored
in `.data` starting at the address labelled `text:`, and converts any
uppercase letters in the string to lowercase.

Copy and modify the code as `altcase.asm` so that it the conversion
instead alternates between uppercase and lowercase letters with each
letter in the string.  It should convert

    alternating

to

    AlTeRnAtInG

and do the same with

    aLTERnatINg

converting it also to

    AlTeRnAtInG

For strings with punctuation and spaces, it should just skip past
those characters, without changing them. That means that

    This sentence, I'd say, should be converted.

should be converted to

    ThIs SeNtEnCe, I'd SaY, sHoUlD bE cOnVeRtEd.

---

Exercise 2. the hex of a string
-------------------------------

Nibbles are 4-bit parts of a computer word. A byte contains two
nibbles: the lower order nibble of bits 0-3, and the higher order
nibbles of bits 4-7.  Because a nibble is made up of 4 bits, it
encodes a value between 0 and 15 (unsigned). It is thus normally
described with a hexidecimal "digit", one of 0-9 and a-f.

The `char_byte_hex.asm` code outputs the two nibbles of a character at
the front of a character string. It is written now so that the
it prints the two hex digits of the character `M`. These happen to
be `4D`, since its ASCII code is 77.

The code does this by extracting the two nibbles of the character into
the registers `$t0` and `$t1`, looking up their hexdigit by performing
an `LB` instruction within the string `"0123456789abcdef"`, and then
placing each of these hex digit characters into an area of the `.data`
segment labelled as `to_print:`. That area is a "buffer" where the
code builds the text string it wants to print. The first character it
writes there is the left nibble's hex digit, the 2nd character is the
right nibble's hex digit, and then the 3rd character is the null
terminator character 0. Once it builds that string it uses SYSCALL #4
to output it.

Modify the code as `string_bytes_hex.asm` so that `text:` instead labels
a string of length larger than one, something like:

    text: .asciiz "Hello."

It should then output the bytes of each character in
that string, in hexdecimal, separated by spaces. For
example, the string above would be output as

    48 65 6c 6c 6f 2e

Note that the `to_print:` area should have enough room for that
hexadecimal string, and so you should reserve space that's at least
three times the length of the `text` string.

Your code should work in principle with strings of any length, even 
though in practice you have to set up the `text:` and `to_print:`
parts of the `.data` segment by hand to test this.

---

Exercise 3. duplicates
----------------------

I've included a program `output_array.asm` that scans through an array
of integer words. It relies on two `.data` declarations `array:` and
`length:`. Copy and modify it as `duplicates.asm`.  It should print the
string `"duplicates"` if some value appears more than once in the
array. It should print the string `"no duplicates"` otherwise.

For example, if the data declaration is

    array:  .word 1, 7, 1, 2, 1, 3, 7, 3
    length: .word 8

I would expect the output to be

    duplicates

and if it instead is
   
    array:  .word 11, 7, 1, 2, 10
    length: .word 5

then I'd expect the output to be

    no duplicates

---

Exercise 4. linked list prefix sum
----------------------------------

A *prefix sum* of a sequence is a different sequence whose elements
are the sums of each *prefix sequence*. For example, the sequence

    3, 6, 17, 20, 35

has the prefix sequences

    3
    3, 6
    3, 6, 17
    3, 6, 17, 20
    3, 6, 17, 20, 35

and so the original sequence has the prefix sum

    3, 3+6, 3+6+17, 3+6+17+20, 3+6+17+20+35

or, written more simply

    3, 9, 26, 46, 81

Included here is the code `link_sort.asm` that builds a linked list from
unlinked nodes laid out in the `.data` segment. The code links them
together in sorted order. It then traverses that list to print them in
order.

Copy this code as `prefix_sum.asm`. Modify the code so that, after the
list is built and before the list is printed, it modifies the data
value stored at each node so that the resulting list becomes its
prefix sum instead.

*Hint:* to do this, just traverse the list while keeping track of the
sum of the data stored at each node visited. This is often called the
"running sum" computed during that traversal. As it performs this
traversal, it can modify each node with that running sum.
