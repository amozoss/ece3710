NUM_0: NUM 0b000001
NUM_1: NUM 0b000010
NUM_2: NUM 0b000011
NUM_3: NUM 0b000100
NUM_4: NUM 0b000101
NUM_5: NUM 0b000110
NUM_6: NUM 0b000111
NUM_7: NUM 0b001000
NUM_8: NUM 0b001001
NUM_9: NUM 0b001010
G: NUM 0b010001
P: NUM 0b011010
S: NUM 0b011101
COLON: NUM 0b100111
PLA: NUM 0b011010_010110_001011
YER: NUM 0b100011_001111_011100

#########################################################################
#
# Duckhunt
#
#
#   VAR stands for variable, just use a label to reserve a memory location
#
#
########################################################################
VAR_VGA_moveToX: xor $0, $0     # where to move the duck to 
VAR_VGA_moveToY: xor $0, $0     # where to move the duck to 
VAR_VGA_currentX: NUM 0b0    # current duck X pos
VAR_VGA_currentY: NUM 0b0    # current duck Y pos
VAR_moveDuckReturn: xor $0, $0  
VAR_p1Score: NUM 0b000001_000001 # NUM_0

# Load in the glyphs for the screen

loadPLA: movi loadYER, $12
  LBN $2, $1, 0x8654

  LBN $2, $13, P
  load $13, $13
  mov $1, $14
  LBN $2, $15, loadChar
  juc $15

loadYER: movi START, $12
  LBN $2, $1, 0x8655

  LBN $0, $2, NUM_1
  load $2, $2
  lshi 12, $2
  LBN $0, $3, COLON
  load $3, $3
  lshi 6, $3
  or $3, $2

  mov $2, $13
  mov $1, $14
  LBN $0, $15, loadChar

  juc $15


##############################################
#
# loadChar
#    
#    From 8654 to 8ca6 (8 is for memory map to glyph memory)
#     1620.to_s(16) => "654" 
#
#    Arguments
#     $12 return address
#     $13 char to draw (3 chars per 18 bit register)
#     $14 location
#
##############################################
loadChar: xor $0, $0
  stor $13, $14
  mov $12, $15
  juc $15


START: xor $0, $0


topLeftCorner: xor $0, $0

  movi 0, $14_y 
  movi 0, $13_x

  LBN $0, $12_return, bottomRightCorner

  LBN $0, $15, moveDuck
  juc $15

topRightCorner: LBN $0, $12_return, topLeftCorner
  movi 0, $14_y 

  LBN $0, $13_x, 0x240 # x = 640 - 64 = 576 = 0x240

  LBN $0, $15, moveDuck
  juc $15

bottomRightCorner: LBN $0, $12_return, bottomLeftCorner
  LBN $0, $13_x, 0x240 # x = 640 - 64 = 576 = 0x240
  
  LBN $0, $14_y, 0x1A0 # y = 480 - 64 = 416 = 0x1A0
  
  LBN $0, $15, moveDuck
  juc $15

bottomLeftCorner: LBN $0, $12_return, topRightCorner
  movi 0, $13_x 

  LBN $0, $14_y, 0x1A0 # y = 480 - 64 = 416 = 0x1A0

  LBN $0, $15, moveDuck
  juc $15


###################################
# moveDuck
#
#   arguments
#     $12 return address
#     $13 moveToX
#     $14 moveToY
#
##################################
moveDuck: xor $0, $0
  # Save arguments to memory
  LBN $0, $2, VAR_moveDuckReturn
  stor $12, $2 
  # store X
  LBN $0, $2, VAR_VGA_moveToX
  stor $13, $2 

  # store Y
  LBN $0, $2, VAR_VGA_moveToY
  stor $14, $2

  # moveCompleted uses 2 bits to specify when the duck has moved
  #    00 - x moving,  y moving
  #    01 - x moving,  y done
  #    10 - x done,    y moving
  #    11 - x done,    y done
  movi 0, $7_moveCompleted 

  # while(!moveCompleted) {
  moveDuckLoop: xor $0, $0
    
    LBN $0, $12, checkGunReturn
    LBN $0, $15, checkGun
    juc $15

    checkGunReturn: xor $1, $1
  
    movi sleep, $15
    LBN $0, $13, moveDuckSleepReturn
    movi 0x01, $14_sleepArg
    juc $15
    
    moveDuckSleepReturn: xor $0, $0


    # Load the x positions
    LBN $0, $3, VAR_VGA_moveToX
    load $3, $3
    LBN $0, $2, VAR_VGA_currentX
    load $1, $2
    
    # Branch when it reaches desired position
    # if (currentX == moveToX) {
      LBN $0, $15, setFinishedX
      cmp $3_moveToX, $1_currentX
      beq $15
    # }
    # else {
      # if (moveToX > currentX) {
        LBN $0, $15, addToX
        cmp $1_currentX, $3_moveToX
        bgt $15
      # }
      # else {
        LBN $0, $15, subFromX
        juc $15
      # }

      addToX: addui 1, $1 # add 1 to pos
        LBN $0, $15, finishedAddSubX
        juc $15
        
      subFromX: subi 1, $1 #sub 1 to pos

      finishedAddSubX: xor $5, $5

      lui 0xc0, $5
      stor $1, $5_vga_addr # update VGA

      stor $1, $2 # save currentX

      LBN $0, $15, finishedElseX
      juc $15
    # }
    
    setFinishedX: movi 0b10, $1 
    or $1, $7  # moveComplete = 10  (x done,    y ?)

    finishedElseX: xor $0, $0
    
    # Load the y positions
    LBN $0, $3, VAR_VGA_moveToY
    load $3, $3
    LBN $0, $2, VAR_VGA_currentY
    load $1, $2
    
    # Branch when it reaches desired position
    # if (currentY == moveToY) {
      LBN $0, $15, setFinishedY
      cmp $3_moveToY, $1_currentY
      beq $15
    # }
    # else {
      # if (moveToY > currentY) {
        LBN $0, $15, addToY 
        cmp $1_currentY, $3_moveToY
        bgt $15
      # }
      # else {
        LBN $0, $15, subFromY
        juc $15
      # }

      addToY: addui 1, $1 # add 1 to pos
        LBN $0, $15, finishedAddSubY
        juc $15
        
      subFromY: subi 1, $1 #sub 1 to pos

      finishedAddSubY: xor $5, $5
      
      lui 0xc0, $5
      addui 1, $5
      stor $1, $5_vga_addr # update VGA

      stor $1, $2 # save currentY

      LBN $0, $15, finishedElseY
      juc $15
    # }
    
      setFinishedY: movi 0b01, $1 
      or $1, $7  # moveComplete = 01  (x ?,    y done)
      
      finishedElseY: xor $0, $0

      # if (moveCompleted == 0b11) {
        LBN $0, $2, VAR_moveDuckReturn
        load $15, $2
        cmpi 0b11, $7
        beq $15
      # }
      # else {
        LBN $0, $15, moveDuckLoop
        juc $15
      # }
  # }

