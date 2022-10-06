// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// PSEUDOCODE:

// INFINITELOOP:
//  while (true) {
//     if (key != 0):
//          goto BLACK
//     else:
//          goto WHITE

// BLACK:
//     if the screen black already:
//         goto INFINITELOOP
//     else:
//         colour = black (-1)
//         goto FILLOUT

// WHITE:
//     if the screen white already:
//         goto INFINITELOOP
//     else:
//         colour = white (0)
//         goto FILLOUT

// FILLOUT:
//     n = 8k - screen size
//     addr = screen base address
//     for(i=0; i!= n; i++){
//         @addr = colour
//         addr += 1
//     }
//     goto INFINITELOOP

@colour
M=0

(INFINITELOOP)
    @KBD
    D=M
    // if key pressed, black screen
    @BLACK
    D; JNE
    @WHITE
    D; JEQ
    @INFINITELOOP
    0; JMP

(WHITE)
    @SCREEN
    D=M
    // if screen already white then jump back to the main loop
    @INFINITELOOP
    D; JEQ
    // else make it white
    @colour
    M=0
    @FILLOUT
    0; JMP

(BLACK)
    @SCREEN
    D=M
    // if screen already black then jump back to the main loop
    @INFINITELOOP
    D; JLT
    // else make it black
    @colour
    M=-1
    @FILLOUT
    0; JMP

(FILLOUT)      
    @i      // counter
    M=0
    // number of iterations 8k - screen size
    @8000
    D=A
    @n
    M=D
    
    @SCREEN
    D=A
    @addr
    M=D     // base address of screen - 16384

    (LOOP0)
        @i
        D=M
        @n
        D=D-M
        // if i > n goto main loop
        @INFINITELOOP
        D; JEQ 
        // fill out with colour
        @colour
        D=M
        @addr
        A=M
        M=D

        @i
        M=M+1   // i++

        @addr
        M=M+1  // addr++

        @LOOP0
        0; JMP

    @FILLOUT
    0; JMP