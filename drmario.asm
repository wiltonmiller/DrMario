################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Wilton Miller, 1009976171
# Student 2: Kunyu (Leo) Li, 1010371170
#
# We assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
#
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       64
# - Unit height in pixels:      64
# - Display width in pixels:    1
# - Display height in pixels:   1
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################
# The 64 x 64 grid for the bitmap display
grid:
  .space 16384

# Colors:
red:
  .word 0xff0000
green:
  .word 0x00ff00
blue:
  .word 0x0000ff
light_gray:
  .word 0xffaaaaaa

# Current Capsule State:
  
# The row of the capsules anchor cell
capsule_row: 
  .word 0
# The column of the capsules anchor cell
capsule_col:
  .word 31
# The orientation of the capsule, based on the left-half of the capsule 
# (0 = Horizontal_right, 1 = Vertical_down, 
#  2 = Horizontal_left, 3 = Vertical_up)
capsule_orient:
  .word 0
# The colour of the first cell (anchor) of the capsule
capsule_colour1:
  .word 0
# The colour of the seconds cell of the capsule
capsule_colour2:
  .word 0

##############################################################################
# Code
##############################################################################
	.text
	.globl main

    # Run the game.
main:
    la $t1, red         # $t1 = red
    
    # Initialize the game
    jal draw_bottle

draw_bottle:
    lw $t8 ADDR_DSPL
    addi $t8, $t8, 3872
    sw $t1 0($t8)

gen_virus:
    

cal_location:
    

# gen_int:
#     li $v0, 42
#     li $a0, 0
#     li $a1, 15
#     syscall
#     jr $ra

draw_cap:
    addi $s5, $zero, 4416
    jal draw_block
    addi $s5, $s5, 8
    jal draw_block

draw_block:
    lw $t8 ADDR_DSPL
    add $t8, $t8, $s5
    sw $t1 0($t8)
    sw $t1 4($t8)
    sw $t1 256($t8)
    sw $t1 260($t8)
    jr $ra



game_loop:
    # 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (capsules)
	# 3. Draw the screen
	# 4. Sleep

    # 5. Go back to Step 1
    j game_loop
