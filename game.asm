#####################################################################
#
# CSCB58 Winter 2025 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Siyi Zheng, 1009807112, zheng785, sy.zheng@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4 (update this as needed)
# - Unit height in pixels: 4 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestoneshave been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 4 (choose the one the applies)
#
# Which approved features have been implemented for milestone 4?
# (See the assignment handout for the list of additional features)
# 1. 3 Different Levels
# 2. Pick-up Effect: 
#	toamto: higher jump
#	poison: larger enemy
#	water: restore health
#	blue mushroom: slower gravity
# 3. Moving platform
# 
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes / no / yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################

# Bitmap display starter code

# Bitmap Display Configuration:
# - Unit width in pixels: 4
# - Unit height in pixels: 4
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)

.eqv BASE_ADDRESS 0x10008000 	# base address of display
.eqv MAX_ADDRESS 0x1000c000 	# max address of display
.eqv BYTE_WIDTH 256 	# width of display
.eqv BYTE_HEIGHT 256
.eqv UNIT_WIDTH 64 	# width of display
.eqv UNIT_HEIGHT 64
.eqv UNIT_SIZE 4 	# unit size of display
.eqv DEFAULT_FRAME_RATE 50 # 50ms refresh for default frame rate
.eqv FLOOR_COLOR 0xbc9e82   # color of the floor
.eqv FLOOR_HEIGHT 15
.eqv PLATFORM_COLOR 0xF6F4DF
.eqv ENEMY_COUNT   2
.eqv BACKGROUND_COLOR 0xcce5ff
.eqv PLATFORM_NUM 5
.eqv PLATFORM_NUM_LT 2
.eqv PLATFORM_NUM_LTH 3
.eqv POTATO_ROWS 5
.eqv POTATO_COLS 7
.eqv TOMATO_ROWS 5
.eqv BLOOD_COLOR 0xff585a
.eqv HP_COLOR 0xD22B2B
.eqv HP_X 1
.eqv HP_Y 55
.eqv END_COLOR 0xCCCCFF
.eqv POT_X_BODY 45
.eqv POT_Y_BODY 39
.eqv POT_BODY_COLOR 0x999da0
.eqv POT_X_LID 44
.eqv POT_Y_LID 38
.eqv POT_LID_COLOR 0x48494b
.eqv POT_X_TOP 50
.eqv POT_Y_TOP 36
.eqv POTATO_X_LT 8
.eqv POTATO_Y_LT 44
.eqv POTATO_X_LTH 4
.eqv POTATO_Y_LTH 44
.eqv MUSH_MAIN 0xB22222
.eqv BMUSH_MAIN 0x9fa8da
.eqv SOUP_MAIN 0xececec
.eqv JUMP 5


.data
.align 2
on_platform: .word 1

potato_x: .word 4 # potato's x location
potato_y: .word 44 # potato's y location
.align 2
potato: 
    	.word 0x663300, 0x663300, 0x663300,
    	 0x663300, 0x996633, 0x996633, 0x996633, 0x663300, 0x663300,
    	 0x663300, 0x996633, 0xb79268, 0xb79268, 0xb79268, 0x996633, 0x663300,
    	 0x663300, 0x663300, 0x996633, 0xb79268, 0xb79268, 0x996633, 0x663300,
    	 0x663300, 0x663300, 0x663300, 0x663300, 0x663300       

potato_widths: .word 3, 6, 7, 7, 5
potato_offsets: .word 1, 0, 0, 0, 1
potato_widths_offsets: .word 3, 5, 6, 6, 5		# for check_platform_right		
potato_heads: .word 1, 0, 0, 0, 1, 1, 2		# for check_platform_up
potato_heights: .word 3, 4, 4, 4, 4, 4, 3		# for check_platform_down

tomato_x: .word 50
tomato_y: .word 44

tomato_x_l2: .word 2
tomato_y_l2: .word 44
tomato:
	.word 0x0B6623, 0x0B6623,
	 0xff0000, 0xff0000, 0x0B6623, 0xff0000,
	 0xff0000, 0xff0000, 0xff0000, 0xff0000, 0xff0000, 0xff0000,
	 0xff0000, 0xff0000, 0xff0000, 0xff0000, 0xff0000, 0xff0000,
	 0xff0000, 0xff0000, 0xff0000, 0xff0000
tomato_widths: .word 2, 4, 6, 6, 4
tomato_offsets: .word 2, 1, 0, 0, 1
.align 2

jump_height: .word 12
platform_x: .word 0, 28, 0, 18, 12  # platfrom's x position
platform_y: .word 22, 29, 36, 44, 12 # platform's y position
platform_len: .word 24, 10, 25, 15, 15

platform_x_l2: .word 25, 45
platform_y_l2: .word 25, 15
platform_len_l2: .word 15, 18

platform_x_l3: .word 30, 10, 50
platform_y_l3: .word 30, 25, 38
platform_len_l3: .word 10, 10, 10

bug_x: .word 40
bug_y: .word 35
bug:
	.word 0x000000,
	 0x000000, 0xcce5ff, 0x583927, 0x568203, 0x583927, 0xcce5ff, 0x000000,
	 0x000000, 
	 0x000000, 0x568203, 0x000000, 0x000000,0x568203,
	 0x000000, 0x568203, 0x000000,
	 0x000000, 0x000000, 0xcce5ff, 0xcce5ff, 0xcce5ff, 0x000000, 0x000000
bug_widths: .word 1, 7, 5, 1, 3, 7
bug_offsets: .word 3, 0, 1, 3, 2, 0
bug_dir: .word 0		#0 is up, 1 is down

.align 2

.align 2
frameRate: .word 0 # frame rate
level: .word 1		#current level
health: .word 3
score: .word 0
gravity_counter: .word 3
gravity: .word 3
gravity_slow: .word 10
damage_state: .word 0
enemy_counter: .word 8    
enemy_speed:   .word 8    
tomato_reached: .word 0

heart:
    	.word 0x000000, 0xD22B2B, 0x000000, 0xD22B2B, 0x000000,
     	0xD22B2B, 0xD22B2B, 0xD22B2B, 0xD22B2B, 0xD22B2B,
     	0x000000, 0xD22B2B, 0xD22B2B, 0xD22B2B, 0x000000,
     	0x000000, 0x000000, 0xD22B2B, 0x000000, 0x000000,

redraw: .word 0

g_x: .word 17
g_y: .word 23
g:
	.word 0x000000, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0x000000,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0x0000000,
	0xffd300, 0xffd300, 0x000000, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0xffd300,
	0x000000, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300

a_x: .word 25
a_y: .word 23

a:
	.word 0x000000, 0x000000, 0xffd300, 0xffd300, 0x000000, 0x000000,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300
	
m_x: .word 33
m_y: .word 23

m:
	.word 0xffd300, 0xffd300, 0x000000, 0x000000, 0x000000, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0xffd300, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0xffd300, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0xffd300


e_x: .word 41
e_y: .word 23
ee_x: .word 33
ee_y: .word 31
e:
	.word 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0x0000000,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0x0000000,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300

o_x: .word 17
o_y: .word 31
oo_x: .word 29
oo_y: .word 23

o:
	.word 0x0000000, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0x0000000,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0x0000000, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0x0000000

v_x: .word 25
v_y: .word 31

v:
	.word 0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0x0000000, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0x0000000,
	0x0000000, 0x0000000, 0xffd300, 0xffd300, 0x0000000, 0x0000000

r_x: .word 41
r_y: .word 31

r:
	.word 0x0000000, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0x0000000,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0x0000000,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300

y_x: .word 21
y_y: .word 23

y:
	.word 0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0x0000000, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0x0000000,
	0x0000000, 0x0000000, 0xffd300, 0xffd300, 0x0000000, 0x0000000,
	0x0000000, 0x0000000, 0xffd300, 0xffd300, 0x0000000, 0x0000000

u_x: .word 37
u_y: .word 23

u:
	.word 0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300,
	0x0000000, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0x0000000

w_x: .word 21
w_y: .word 31
w:	.word 0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0xffd300, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0x0000000, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0x0000000, 0xffd300, 0xffd300

i_x: .word 29
i_y: .word 31
i:
	.word 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300,
	0x0000000, 0x0000000, 0xffd300, 0xffd300, 0x0000000, 0x0000000,
	0x0000000, 0x0000000, 0xffd300, 0xffd300, 0x0000000, 0x0000000,
	0x0000000, 0x0000000, 0xffd300, 0xffd300, 0x0000000, 0x0000000,
	0x0000000, 0x0000000, 0xffd300, 0xffd300, 0x0000000, 0x0000000,
	0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300, 0xffd300


n_x: .word 37
n_y: .word 31
n: 
	.word 0xffd300, 0xffd300, 0x0000000, 0x0000000, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0xffd300, 0x0000000, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0xffd300, 0xffd300, 0xffd300,
	0xffd300, 0xffd300, 0x0000000, 0x0000000, 0xffd300, 0xffd300

