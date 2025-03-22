################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Wilton Miller, 1009976171
# Student 2: Name, Student Number (if applicable)
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

# Current Capsule State:
  
# The row of the capsules anchor cell
capsule_row: 
  .word 0
# The column of the capsules anchor cell
capsule_col:
  .word 31
# The orientation of the capsule (0 = Horizontal, 1 = Vertical)
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
    li $t1, 0xff0000        # $t1 = red
    #li $t2, 0x00ff00        # $t2 = green
    #li $t3, 0x0000ff        # $t3 = blue
    #li $t4, 0xffaaaaaa      # t4 = light gray
    
    # Initialize the game
    jal draw_bottle

draw_bottle:
  lw $t8 ADDR_DSPL
  addi $t8, $t8, 3872
  sw $t1 0($t8)

game_loop:
    # 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (capsules)
	# 3. Draw the screen
	# 4. Sleep

    # 5. Go back to Step 1
    j game_loop
