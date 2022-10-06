// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// Put your code here.

// n = R1
// i = 0
// prd = 0;
// for (i; i < R1; i++){ prd += R0; }
// R2 = prd;
// END

    @R1
    D=M
    @n
    M=D // n = R1
    @i
    M=1 // i = 0
    @prd
    M=0 // prd = 0 (product)

(LOOP)
    @i
    D=M
    @n
    D=D-M
    @STOP
    D; JGT // if (i-R1) > 0 goto STOP (so if i > r1 goto STOP)

    // prd += R0
    @R0
    D=M
    @prd
    M=M+D

    // i++
    @i
    M =M+1

    @LOOP
    0; JMP

(STOP)
    // R2 = prd
    @prd
    D=M
    @R2
    M=D 

(END)
    // infinite loop
    @END
    0; JMP