bowl:
	.word 0x528aae, 0x528aae, 0x528aae, 0x528aae, 0x528aae, 0x528aae,
	0x528aae, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0x528aae,
	0x528aae, 0x528aae, 0x528aae, 0x528aae, 0x528aae, 0x528aae, 0x528aae, 0x528aae,
	0x528aae, 0x99d9ea, 0x99d9ea, 0x99d9ea, 0x99d9ea, 0x99d9ea, 0x99d9ea, 0x528aae,
	0x528aae, 0x99d9ea, 0x99d9ea, 0x99d9ea, 0x99d9ea, 0x528aae,
  	0x528aae, 0x528aae, 0x528aae, 0x528aae,

bowl_x: .word 14
bowl_y: .word 6
bowl_offsets: .word 1, 0, 0, 0, 1, 2
bowl_widths: .word 6, 8, 8, 8, 6, 4
bowl_color: .word 0x528aae

poison_x: .word 20
poison_y: .word 40
poison_offsets: .word 3, 0, 1, 0, 1, 0, 1, 0, 1
poison_widths: .word 3, 7, 5, 6, 5, 7, 7, 9, 7

poison:
	.word 0x000000, 0x000000, 0x000000,
	0x008000, 0x008000, 0x000000, 0xffffff, 0xffffff, 0xffffff, 0x000000,
	0x008000, 0x008000, 0x000000, 0xffffff, 0x000000,
	0x008000, 0xcce5ff, 0x008000, 0x000000, 0x008000, 0x000000,
	0x008000, 0xcce5ff, 0x000000, 0x008000, 0x000000,
	0x008000, 0xcce5ff, 0x000000, 0x008000, 0x008000, 0x008000, 0x000000,
	0x000000, 0x008000, 0x008000,0x008000, 0x008000, 0x008000, 0x000000,
	0x000000, 0x008000, 0x008000, 0x008000,0x008000, 0x008000, 0x008000, 0x008000, 0x000000,
	0x000000, 0x000000, 0x000000,0x000000, 0x000000, 0x000000, 0x000000, 0x000000

water_x: .word  48
water_y: .word  4
water_offsets: .word 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2
water_widths:  .word 2, 4, 6, 6, 6, 6, 6, 6, 6, 6, 4
water_main: .word 0x00008B
water:
    .word 0x00008B, 0x00008B,
          0x00008B, 0xFFFFFF, 0xFFFFFF, 0x00008B,
          0x00008B, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0x00008B,
          0x00008B, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0x00008B,
          0x00008B, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0x00008B,
          0x00008B, 0xCCCCCC, 0xCCCCCC, 0xCCCCCC, 0xCCCCCC, 0x00008B,
          0x00008B, 0xCCCCCC, 0xCCCCCC, 0xCCCCCC, 0xCCCCCC, 0x00008B,
          0x00008B, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0x00008B,
          0x00008B, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0x00008B,
          0x00008B, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0xADE7F3, 0x00008B,
          0x00008B, 0x00008B, 0x00008B, 0x00008B

mushroom_x: .word 25
mushroom_y: .word 44
mushroom_offsets: .word 1, 0, 0, 2, 2
mushroom_widths:  .word 3, 5, 5, 1, 1
mushroom:
    .word 0xB22222, 0xB22222,0xB22222
          0xB22222, 0xB22222, 0xB22222, 0xB22222,0xB22222,
          0xB22222, 0xB22222, 0xB22222, 0xB22222, 0xB22222,
          0xba9e88,
          0xba9e88
mushroom_dir: .word 0 			#0 is moving right , 1 is moving left
bmushroom_x: .word 15
bmushroom_y: .word 44
bmushroom:
    .word 0x9fa8da, 0x9fa8da,0x9fa8da,
          0x9fa8da, 0x9fa8da, 0x9fa8da, 0x9fa8da,0x9fa8da,
          0x9fa8da, 0x9fa8da, 0x9fa8da, 0x9fa8da, 0x9fa8da,
          0xba9e88,
          0xba9e88

soup_x: .word 13
soup_y: .word 17
soup_offsets: .word 3, 1, 0, 0, 0, 0, 1, 3
soup_widths:  .word 4, 8, 10, 10, 10, 10, 8, 4
soup:
    .word 0xececec, 0xececec,0xececec, 0xececec,
          0xececec, 0xececec, 0xfdd017, 0xfdd017,0xffe87c,0xee964d, 0xececec, 0xececec,
          0xececec,0xececec, 0xee964d,0xfdd017, 0xfdd017, 0xee964d, 0xfdd017, 0xee964d,0xececec,0xececec,
          0xececec, 0xee964d, 0xee964d, 0xfdd017, 0xffe87c, 0xffe87c, 0xfdd017, 0xee964d, 0xfdd017, 0xececec,
          0xececec, 0xececec, 0xececec,0xba9e88, 0xfdd017, 0xfdd017, 0xee964d, 0xececec, 0xececec, 0xededed,
          0xD1CBB3, 0xededed,, 0xededed, 0xececec, 0xececec, 0xececec, 0xececec, 0xededed,0xededed, 0xD1CBB3
          0xD1CBB3,0xD1CBB3, 0xededed, 0xededed, 0xededed, 0xededed,0xD1CBB3,0xD1CBB3,
          0xD1CBB3,0xD1CBB3, 0xD1CBB3,0xD1CBB3
.text
.globl main
main:
	#store base addr in temp registers
	lw $t0, level 
	# Check winning condition
	beq $t0, 4, draw_win_screen
	# draw current level
	beq $t0, 1, draw_level1
	beq $t0, 2, draw_level2
	beq $t0, 3, draw_level3
	
draw_level1:
	#lw $s5, health
	li $t0, BASE_ADDRESS
	li $t1, MAX_ADDRESS
	li $t2, BACKGROUND_COLOR
	
	jal draw_background

draw_tomato:	
	lw $a0, tomato_x
    	lw $a1, tomato_y
    	la $t6, tomato              # pointer to color data
    	la $t7, tomato_widths       # pointer to widths
    	la $t8, tomato_offsets      # pointer to x-offsets
    	li $s0, 5                  # number of rows
	jal draw_character

draw_bowl:
	lw $a0, bowl_x
    	lw $a1, bowl_y
    	la $t6, bowl              # pointer to color data
    	la $t7, bowl_widths       # pointer to widths
    	la $t8, bowl_offsets      # pointer to x-offsets
    	li $s0, 6                  # number of rows
	jal draw_character

draw_potato:
	lw $a0, potato_x
    	lw $a1, potato_y
    	la $t6, potato              # pointer to color data
    	la $t7, potato_widths       # pointer to widths
    	la $t8, potato_offsets      # pointer to x-offsets
 	li $s0, 5                  # number of rows

 	
	jal draw_character
	
draw_bug:
	lw $a0, bug_x
    	lw $a1, bug_y
    	la $t6, bug              # pointer to color data
    	la $t7, bug_widths       # pointer to widths
    	la $t8, bug_offsets      # pointer to x-offsets
    	li $s0, 6                  # number of rows
	jal draw_character

 	
draw_floor:
    	li $t0, MAX_ADDRESS          # Start from the end of the display
    	li $t6, BYTE_WIDTH           # $t6 = 256 (width of screen in units)
    	li $t3, FLOOR_COLOR          # $t3 = color
    	li $t7, FLOOR_HEIGHT         # $t7 = number of floor rows

    	mul $t6, $t6, $t7            # $t6 = total floor tiles = 256 * FLOOR_HEIGHT
    	sub $t0, $t0, $t6            # Move up that many tiles = starting address of floor

    	li $t4, FLOOR_HEIGHT         # Outer loop counter (rows)

floor_outer_loop:
    	li $t5, UNIT_WIDTH           # Inner loop counter = draw across one full row (64 tiles)

floor_inner_loop:
    	sw $t3, 0($t0)               # Store floor color
    	addi $t0, $t0, UNIT_SIZE     # Move right by one tile (4 bytes)
    	addi $t5, $t5, -1
    	bgtz $t5, floor_inner_loop

    	addi $t4, $t4, -1
    	bgtz $t4, floor_outer_loop

draw_platform:
	li $t2, PLATFORM_COLOR

	la $t8, platform_x              # base address of x array
	la $t9, platform_y              # base address of y array
    	la $t3, platform_len            # base address of platform length (in units)
    	li $t4, PLATFORM_NUM                       # number of platforms

draw_platform_loop:
	lw $a0, 0($t8)                  # load x
    	lw $a1, 0($t9)                  # load y (in pixels)
    	lw $t5, 0($t3)                  # load current length
    	
    	jal unit_to_addr      # returns address in $v0
    	move $t0, $v0          # $t0 = starting address of platform
    	
    	li $t1, 0                       # len of the platform
    	
