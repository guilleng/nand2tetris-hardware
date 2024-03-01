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

@color
M=0         // Clear data/set default color as clear

(REFRESH)
    @i
    M=0
    @curr_addr
    M=0         // Clear the used data addresses

    @8192
    D=A
    @i
    M=M+D       // i is the number of 16-bit 'words' to set 256*512 / 16 = 8192
    @SCREEN
    D=A
    @curr_addr
    M=M+D       // Set curr_addr to hold the @SCREEN starting address

(PAINT)
    @color
    D=M         // Load 'color' to data register
    
    @curr_addr
    A=M
    M=D         // Write to current screen address

    @curr_addr
    D=M
    M=D+1       // Advance screen address (move 2 octets forward)
    
    @i
    M=M-1       // Decrement i
    D=M
    @PAINT
    D;JNE       // Loop while (i != 0)

(MAIN)
    @color
    M=-1        // Color settings -1 = 1111 1111 1111 1111
                //                 0 = 0000 0000 0000 0000

    @KBD
    D=M
    @REFRESH
    D;JNE       // If key is pressed, refresh with color setted as -1

    @color
    M=0         // Else, refresh with color setted as 0
    @REFRESH
    0;JMP
    @MAIN
    0;JMP
