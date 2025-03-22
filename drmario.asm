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

# Four corners of the bottle
TOP_LEFT_OFFSET: 
  .word 3872
BOTTOM_LEFT_OFFSET:
  .word 14624
TOP_RIGHT_OFFSET:
  .word 4008
BOTTOM_RIGHT_OFFSET: 
  .word 14764

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
    # li $t1, 0xffaaaaaa      # t4 = light gray
    
    # Initialize the game
    jal draw_bottle

    lw $t8 ADDR_DSPL
    li $t1, 0xff0000
    sw $t1, 14240($t8)
    sw $t1, 14244($t8)

    sw $t1, 14496($t8)
    sw $t1, 14500($t8)

draw_bottle:  
  # SETTING UP LEFT_SIDE_LOOP
  
  lw $t8 ADDR_DSPL # starting address of the dispaly
  
  lw $t7, TOP_LEFT_OFFSET 
  add $t7, $t7, $t8 # top left corner of the bottle

  lw $t6, BOTTOM_LEFT_OFFSET
  add $t6, $t6, $t8 # bottom left corner of the bottle

  li $t4, 0x888888 # light grey

  li $t5, 968 # $ grid index (3872 / 4)
  la $t9, grid # $ base address of grid

LEFT_SIDE_LOOP:
  sw $t4, 0($t7) # draw to display
  sw $t4, 4($t7) # thicken line

  sll $t3, $t5, 2 # convert grid index to byte offset
  add $t3, $t3, $t9 # grid + offset
  sw $t4, 0($t3) # update grid

  addi $t7, $t7, 256 # next row in display (64 * 4)
  addi $t5, $t5, 64 # next row in grid

  ble $t7, $t6, LEFT_SIDE_LOOP

  #SEETING UP RIGHT_SIDE_LOOP 
  
  lw $t7, TOP_RIGHT_OFFSET
  add $t7, $t7, $t8 # top left right corner of the bottle

  lw $t6, BOTTOM_RIGHT_OFFSET
  add $t6, $t6, $t8 # bottom right corner of the bottle

  li $t5, 1000 # grid index (1000 / 4)

RIGHT_SIDE_LOOP:
  sw $t4 0($t7) # draw to display
  sw $t4 4($t7)

  sll $t3, $t5, 2 # convert index to byte offest
  add $t3, $t3, $t9 # grind + offest
  sw $t4, 0($t3)

  addi $t7, $t7, 256 #go to the next row in the disaply
  addi $t5, $t5, 64 # go to the next row in the grid

  ble $t7, $t6, RIGHT_SIDE_LOOP

  # SETTING UP BOTTOM_LOOP
  
  lw $t7, BOTTOM_LEFT_OFFSET
  add $t7, $t7, $t8 # top left corner of the bottle

  lw $t6, BOTTOM_RIGHT_OFFSET
  add $t6, $t6, $t8 # bottom right corner of the bottle

  li $t5, 3528 # grid index (14112 / 4)

BOTTOM_LOOP:
  sw $t4 0($t7) # draw to display
  sw $t4, 256($t7)

  sll $t3, $t5, 2 # convert index to byte offest
  add $t3, $t3, $t9 # grind + offest
  sw $t4, 0($t3)

  addi $t7, $t7, 4 #go to the next pixel in the disaply
  addi $t5, $t5, 1 # go to the next index in the grid

  ble $t7, $t6, BOTTOM_LOOP

  # SETTING UP ENTRANCE_LOOP_LEFT
  lw $t7, TOP_LEFT_OFFSET
  add $t7, $t7, $t8 # top left corner of the bottle

  li $t6, 3924 # byte offset of left entrnace
  add $t6, $t6, $t8 # addresss value of left entrace

  li $t5, 968 # $ grid index (3872 / 4)
  
ENTRANCE_LOOP_LEFT:
  sw $t4 0($t7) # draw to display
  sw $t4 256($t7)

  sll $t3, $t5, 2 # convert index to byte offest
  add $t3, $t3, $t9 # grind + offest
  sw $t4, 0($t3)

  addi $t7, $t7, 4 # go to the next pixel in the disaply
  addi $t5, $t5, 1 # go to the next index in the grid

  ble $t7, $t6, ENTRANCE_LOOP_LEFT

  # SETTING UP THE ENTRANCE_LOOP_RIGHT
  
  lw $t7, TOP_RIGHT_OFFSET
  add $t7, $t7, $t8 # top right corner of the bottle

  li $t6, 3956
  add $t6, $t6, $t8 # addresss value of right entrace

  li $t5, 988 # grid index (3952/4) 

ENTRANCE_LOOP_RIGHT:
  sw $t4 0($t6) # draw to display
  sw $t4 256($t6)

  sll $t3, $t5, 2 # convert index to byte offest
  add $t3, $t3, $t9 # grind + offest
  sw $t4, 0($t3)

  addi $t6, $t6, 4 # go to the next pixel in the disaply
  addi $t5, $t5, 1 # go to the next index in the grid

  bge $t7, $t6, ENTRANCE_LOOP_RIGHT
  

game_loop:
    # 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (capsules)
	# 3. Draw the screen
	# 4. Sleep

    # 5. Go back to Step 1
    j game_loop