draw_platform_row:
    	sw $t2, 0($t0)                  # write platform tile
    	addi $t0, $t0, UNIT_SIZE		# move right
    	addi $t1, $t1, 1		# increment
    	blt $t1, $t5, draw_platform_row

    	addi $t8, $t8, 4                # next x
    	addi $t9, $t9, 4                # next y
    	addi $t3, $t3, 4		# next len
    	addi $t4, $t4, -1		# decrement number of len
    	bgtz $t4, draw_platform_loop
    	j initial_draw_heart
 
draw_level2:
	li $t0, BASE_ADDRESS
	li $t1, MAX_ADDRESS
	li $t2, BACKGROUND_COLOR
	la $t3, gravity
	
	
	jal draw_background

draw_floor_l2:
    	li $t0, MAX_ADDRESS          # Start from the end of the display
    	li $t6, BYTE_WIDTH           # $t6 = 256 (width of screen in units)
    	li $t3, FLOOR_COLOR          # $t3 = color
    	li $t7, FLOOR_HEIGHT         # $t7 = number of floor rows

    	mul $t6, $t6, $t7            # $t6 = total floor tiles = 256 * FLOOR_HEIGHT
    	sub $t0, $t0, $t6            # Move up that many tiles = starting address of floor

    	li $t4, FLOOR_HEIGHT         # Outer loop counter (rows)

floor_outer_loop_l2:
    	li $t5, UNIT_WIDTH           # Inner loop counter = draw across one full row (64 tiles)

floor_inner_loop_l2:
    	sw $t3, 0($t0)               # Store floor color
    	addi $t0, $t0, UNIT_SIZE     # Move right by one tile (4 bytes)
    	addi $t5, $t5, -1
    	bgtz $t5, floor_inner_loop_l2

    	addi $t4, $t4, -1
    	bgtz $t4, floor_outer_loop_l2
   
draw_potato_l2:
	jal clear_potato
	
	# prepare arguments for drawing
	li $a0, POTATO_X_LT
    	li $a1, POTATO_Y_LT
    	
    	# store new addr
    	la $t1, potato_x
    	la $t2, potato_y
    	sw $a0, 0($t1)
    	sw $a1, 0($t2)

    	la $t6, potato              # pointer to color data
    	la $t7, potato_widths       # pointer to widths
    	la $t8, potato_offsets      # pointer to x-offsets
 	li $s0, 5                  # number of rows

	jal draw_character

draw_tomato_l2:	
	lw $t1, tomato_reached
	#tomato not reached
	beq $t1, 0, draw_pot

	lw $a0, tomato_x_l2
    	lw $a1, tomato_y_l2
    	la $t6, tomato              # pointer to color data
    	la $t7, tomato_widths       # pointer to widths
    	la $t8, tomato_offsets      # pointer to x-offsets
    	li $s0, 5                  # number of rows
	jal draw_character


draw_pot:
	# prepare arguments and calculate addr for pot body
	li $s0, POT_BODY_COLOR
	li $a0, POT_X_BODY
	li $a1, POT_Y_BODY

	jal unit_to_addr
 	
 	move $t0, $v0		# $t0 contains the addr for body
 	move $t1, $t0			# $t1, addr for current row
 
 	li $s1, 0		# row idx
 	li $s2, 0		# col idx

draw_pot_body:
	sw $s0, 0($t1)
	addi $t1, $t1, 4		# next unit
	addi $s2, $s2, 1		# increment col
	blt $s2, 13, draw_pot_body
	
	addi $s1, $s1, 1		# increment row
	li $s2, 0			# resest col
	# compute base addr for new row
	li $t4, 256
	mul $t3, $t4, $s1		
	add $t1, $t0, $t3

	blt $s1, 10, draw_pot_body

draw_pot_lid:
	li $s0, POT_LID_COLOR
	li $a0, POT_X_LID
	li $a1, POT_Y_LID
	
	jal unit_to_addr
 	
 	move $t0, $v0		# $t0 contains the addr for body
 
 	li $s1, 0		# col idx

draw_pot_lid_row:
	sw $s0, 0($t0)
	addi $t0, $t0, 4 
	addi $s1, $s1, 1
	blt $s1, 15, draw_pot_lid_row

draw_pot_top:
	li $s0, 0x222222
	li $a0, POT_X_TOP
	li $a1, POT_Y_TOP
	
	jal unit_to_addr
 	
 	move $t0, $v0		# $t0 contains the addr for body
 	move $t1, $t0			# $t1, addr for current row
 
 	li $s1, 0		# row idx
 	li $s2, 0		# col idx
	
draw_pot_top_loop:
	sw $s0, 0($t1)
	addi $t1, $t1, 4		# next unit
	addi $s2, $s2, 1		# increment col
	blt $s2, 3, draw_pot_top_loop

	addi $s1, $s1, 1		# increment row
	li $s2, 0			# resest col
	# compute base addr for new row
	li $t4, 256
	mul $t3, $t4, $s1		
	add $t1, $t0, $t3

	blt $s1, 2, draw_pot_top_loop

draw_poison:
	lw $a0, poison_x
    	lw $a1, poison_y
    	la $t6, poison              # pointer to color data
    	la $t7, poison_widths       # pointer to widths
    	la $t8, poison_offsets      # pointer to x-offsets
    	li $s0, 9                  # number of rows
	jal draw_character

draw_water:
	lw $a0, water_x
    	lw $a1, water_y
    	la $t6, water              # pointer to color data
    	la $t7, water_widths       # pointer to widths
    	la $t8, water_offsets      # pointer to x-offsets
    	li $s0, 11                  # number of rows
	jal draw_character

draw_platform_l2:
	li $t2, PLATFORM_COLOR

	la $t8, platform_x_l2              # base address of x array
	la $t9, platform_y_l2              # base address of y array
    	la $t3, platform_len_l2            # base address of platform length (in units)
    	li $t4, PLATFORM_NUM_LT                       # number of platforms

draw_platform_loop_l2:
	lw $a0, 0($t8)                  # load x
    	lw $a1, 0($t9)                  # load y (in pixels)
    	lw $t5, 0($t3)                  # load current length
    	
    	jal unit_to_addr      # returns address in $v0
    	move $t0, $v0          # $t0 = starting address of platform
    	
    	li $t1, 0                       # len of the platform
    	
draw_platform_row_l2:
    	sw $t2, 0($t0)                  # write platform tile
    	addi $t0, $t0, UNIT_SIZE		# move right
    	addi $t1, $t1, 1		# increment
    	blt $t1, $t5, draw_platform_row_l2

    	addi $t8, $t8, 4                # next x
    	addi $t9, $t9, 4                # next y
    	addi $t3, $t3, 4		# next len
    	addi $t4, $t4, -1		# decrement number of len
    	bgtz $t4, draw_platform_loop_l2
    	j initial_draw_heart
	

draw_level3:
	# back to original jump height
	li $t1, 12
	sw $t1, jump_height
	
	
	li $t0, BASE_ADDRESS
	li $t1, MAX_ADDRESS
	li $t2, BACKGROUND_COLOR
	
	jal draw_background

draw_floor_l3:
    	li $t0, MAX_ADDRESS          # Start from the end of the display
    	li $t6, BYTE_WIDTH           # $t6 = 256 (width of screen in units)
    	li $t3, FLOOR_COLOR          # $t3 = color
    	li $t7, FLOOR_HEIGHT         # $t7 = number of floor rows

    	mul $t6, $t6, $t7            # $t6 = total floor tiles = 256 * FLOOR_HEIGHT
    	sub $t0, $t0, $t6            # Move up that many tiles = starting address of floor

    	li $t4, FLOOR_HEIGHT         # Outer loop counter (rows)

floor_outer_loop_l3:
    	li $t5, UNIT_WIDTH           # Inner loop counter = draw across one full row (64 tiles)

floor_inner_loop_l3:
    	sw $t3, 0($t0)               # Store floor color
    	addi $t0, $t0, UNIT_SIZE     # Move right by one tile (4 bytes)
    	addi $t5, $t5, -1
    	bgtz $t5, floor_inner_loop_l3

    	addi $t4, $t4, -1
    	bgtz $t4, floor_outer_loop_l3
   
draw_potato_l3:
	jal clear_potato
	
	# prepare arguments for drawing
	li $a0, POTATO_X_LTH
    	li $a1, POTATO_Y_LTH
    	
    	# store new addr
    	la $t1, potato_x
    	la $t2, potato_y
    	
    	sw $a0, 0($t1)
    	sw $a1, 0($t2)

    	la $t6, potato              # pointer to color data
    	la $t7, potato_widths       # pointer to widths
    	la $t8, potato_offsets      # pointer to x-offsets
 	li $s0, 5                  # number of rows

	jal draw_character

