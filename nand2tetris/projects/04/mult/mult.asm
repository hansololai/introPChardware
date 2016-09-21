// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)


// Pseudocode:
// temp=R0
// for (i=1;i<32768;i+=i) i=1,2,4,8,16,..,2^15
//     if R1 & i ==0:
//     else:
//         R2+=temp   // The way the jump code is simpler. 
//     temp+=temp
// Basically checking every bit in R1, if this is 0, then nothing, if it is 1, then add
// R0*2^i to the result. (This value is constructed as R0+= R0 many times)
//


// Put your code here.
@R2
M=0;
@R0 
D=M          // Copy R0 value to D, later it will be put in temp;
@temp        // setup memory for temp
M=D          // temp =D=R0

@i           // setup memory for i
M=1          // i=1



(LOOP)
@i
D=M          // D=i
@R1       
D=D-M        // D=i-R1
@END
D;JGT        // If i>R1, jump to end

@i
D=M          // D=i
@R1
D=M&D        // R1 & i save to D
@MULTIPLY
D; JNE       // If it is not 0, then go to MULTIPLY
@STEP 
0;JMP        // otherwise directoy go to step

(MULTIPLY)   // This section add temp to R2
@temp
D=M          // D=temp
@R2
M=D+M        // R2=R2+temp
@STEP
0;JMP        // go to step

(STEP)
@temp
D=M          // get the temp value
M=D+M        // M*2 and save to M; now temp = temp*2
@i
D=M          // get i
M=D+M        // i =i*2;
@LOOP 
0;JMP        // Go back to loop

(END)
@END
0;JMP        // stop here