##############################################
#
# incrementP1Score
#
#   Adds $13 to p1's score
#    
#    Arguments
#     $12 return address
#     $14 which player
#
##############################################
incrementScore: xor $0, $0
  LBN $2, $1_loc, 0x8656

  mov $14, $3
  load $4, $3


  # if ( score > A) { # A is 9
    mov $4, $2
    lshi 12, $2
    rshi 12, $2 # isolate the ones

    LBN $0, $15, incTens
    cmpi 0xA, $2
    bgt $15
  # } 
  # else 
    incOnes: addi 1, $4 # inc the score
    LBN $0, $15, doneInc
    juc $15
  # }

  incTens: rshi 6, $4
    addi 1, $4
    lshi 6, $4
    movi 1, $5
    or $5, $4 # write a zero
    

  doneInc: xor $0, $0

  stor $4, $1 # write to screen

  stor $4, $3 # save the score

  mov $12, $15
  juc $15
  


##########################################3
# sleep
#
#   arguments
#     $14 loop count
#     $13 return address
#
############################################
sleep: xor $1, $1
  sleepLoop: LBN $0, $15, sleepLoop
  addui 1, $1
  cmp $1, $14
  bneq $15
  juc $13


#############################################
# 
# duckDied
#
#   $12 
#
################################################
duckDied: xor $0, $0
  # move duck off screen to pos (800, 800) or (0x320, 0x320)
  LBN $2, $1, 0x320

  lui 0xc0, $5
  stor $1, $5_vga_addr # update VGA
  
  addui 1, $5
  stor $1, $5_vga_addr # update VGA

  LBN $0, $2, VAR_VGA_currentX
  stor $1, $2
  LBN $0, $2, VAR_VGA_currentY
  stor $1, $2

  LBN $0, $15, sleep
  LBN $0, $13, duckDiedSleepReturn
  movi 0xff, $14_sleepArg
  juc $15

  duckDiedSleepReturn: xor $0, $0
    LBN $0, $15, topLeftCorner
    juc $15

  
##########################################33
# checkGun 
#
#
#    $12 return address
#
##############################################
checkGun: xor $0, $0
  # $5 holds the trig and sens bools, 
  #   01 - sens
  #   10 - trig
  xor $5, $5 # reset the bools

  #sens
  LBN $2, $1_loc, 0x8662

  LBN $0, $4, S

  load $4, $4
  lshi 6, $4

  movi 255, $3
  load $3, $3_sens # read sens
  or $3, $5 # save off the state
  addi 1, $3
  or $4, $3

  stor $3, $1

  # gun
  LBN $2, $1_loc, 0x8663

  LBN $0, $4, G
  load $4, $4
  lshi 6, $4

  movi 254, $3
  load $3, $3_trig # read trig
  mov $3, $2
  lshi 1, $2
  or $2, $5 # save off the state
  addi 1, $3
  or $4, $3

  stor $3, $1_loc

  # if ($5 != 3) {
    LBN $0, $15, dontIncScore
    cmpi 0b11, $5
    bneq $15
  # }
  # else {
    # increment the score
    movi 1, $13
    LBN $0, $14, VAR_p1Score
    LBN $0, $12, incScoreReturn

    LBN $0, $15, incrementScore
    juc $15
  # }
  
  incScoreReturn: xor $0, $0
    LBN $0, $15, duckDied
    juc $15

  dontIncScore: xor $0, $0

  juc $12