draw_mushroom:
	lw $a0, mushroom_x
    	lw $a1, mushroom_y
    	la $t6, mushroom              # pointer to color data
    	la $t7, mushroom_widths       # pointer to widths
    	la $t8, mushroom_offsets      # pointer to x-offsets
    	li $s0, 5                  # number of rows
	jal draw_character
	
	j draw_bad_mushroom

redraw_mushroom:
	lw $a0, mushroom_x
    	lw $a1, mushroom_y
    	la $t6, mushroom              # pointer to color data
    	la $t7, mushroom_widths       # pointer to widths
    	la $t8, mushroom_offsets      # pointer to x-offsets
    	li $s0, 5                  # number of rows
    	
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
	jal draw_character
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra

draw_bad_mushroom:

	lw $a0, bmushroom_x
    	lw $a1, bmushroom_y
    	la $t6, bmushroom              # pointer to color data
    	la $t7, mushroom_widths       # pointer to widths
    	la $t8, mushroom_offsets      # pointer to x-offsets
    	li $s0, 5                  # number of rows
	jal draw_character


draw_soup:
	lw $a0, soup_x
    	lw $a1, soup_y
    	la $t6, soup              # pointer to color data
    	la $t7, soup_widths       # pointer to widths
    	la $t8, soup_offsets      # pointer to x-offsets
    	li $s0, 8                  # number of rows
	jal draw_character

draw_platform_l3:
	li $t2, PLATFORM_COLOR

	la $t8, platform_x_l3              # base address of x array
	la $t9, platform_y_l3              # base address of y array
    	la $t3, platform_len_l3            # base address of platform length (in units)
    	li $t4, PLATFORM_NUM_LTH                       # number of platforms

draw_platform_loop_l3:
	lw $a0, 0($t8)                  # load x
    	lw $a1, 0($t9)                  # load y (in pixels)
    	lw $t5, 0($t3)                  # load current length
    	
    	jal unit_to_addr      # returns address in $v0
    	move $t0, $v0          # $t0 = starting address of platform
    	
    	li $t1, 0                       # len of the platform
    	
draw_platform_row_l3:
    	sw $t2, 0($t0)                  # write platform tile
    	addi $t0, $t0, UNIT_SIZE		# move right
    	addi $t1, $t1, 1		# increment
    	blt $t1, $t5, draw_platform_row

    	addi $t8, $t8, 4                # next x
    	addi $t9, $t9, 4                # next y
    	addi $t3, $t3, 4		# next len
    	addi $t4, $t4, -1		# decrement number of len
    	bgtz $t4, draw_platform_loop
    	j initial_draw_heart

redraw_potato:
	lw $a0, potato_x
    	lw $a1, potato_y
    	la $t6, potato              # pointer to color data
    	la $t7, potato_widths       # pointer to widths
    	la $t8, potato_offsets      # pointer to x-offsets
 	
	jal draw_character
	
	lw $a0, potato_x
    	lw $a1, potato_y
    	la $t6, potato              # pointer to color data
    	la $t7, potato_widths       # pointer to widths
    	la $t8, potato_offsets      # pointer to x-offsets
	
	li $t1, BLOOD_COLOR
	j draw_damage

draw_background:
	
	sw $t2, 0($t0) 		#start from base addr
    	addi $t0, $t0, UNIT_SIZE 		#increment one unit everytime
    	blt $t0, $t1, draw_background 		# if base addr = max addr, stop
    	
    	jr $ra



# Arguments:
# $a0 = x (in units)
# $a1 = y (in units)
# Returns:
# $v0 = address in memory to draw the pixel

unit_to_addr:
    	# Save used registers onto the stack
    	addi $sp, $sp, -40
    	sw $t0, 0($sp)
    	sw $t1, 4($sp)
    	sw $t2, 8($sp)
    	sw $t3, 12($sp)
    	sw $t4, 16($sp)
    	sw $t5, 20($sp)
    	sw $t6, 24($sp)
    	sw $t7, 28($sp)
    	sw $t8, 32($sp)
    	sw $t9, 36($sp)

    	li $t0, UNIT_WIDTH           # t0 = 64
    	mul $t1, $a1, $t0            # t1 = y * 64
    	add $t1, $t1, $a0            # t1 = y * 64 + x
    	li $t2, UNIT_SIZE            # t2 = 4
    	mul $t3, $t1, $t2            # t3 = offset in bytes
    	li $t4, BASE_ADDRESS         # t4 = base address
    	add $v0, $t4, $t3            # v0 = address

    	# Restore registers
    	lw $t0, 0($sp)
    	lw $t1, 4($sp)
    	lw $t2, 8($sp)
    	lw $t3, 12($sp)
    	lw $t4, 16($sp)
    	lw $t5, 20($sp)
    	lw $t6, 24($sp)
    	lw $t7, 28($sp)
    	lw $t8, 32($sp)
    	lw $t9, 36($sp)
    	addi $sp, $sp, 40

    	jr $ra

draw_character:
    	move $t9, $a0          # base x → $t9
    	move $s1, $a1          # base y → $s1

    	li $s2, 0                  # row index

draw_character_row:
    	lw $t0, 0($t7)             # width
    	lw $t1, 0($t8)             # x offset

    	add $t3, $t9, $t1          # temp x = base_x + offset
    	move $t4, $s1              # temp y = base_y + row index

    	move $t2, $t0              # pixel counter = width

    	# compute base address for row only once
    	move $a0, $t3              # x
    	move $a1, $t4              # y

    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	move $t0, $v0              # $t0 now points to base address of this row

draw_character_pixel:
    	lw $t5, 0($t6)             # get color
    	sw $t5, 0($t0)             # write color

    	addi $t0, $t0, UNIT_SIZE   # move to next pixel in memory
    	addi $t6, $t6, 4           # next color
    	addi $t2, $t2, -1
    	bgtz $t2, draw_character_pixel

    	addi $t7, $t7, 4           # next width
    	addi $t8, $t8, 4           # next offset
    	addi $s1, $s1, 1           # next y
    	addi $s2, $s2, 1
    	blt $s2, $s0, draw_character_row
    	
    	jr $ra
 
initial_draw_heart:
	jal draw_hearts
	j main_loop

draw_damage:
	li $t1, BLOOD_COLOR
	lw $t2, health		# load health
	beq $t2, 3, main_loop 		# no damage drawn
	beq $t2, 2, damage_level1	# level 1 damage
	beq $t2, 1, damage_level2	# level 1 damage
	beq $t2, 0, damage_level3	# level 1 damage

damage_level1:
	# hardcode blood
	la $a0, potato          # base address of the potato data

	li $a1, 11
	jal draw_blood
	
	li $a1, 17
	jal draw_blood

	li $a1, 21
	jal draw_blood

	j main_loop

damage_level2:
	# hardcode blood
	la $a0, potato          # base address of the potato data
	
	li $a1, 5
	jal draw_blood

	li $a1, 9
	jal draw_blood
	
	j main_loop
	
damage_level3:
	# hardcode blood
	la $a0, potato          # base address of the potato data
	
	li $a1, 13
	jal draw_blood

	li $a1, 19 
	jal draw_blood

	j main_loop

draw_blood:
	# Overwrite index 10
	sll $t2, $a1, 2           # offset = index * 4
	add $t0, $a0, $t2

	# update data
	sw $t1, 0($t0)
	jr $ra



main_loop: 
	# saved temps:
	# s4 = scores
	# $s5 = health
	# $s6 = potato_x
	# $a7 = potato_y
	
	# if health == 0, loose
	lw $s5, health
	beqz $s5, draw_end_screen
	
	lw $t0, level
	beq, $t0, 4, draw_win_screen
	
	# enemy movement control
	la $t0, enemy_counter
	lw $t1, 0($t0)
	addi $t1, $t1, -1
	sw $t1, 0($t0)

	bgtz $t1, skip_enemy_move  # wait for counter to reach 0

	# reset counter
	la $t2, enemy_speed
	lw $t3, 0($t2)
	sw $t3, 0($t0)
	
	#draw moving enemy for level 1
	jal moving_bug
	#draw moving enemy for level 3
	jal moving_mushroom

skip_enemy_move:
	# handle damage_state
	lw $t0, damage_state
    	blez $t0, skip_damage_decrement
    	addi $t0, $t0, -1
    	sw $t0, damage_state
    	skip_damage_decrement:

	# determine action by key pressed
	li $t9, 0xffff0000
	lw $t8, 0($t9)
	beq $t8, 1, key_pressed
	j check_gravity

handle_key:
	jal key_pressed

