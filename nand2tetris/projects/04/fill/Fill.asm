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

// Pseudocode
// if RAM[24576]!=0
//   loop all register for screen and write -1,(16 1s)
// else
//   go to top and start over.


// Put your code here.

(START)

@16384
D=A
@i
M=D        // i=16384
(LOOP)
@i
D=M
@24576
D=D-A     // D=i-24576
@START
D; JGE    // if i>=24576, jump to start
@24576
D=M        // get the value in keyboard memory
@BLACK     
D; JNE     // RAM[24756]!=0 jump to (BLACK)
@i         // else write 0.(WHITE)
A=M
M=0      // write RAM[i]=0
@STEP
0;JMP    // after write, go to step to increment i
(BLACK)
@i
A=M
M=-1      // write RAM[i]=-1
@STEP
0;JMP    // after write, go to step to increment i
(STEP)
@i
M=M+1     // i++
@LOOP
0;JMP     // loop

@START
0;JMP      // jump to start infinite loop