check_gravity:	
	#s4 is the gravity counter

	la $s4, gravity_counter
	lw $t0, 0($s4)
	addi $t0, $t0, -1
	sw $t0, 0($s4)

	# if counter > 0, skip gravity
	bgtz $t0, no_gravity

	#reset counter
	lw $t0, gravity
	sw $t0, 0($s4)


	la $s7, potato_y		# load addr of potato_y
	lw $s6, 0($s7)			# load value of potato_y

	addi $t2, $s6, 1	# compute new addr, one unit down
	bge $t2, 64, no_movement		# check if player is on the edge

	# gravity fall, check if platform underneath
	jal check_platform_down
	bne $v0, $zero, no_movement		# there is platform, not falling

	# gravity fall
	jal clear_potato

	addi $s6, $s6, 1
	sw $s6, 0($s7)		# move down one unit
	
	li $a0, 50       # 50ms
	li $v0, 32       # syscall sleep
	syscall

	j redraw_potato


no_gravity:
	li $a0, 50       # 50ms
	li $v0, 32       # syscall sleep
	syscall

	j main_loop

no_moving_mushroom:
	jr $ra
moving_mushroom:
	lw $t0, level
	bne, $t0, 3, no_moving_mushroom

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Load current position
	lw $s4, mushroom_x
	lw $t1, mushroom_y

	jal clear_mushroom

	# Update position (move right or left 1 pixel)
	
	lw $t0, mushroom_dir
	bge $s4, 55, set_left
	ble $s4, 25, set_right
	
	beq $t0, 1, move_mush_left

move_mush_right:
	addi $s4, $s4, 1
	j move_mushroom
move_mush_left: 
	addi $s4, $s4, -1 
	j move_mushroom
set_right:
	li $t1, 0
	sw $t1, mushroom_dir
	j move_mush_right

set_left:
	li $t1, 1
	sw $t1, mushroom_dir
	j move_mush_left

move_mushroom:
	# Store new position
	sw $s4, mushroom_x

	jal redraw_mushroom
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

no_moving_bug:
	jr $ra
moving_bug:
	lw $t0, level
	bne, $t0, 1, no_moving_bug

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Load current position
	lw $t1, bug_x
	lw $s4, bug_y

	jal clear_bug

	# Update position (move right or left 1 pixel)
	
	lw $t0, bug_dir
	ble $s4, 25, set_down
	bge $s4, 40, set_up
	
	beq $t0, 1, move_bug_down

move_bug_up:
	addi $s4, $s4, -1
	j move_bug
move_bug_down: 
	addi $s4, $s4, 1 
	j move_bug
set_up:
	li $t1, 0
	sw $t1, bug_dir
	j move_bug_up

set_down:
	li $t1, 1
	sw $t1, bug_dir
	j move_bug_down

move_bug:
	# Store new position
	sw $s4, bug_y

	jal redraw_bug
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra


redraw_bug:
	lw $a0, bug_x
    	lw $a1, bug_y
    	la $t6, bug              # pointer to color data
    	la $t7, bug_widths       # pointer to widths
    	la $t8, bug_offsets      # pointer to x-offsets
    	li $s0, 6                  # number of rows
 	
 	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal draw_character
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
	

key_pressed:

	lw $t2, 4($t9) 		# load the input of the keyboard
	beq $t2, 97, respond_to_a 		# input is a
	beq $t2, 100, respond_to_d 		# input is d
	beq $t2, 119, respond_to_w 		# input is w
	beq $t2, 114, respond_to_r		# input is r
	beq $t2, 113, respond_to_q		# input is q

	j main_loop

respond_to_r:
	# restore potato
	j main		# restart game

respond_to_q:
	j draw_end_screen		# j to end

respond_to_a:
	la $s7, potato_x		# load addr of potato_x
	lw $s6, 0($s7)		# load value of potato_x
	
	addi $t2, $s6, -1	# compute new addr
	ble $t2, 0, no_movement		# check if player is on the edge
	
	jal check_platform_left		# check if platform is hit
	bne $v0, $zero, no_movement  # if $v0 is 1, we hit platform

	jal clear_potato	#clear old potato

	#update new potato addr
	addi $s6, $s6, -1	# move one unit to the left
	sw $s6, 0($s7)
	
	j redraw_potato 		#redraw the screen


respond_to_d:
	la $s7, potato_x		# load addr of potato_x
	lw $s6, 0($s7)		# load value of potato_x
	bge $s6, 57, no_movement		# check if player is on the edge
	
	jal check_platform_right		# check if platform is hit
	bne $v0, $zero, no_movement  # if $v0 is 1, we hit platform
	
	jal clear_potato	#clear old potato
	
	#update new potato addr
	addi $s6, $s6, 1	# move one unit to the left
	sw $s6, 0($s7)

    	j redraw_potato 		#redraw the screen

	
respond_to_w:
	# check if on platform
	lw $t0, on_platform
	# if not on_platform, no jump
	beq $t0, 0, no_up_movement
	
valid_w:
	#change state to not on platform
	li $t0, 0
	sw $t0, on_platform

	la $s7, potato_y		# load addr of potato_y
	lw $s6, 0($s7)		# load value of potato_y
	lw, $s3, jump_height

jump_continue:
	beqz $s3, no_up_movement		#jump complete finished, redraw
	
	addi $t2, $s6, -1	# compute new addr, six units up
	ble $t2, 0, no_movement		# check if player is on the edge

	jal check_platform_up		# check if platform is hit
	bne $v0, $zero, no_up_movement  # if $v0 is 1, we hit platform

	jal clear_potato	#clear old potato
	
	#update new potato addr
	addi $s6, $s6, -1	# move one unit up
	sw $s6, 0($s7)
	
	#update counter
	addi $s3, $s3, -1
	
	j jump_continue

no_up_movement:
	j redraw_potato

    	
clear_mushroom:
	# Save base x and y
    	lw $a0, mushroom_x
    	lw $a1, mushroom_y
    	move $t9, $a0          # base x = $t9
    	move $s1, $a1          # base y = $s1

    	li $t5, BACKGROUND_COLOR     # pointer to color data
    	la $t7, mushroom_widths       # pointer to widths
    	la $t8, mushroom_offsets      # pointer to x-offsets

    	li $s0, 5                  # number of rows
    	li $s2, 0                  # row index
    	
    	j clear_potato_row

clear_bug:
	# Save base x and y
    	lw $a0, bug_x
    	lw $a1, bug_y
    	move $t9, $a0          # base x = $t9
    	move $s1, $a1          # base y = $s1

    	li $t5, BACKGROUND_COLOR     # pointer to color data
    	la $t7, bug_widths       # pointer to widths
    	la $t8, bug_offsets      # pointer to x-offsets

    	li $s0, 6                  # number of rows
    	li $s2, 0                  # row index
    	
    	j clear_potato_row

no_movement:
	j main_loop		# player is already on the edge, do nothing


clear_potato:
    	# Save base x and y
    	lw $a0, potato_x
    	lw $a1, potato_y
    	move $t9, $a0          # base x = $t9
    	move $s1, $a1          # base y = $s1

    	li $t5, BACKGROUND_COLOR     # pointer to color data
    	la $t7, potato_widths       # pointer to widths
    	la $t8, potato_offsets      # pointer to x-offsets

    	li $s0, 5                  # number of rows
    	li $s2, 0                  # row index

clear_potato_row:
    	lw $t0, 0($t7)             # width
    	lw $t1, 0($t8)             # x offset

    	add $t3, $t9, $t1          # temp x = base_x + offset
    	move $t4, $s1              # temp y = base_y + row index

    	move $t2, $t0              # pixel counter = width

clear_potato_pixel:
    	move $a0, $t3
    	move $a1, $t4
    	
    	# compute current addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
    	
    	sw $t5, 0($v0)             # write color

    	addi $t3, $t3, 1           # next x
    	addi $t2, $t2, -1
    	bgtz $t2, clear_potato_pixel

    	addi $t7, $t7, 4           # next width
    	addi $t8, $t8, 4           # next offset
    	addi $s1, $s1, 1           # next y
    	addi $s2, $s2, 1
    	blt $s2, $s0, clear_potato_row
 	jr $ra

check_platform_left:
	lw $s0, level
	beq $s0, 1, check_platform_left_level1
	beq $s0, 2, check_platform_left_level2
	beq $s0, 3, check_platform_left_level3

check_platform_left_level1:
 	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, 0xff0000	#tomato
    	li $t0, 0x000000	#bug
    	li $t7, 0x528aae	#bowl
 
    	lw $t8, potato_x
    	addi $t8, $t8, -1          # simulate left move
    	lw $t9, potato_y           # base y
    	la $t4, potato_offsets

    	li $s0, 0                  # row index


check_platform_row_left_level1:
    	lw $t5, 0($t4)             # offset for this row
    	add $a0, $t8, $t5          # new x = (x - 1) + offset
    	add $a1, $t9, $s0          # new y = base y + row index
    
    	# call unit_to_addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4


    	lw $t6, 0($v0)             # check color
    	beq $t6, $t7, next_level
    	beq $t6, $t0, hit_bug
    	beq $t6, $t1, hit_tomato
    	beq $t6, $t2, hit_platform
    	beq $t6, $t3, hit_platform
    	
    	addi $t4, $t4, 4           # move to next offset
    	addi $s0, $s0, 1           # next row
    	blt $s0, POTATO_ROWS, check_platform_row_left_level1

    	li $v0, 0
    	jr $ra
    	

check_platform_left_level2:
 	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, 0x008000	# poison color
    	lw $t0, water_main	# water colo
 
    	lw $t8, potato_x
    	addi $t8, $t8, -1          # simulate left move
    	lw $t9, potato_y           # base y
    	la $t4, potato_offsets

    	li $s0, 0                  # row index
 

check_platform_row_left_level2:
	lw $t5, 0($t4)             # offset for this row
    	add $a0, $t8, $t5          # new x = (x - 1) + offset
    	add $a1, $t9, $s0          # new y = base y + row index
    
    	# call unit_to_addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $t6, 0($v0)             # check color
    	beq $t6, 0x222222, next_level
    	beq $t6, $t0, hit_water
    	beq $t6, 0xff0000, hit_tomato_l2
    	beq $t6, $t1, hit_poison
    	beq $t6, $t2, hit_platform
    	beq $t6, $t3, hit_platform


    	addi $t4, $t4, 4           # move to next offset
    	addi $s0, $s0, 1           # next row
    	blt $s0, POTATO_ROWS, check_platform_row_left_level2

    	li $v0, 0
    	jr $ra

check_platform_left_level3:
 	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, MUSH_MAIN	# good muchsroom color
    	li $t0, BMUSH_MAIN	# bad muchsroom color
    	li $t7, SOUP_MAIN
 
    	lw $t8, potato_x
    	addi $t8, $t8, -1          # simulate left move
    	lw $t9, potato_y           # base y
    	la $t4, potato_offsets

    	li $s0, 0                  # row index
 

check_platform_row_left_level3:
	lw $t5, 0($t4)             # offset for this row
    	add $a0, $t8, $t5          # new x = (x - 1) + offset
    	add $a1, $t9, $s0          # new y = base y + row index
    
    	# call unit_to_addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $t6, 0($v0)             # check color
    	beq $t6, $t7, next_level
    	beq $t6, $t0, hit_bmush
    	beq $t6, $t1, hit_mush
    	beq $t6, $t2, hit_platform
    	beq $t6, $t3, hit_platform


    	addi $t4, $t4, 4           # move to next offset
    	addi $s0, $s0, 1           # next row
    	blt $s0, POTATO_ROWS, check_platform_row_left_level3

    	li $v0, 0
    	jr $ra
 
check_platform_right:
	lw $s0, level
	beq $s0, 1, check_platform_right_level1
	beq $s0, 2, check_platform_right_level2
	beq $s0, 3, check_platform_right_level3

check_platform_right_level1:
    	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, 0xff0000
    	li $t0, 0x000000

    	la $t5, potato_widths_offsets      # width pointer

    	lw $t6, potato_x           	# base x
    	addi $t6, $t6, 1		# new base x, one unit to right
    	lw $t7, potato_y          	# base y

    	li $t8, 0                  # row index

check_platform_row_right_level1:
    	lw $t4, 0($t5)             # width[row idx]

    	add $a0, $t6, $t4		# new x = base x + width[row idx]
    	add $a1, $t7, $t8          	# new y = base y + row idx
    	
    	# Compute current addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $s1, 0($v0)             # check color at current addr
    	beq $s1, $t0, hit_bug
    	beq $s1, $t1, hit_tomato
    	beq $s1, 0x528aae, next_level
    	beq $s1, PLATFORM_COLOR, hit_platform
    	beq $s1, FLOOR_COLOR, hit_platform
    	
    	
    	addi $t5, $t5, 4           # next width
    	addi $t8, $t8, 1           # next row
    	blt $t8, POTATO_ROWS, check_platform_row_right_level1

    	li $v0, 0                  # no collision
    	jr $ra

check_platform_right_level2:
    	li $t1, 0x008000	# poison color
    	li $t0, 0x00008B	# water colo

    	la $t5, potato_widths_offsets      # width pointer

    	lw $t6, potato_x           	# base x
    	addi $t6, $t6, 1		# new base x, one unit to right
    	lw $t7, potato_y          	# base y

    	li $s0, 0                  # row index

check_platform_row_right_level2:
    	lw $t4, 0($t5)             # width[row idx]

    	add $a0, $t6, $t4		# new x = base x + width[row idx]
    	add $a1, $t7, $s0          	# new y = base y + row idx
    	
    	# Compute current addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $s1, 0($v0)             # check color at current addr
    	beq $s1, $t0, hit_water
    	beq $s1, $t1, hit_poison
    	beq $s1, PLATFORM_COLOR, hit_platform
    	beq $s1, 0x000000, hit_platform		# poison outline color
    	beq $s1 POT_BODY_COLOR, hit_platform
    	beq $s1 POT_LID_COLOR, hit_platform
    	beq $s1, FLOOR_COLOR, hit_platform
    	beq $s1, 0x222222, next_level

    	addi $t5, $t5, 4           # next width
    	addi $s0, $s0, 1           # next row
    	blt $s0, POTATO_ROWS, check_platform_row_right_level2

    	li $v0, 0                  # no collision
    	jr $ra

check_platform_right_level3:
 	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, MUSH_MAIN	# good muchsroom color
    	li $t0, BMUSH_MAIN	# bad muchsroom color
    	li $t9, SOUP_MAIN

    	la $t5, potato_widths_offsets      # width pointer

    	lw $t6, potato_x           	# base x
    	addi $t6, $t6, 1		# new base x, one unit to right
    	lw $t7, potato_y          	# base y

    	li $s0, 0                  # row index

check_platform_row_right_level3:
    	lw $t4, 0($t5)             # width[row idx]

    	add $a0, $t6, $t4		# new x = base x + width[row idx]
    	add $a1, $t7, $s0          	# new y = base y + row idx
    	
    	# Compute current addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $s1, 0($v0)             # check color at current addr
    	beq $s1, $t0, hit_bmush
    	beq $s1, $t1, hit_mush
    	beq $s1, $t2, hit_platform
    	beq $s1, $t3, hit_platform
    	beq $s1, $t9, next_level

    	addi $t5, $t5, 4           # next width
    	addi $s0, $s0, 1           # next row
    	blt $s0, POTATO_ROWS, check_platform_row_right_level3

    	li $v0, 0                  # no collision
    	jr $ra

check_platform_up:
	lw $s0, level
	beq $s0, 1, check_platform_up_level1
	beq $s0, 2, check_platform_up_level2
	beq $s0, 3, check_platform_up_level3

check_platform_up_level1:
    	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, 0xff0000
    	li $t0, 0x000000
    	

    	lw $t8, potato_x		# base x
    	lw $t9, potato_y           	# base y
    	addi $t9, $t9, -1           # update new addr, move up one unit, new base y
    	la $t4, potato_heads

    	li $s0, 0                  # col index

check_platform_col_up_level1:
    	lw $t5, 0($t4)		# heads for this col
    	add $a0, $t8, $s0		# new x = base x + col
    	add $a1, $t9, $t5          	# new y = base y + heads[col idx]

    	# unit_to_addr to compute new addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $t6, 0($v0)
    	beq $t6, 0x528aae, next_level             # check color
    	beq $t6, $t0, hit_bug
    	beq $t6, $t1, hit_tomato
    	beq $t6, $t2, hit_platform
    	beq $t6, $t3, hit_platform


    	addi $t4, $t4, 4           # move to next offset
    	addi $s0, $s0, 1           # next col
    	blt $s0, POTATO_COLS, check_platform_col_up_level1

    	li $v0, 0
    	jr $ra

check_platform_up_level2:
    	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, 0x008000	# poison color
    	lw $t0, water_main	# water color

    	lw $t8, potato_x		# base x
    	lw $t9, potato_y           	# base y
    	addi $t9, $t9, -1           # update new addr, move up one unit, new base y
    	la $t4, potato_heads

    	li $s0, 0                  # col index

check_platform_col_up_level2:
    	lw $t5, 0($t4)		# heads for this col
    	add $a0, $t8, $s0		# new x = base x + col
    	add $a1, $t9, $t5          	# new y = base y + heads[col idx]

    	# unit_to_addr to compute new addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $t6, 0($v0)             # check color
  	beq $t6, $t0, hit_water
    	beq $t6, $t1, hit_poison
    	beq $t6, $t2, hit_platform
    	beq $t6, $t3, hit_platform
    	

    	addi $t4, $t4, 4           # move to next offset
    	addi $s0, $s0, 1           # next col
    	blt $s0, POTATO_COLS, check_platform_col_up_level2

    	li $v0, 0
    	jr $ra

check_platform_up_level3:
    	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR

    	lw $t8, potato_x		# base x
    	lw $t9, potato_y           	# base y
    	addi $t9, $t9, -1           # update new addr, move up one unit, new base y
    	la $t4, potato_heads

    	li $s0, 0                  # col index

check_platform_col_up_level3:
    	lw $t5, 0($t4)		# heads for this col
    	add $a0, $t8, $s0		# new x = base x + col
    	add $a1, $t9, $t5          	# new y = base y + heads[col idx]

    	# unit_to_addr to compute new addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $t6, 0($v0)             # check color
    	beq $t6, $t2, hit_platform
    	beq $t6, $t3, hit_platform

    	addi $t4, $t4, 4           # move to next offset
    	addi $s0, $s0, 1           # next col
    	blt $s0, POTATO_COLS, check_platform_col_up_level3

    	li $v0, 0
    	jr $ra
 
check_platform_down:
	lw $s0, level
	beq $s0, 1, check_platform_down_level1
	beq $s0, 2, check_platform_down_level2
	beq $s0, 3, check_platform_down_level3

check_platform_down_level1:
    	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, 0xff0000
    	li $t0, 0x000000

    	la $t5, potato_heights      # points to vertical height offsets

    	lw $t6, potato_x           # base x
    	lw $t7, potato_y           # base y
    	addi $t7, $t7, 1		# new y after one unit down

    	li $t8, 0                  # row index

check_platform_row_down_level1:
    	lw $s0, 0($t5)             # heights[row]

    	add $a0, $t6, $t8          # new x = base_x + row idx
    	add $a1, $t7, $s0          # new y = base_y + heights[row idx]

    	# compute new addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $s1, 0($v0)    
    	beq $s1, 0x528aae, next_level         # check color
    	beq $s1, $t2, hit_platform
    	beq $s1, $t3, hit_platform
    	beq $s1, $t0, hit_bug
    	beq $s1, $t1, hit_tomato

  
    	addi $t5, $t5, 4           # next width
    	addi $t8, $t8, 1           # next row
    	blt $t8, POTATO_COLS, check_platform_row_down_level1

    	li $v0, 0                  # no collision
    	jr $ra

check_platform_down_level2:
    	li $t1, 0xff0000
    	lw $t0, water_main


    	la $t5, potato_heights      # points to vertical height offsets

    	lw $t6, potato_x           # base x
    	lw $t7, potato_y           # base y
    	addi $t7, $t7, 1		# new y after one unit down

    	li $t9, 0                  # row index


check_platform_row_down_level2:
    	lw $s0, 0($t5)             # heights[row]

    	add $a0, $t6, $t9          # new x = base_x + row idx
    	add $a1, $t7, $s0          # new y = base_y + heights[row idx]

    	# compute new addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $s1, 0($v0)             # check if color is background or platform
    	beq $s1, PLATFORM_COLOR, hit_platform
    	beq $s1, FLOOR_COLOR, hit_platform
    	beq $s1, $t0, hit_water
    	beq $s1, $t1, hit_poison
    	beq $s1, POT_LID_COLOR, hit_platform
    	beq $s1, 0x222222, next_level
  
    	addi $t5, $t5, 4           # next width
    	addi $t9, $t9, 1           # next row
    	blt $t9, POTATO_COLS, check_platform_row_down_level2

    	li $v0, 0                  # no collision
    	jr $ra

check_platform_down_level3:
    	li $t2, PLATFORM_COLOR
    	li $t3, FLOOR_COLOR
    	li $t1, MUSH_MAIN	# bad muchsroom color
    	li $t0, BMUSH_MAIN	# good muchsroom color
    	li $t8, SOUP_MAIN

    	la $t5, potato_heights      # points to vertical height offsets

    	lw $t6, potato_x           # base x
    	lw $t7, potato_y           # base y
    	addi $t7, $t7, 1		# new y after one unit down

    	li $t9, 0                  # row index
   
check_platform_row_down_level3:
    	lw $s0, 0($t5)             # heights[row]

    	add $a0, $t6, $t9          # new x = base_x + row idx
    	add $a1, $t7, $s0          # new y = base_y + heights[row idx]

    	# compute new addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	lw $s1, 0($v0)             # check if color is background or platform
    	beq $s1, $t2, hit_platform
    	beq $s1, $t3, hit_platform
    	beq $s1, $t0, hit_bmush
    	beq $s1, $t1, hit_mush
    	beq $s1, $t8, next_level
  
    	addi $t5, $t5, 4           # next width
    	addi $t9, $t9, 1           # next row
    	blt $t9, POTATO_COLS, check_platform_row_down_level3

    	li $v0, 0                  # no collision
    	jr $ra


 

hit_platform:
	li $t0, 1
	sw $t0, on_platform

	li $v0, 1
	jr $ra

hit_tomato:
	#addi $s4, $s4, 1
	li $t1, 1
	sw $t1, tomato_reached

clear_tomato:
    	# Save base x and y
    	lw $a0, tomato_x
    	lw $a1, tomato_y
    	move $t9, $a0          # base x = $t9
    	move $s1, $a1          # base y = $s1

    	li $t5, BACKGROUND_COLOR              # pointer to bg color
    	la $t7, tomato_widths		# pointer to widths
    	la $t8, tomato_offsets		# pointer to x-offsets

    	li $s0, TOMATO_ROWS                  # number of rows
    	li $s2, 0                  # row index
    		
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal clear_character
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
 	
 	li $v0, 1
    	jr $ra


hit_tomato_l2:
	#pick up effect, jump higher
	li $t1, 40
	sw $t1, jump_height

clear_tomato_l2:
    	# Save base x and y
    	lw $a0, tomato_x_l2
    	lw $a1, tomato_y_l2
    	move $t9, $a0          # base x = $t9
    	move $s1, $a1          # base y = $s1

    	li $t5, BACKGROUND_COLOR              # pointer to bg color
    	la $t7, tomato_widths		# pointer to widths
    	la $t8, tomato_offsets		# pointer to x-offsets

    	li $s0, TOMATO_ROWS                  # number of rows
    	li $s2, 0                  # row index
    		
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal clear_character
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
 	
 	li $v0, 1
    	jr $ra
 

hit_bmush:
	#lower gravity to 15
	li $t1, 20
	sw $t1, gravity
	sw $t1, gravity_counter
	

clear_bmush:
    	# Save base x and y
    	lw $a0, bmushroom_x
    	lw $a1, bmushroom_y
    	move $t9, $a0          # base x = $t9
    	move $s1, $a1          # base y = $s1

    	li $t5, BACKGROUND_COLOR              # pointer to bg color
    	la $t7, mushroom_widths		# pointer to widths
    	la $t8, mushroom_offsets		# pointer to x-offsets

    	li $s0, 5                 # number of rows
    	li $s2, 0                  # row index
    		
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal clear_character
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
 
 	li $v0, 1
    	jr $ra

hit_mush:
	# check if already in damaged state
    	lw $t0, damage_state
    	bgtz $t0, skip_dam   # still invincible, skip damage

    	sub $s5, $s5, 1		# collide with enemy, health decreases by 1
    	sw $s5, health		# update health in memory

    	li $t0, 3             # 3-frame cooldown
    	sw $t0, damage_state
 
    	addi $sp, $sp, -4
    	sw $ra,0($sp)
    	jal clear_heart
    	lw $ra,0($sp)
    	addi $sp, $sp, 4

skip_dam:
    	li $v0, 1
    	jr $ra


hit_bug:
	# check if already in damaged state
    	lw $t0, damage_state
    	bgtz $t0, main_loop   # still invincible, skip damage

    	sub $s5, $s5, 1		# collide with enemy, health decreases by 1
    	sw $s5, health		# update health in memory

    	li $t0, 3             # 3-frame cooldown
    	sw $t0, damage_state
    	
    	addi $sp, $sp, -4
    	sw $ra,0($sp)
    	jal clear_heart
    	lw $ra,0($sp)
    	addi $sp, $sp, 4

    	li $v0, 1
    	jr $ra
    	
    	#j redraw_potato		# draw damaged potato
	#j main_loop

hit_water:
	#power up effect

	#restore health
	li $t0, 3
	la $t1, health
	sw $t0, 0($t1)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal draw_hearts
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	

clear_water:
	# Save base x and y
    	lw $a0, water_x
    	lw $a1, water_y
    	move $t9, $a0          # base x = $t9
    	move $s1, $a1          # base y = $s1

    	li $t5, BACKGROUND_COLOR              # pointer to bg color
    	la $t7, water_widths		# pointer to widths
    	la $t8, water_offsets		# pointer to x-offsets
	li $s0, 11                  # number of rows

	addi $sp, $sp, -4
	sw $ra, 0($sp)
    	jal clear_character
    	lw $ra, 0($sp)
	addi $sp, $sp, 4

	li $v0, 1
    	jr $ra


clear_character:
	li $s2, 0                  # row index

clear_character_row:
    	lw $t0, 0($t7)             # width
    	lw $t1, 0($t8)             # x offset


    	add $t3, $t9, $t1          # temp x = base_x + offset
	add $t4, $s1, $s2          # temp y = base_y + row index
    	    	
    	move $a0, $t3
    	move $a1, $t4

    	
    	# compute new addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
    	
    	move $t6, $v0		# $t9 = base addr for the row
    	move $t2, $t0              # pixel counter = width

clear_character_pixel:
    	sw $t5, 0($t6)             # write bg color

    	addi $t6, $t6, 4           # next addr
    	addi $t2, $t2, -1
    	bgtz $t2, clear_character_pixel

    	addi $t7, $t7, 4           # next width
    	addi $t8, $t8, 4           # next offset
    	addi $s2, $s2, 1
    	blt $s2, $s0, clear_character_row
 
    	jr $ra

hit_poison:
# check if already in damaged state
    	lw $t0, damage_state
    	bgtz $t0, main_loop   # still invincible, skip damage

    	sub $s5, $s5, 1		# collide with enemy, health decreases by 1
    	sw $s5, health		# update health in memory

    	li $t0, 3             # 3-frame cooldown
    	sw $t0, damage_state
 
#pick up effect enemy bigger
draw_poison_explode:
	li $a0, 24
	li $a1, 40
		
	# compute new addr
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
	
	move $t1, $v0
	
	li $s0, 20 	#row idx of 20
	li $t3, 0x008000	#poison color
draw_explode_loop:
	
	sw $t3, 0($t1)
	addi $s0, $s0, -1
	addi $t1, $t1, -256
	bgtz $s0, draw_explode_loop
	
	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal clear_heart
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	li $v0, 1
    	jr $ra
    	

draw_hearts:
	lw $s5, health
    	li $s0, 0                   # heart index (i = 0)

draw_hearts_loop:

    	li $t2, HP_Y                   # y row where hearts are drawn (e.g., row 1)
    	li $t4, HP_X                   # starting x position
    	mul $t3, $s0, 6             # compute i * 6
    	add $t5, $t4, $t3           # final x = 1 + i*6
 
	#prepare x and y
    	move $a0, $t5              
    	move $a1, $t2
 
    	# draw one heart
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal draw_one_heart
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
  
    	addi $s0, $s0, 1
    	blt $s0, $s5, draw_hearts_loop  # if i < health, keep drawing

    	jr $ra

draw_one_heart:
    	move $t0, $a0          # base x = $t0
    	move $t1, $a1          # base y = $t1

    	la $t6, heart              # pointer to color data
    	li $s1, 0                  # cuurent row index

draw_heart_row:
    	li $s2, 0              		# load width
    	add $t3, $t1, $s1              # temp y = base_y + row idx

draw_heart_color:
    	add $t2, $t0, $s2 		# temp x = base x + width idx
    	lw $t5, 0($t6)             # get color
    	beq $t5, 0x000000, replace_hearts		#if white, replace with floor color

draw_heart_pixel:
	# prepare x and y to calculate addr
    	move $a0, $t2		
    	move $a1, $t3
 
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	sw $t5, 0($v0)             # write color

    	addi $t2, $t2, 1           	# x in next col
    	addi $t6, $t6, 4          	# next color
    	addi $s2, $s2, 1		# width = width + 1
    	blt $s2, 5, draw_heart_color	# draw next unit

    	addi $s1, $s1, 1		# next row	
    	blt $s1, 4, draw_heart_row	# draw next row
 
    	jr $ra		# finished one heart

replace_hearts: 
	li $t5, FLOOR_COLOR	#replace with floor color
	j draw_heart_pixel

clear_heart:
	li $t1, HP_Y                   # y row where hearts are drawn (e.g., row 1)
    	li $t4, HP_X                   # starting x position
    	mul $t3, $s5, 6             # compute i * 6

    	add $t0, $t4, $t3           # final x = 1 + i*6
    	li $s1, 0                  # curent row index

clear_heart_row:
    	li $s2, 0              		# load width
    	add $t3, $t1, $s1              # temp y = base_y + row idx
    	li $t5, FLOOR_COLOR	#replace with bg color

clear_heart_color:
    	add $t2, $t0, $s2 		# temp x = base x + width idx

clear_heart_pixel:
	# prepare x and y to calculate addr
    	move $a0, $t2		
    	move $a1, $t3
 
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	sw $t5, 0($v0)             # write color

    	addi $t2, $t2, 1           	# x in next col
    	addi $s2, $s2, 1		# width = width + 1
    	blt $s2, 5, clear_heart_color	# draw next unit

    	addi $s1, $s1, 1		# next row	
    	blt $s1, 4, clear_heart_row	# draw next row
 
    	jr $ra		# finished one heart


draw_end_screen:
	# draw game over screen
	li $t0, BASE_ADDRESS
	li $t1, END_COLOR
	li $t2, MAX_ADDRESS

draw_end_background:
	sw $t1, 0($t0) 		#start from base addr
    	addi $t0, $t0, UNIT_SIZE 		#increment one unit everytime
    	blt $t0, $t2, draw_end_background 		# if base addr = max addr, stop

draw_game_over:
	#draw game over on the screen
	
	lw $a0, g_x
	lw $a1, g_y
	la $a2, g
	jal draw_word
	
	lw $a0, a_x
	lw $a1, a_y
	la $a2, a
	jal draw_word
	
	lw $a0, m_x
	lw $a1, m_y
	la $a2, m
	jal draw_word
	
	lw $a0, e_x
	lw $a1, e_y
	la $a2, e
	jal draw_word
	
	
	lw $a0, o_x
	lw $a1, o_y
	la $a2, o
	jal draw_word
	
	lw $a0, v_x
	lw $a1, v_y
	la $a2, v
	jal draw_word
	
	lw $a0, ee_x
	lw $a1, ee_y
	la $a2, e
	jal draw_word
	
	lw $a0, r_x
	lw $a1, r_y
	la $a2, r
	jal draw_word
	
	
	j END

draw_word:
	# Parameters
	# $a0: x location of the letter
	# $a1: y location of the letter
	# $a2: colors

    	move $t0, $a0          # base x = $t0
    	move $t1, $a1          # base y = $t1

    	move $t6, $a2              # pointer to color data
    	li $s1, 0                  # cuurent row index

draw_word_row:
    	li $s2, 0              		# load width
    	add $t3, $t1, $s1              # temp y = base_y + row idx

draw_word_color:
    	add $t2, $t0, $s2 		# temp x = base x + width idx
    	lw $t5, 0($t6)             # get color
    	beq $t5, 0x000000, replace_word		#if white, replace with bg color

draw_word_pixel:
	# prepare x and y to calculate addr
    	move $a0, $t2		
    	move $a1, $t3
 
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	jal unit_to_addr
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4

    	sw $t5, 0($v0)             # write color

    	addi $t2, $t2, 1           	# x in next col
    	addi $t6, $t6, 4          	# next color
    	addi $s2, $s2, 1		# width = width + 1
    	blt $s2, 6, draw_word_color	# draw next unit

    	addi $s1, $s1, 1		# next row	
    	blt $s1, 6, draw_word_row	# draw next row
 
    	jr $ra

replace_word: 
	li $t5, END_COLOR	#replace with bg color
	j draw_word_pixel

draw_win_screen:
	# draw game over screen
	li $t0, BASE_ADDRESS
	li $t1, END_COLOR
	li $t2, MAX_ADDRESS

draw_win_background:
	sw $t1, 0($t0) 		#start from base addr
    	addi $t0, $t0, UNIT_SIZE 		#increment one unit everytime
    	blt $t0, $t2, draw_win_background 		# if base addr = max addr, stop

draw_you_win:
	lw $a0, y_x
	lw $a1, y_y
	la $a2, y
	jal draw_word
	
	lw $a0, oo_x
	lw $a1, oo_y
	la $a2, o
	jal draw_word
	
	lw $a0, u_x
	lw $a1, u_y
	la $a2, u
	jal draw_word
	
	lw $a0, w_x
	lw $a1, w_y
	la $a2, w
	jal draw_word
	
	lw $a0, i_x
	lw $a1, i_y
	la $a2, i
	jal draw_word
	
	lw $a0, n_x
	lw $a1, n_y
	la $a2, n
	jal draw_word
	
	j END


next_level:
	# move on to next level
    	lw $t1, level      
    	add $t1, $t1, 1
    	sw $t1, level
    	j main

END:	
    	li $v0, 10  # Exit program
    	syscall
