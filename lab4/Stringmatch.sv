set 0      //acu = 0
st r14      //r14 = 0  count

set 9      //acu = 9
ld r1     //r1 = value from 9
set 0      //acu = 0
add r1     //acu = value from 9
sl 4 
sr 4 
st r1      //r1 = target  

set 31     //acu = 32 - 1 for the check of 96(not valid), will add 1 back at the start
st r6      // i = r6 = 32 


label loop_32_96

set 1 
add r6
st r6

set 96      // if i == 96, halt the program
equal r6
set end_program
beq

set 0 		//otherwise, normally execute the loop by loading curr and next
add r6 
ld r3
set 1
add r6
ld r4       //load value for curr, next

label head_0_7

//check whether head is (0-4) or (5,6,7)
set 5
st r7
set 0
add r5
equal r7
set case_5_6_7
beq
set 6
st r7
set 0         //accumulator = head
add r5        //accumulator = head
equal r7
set case_5_6_7
beq
set 7
st r7
set 0 
add r5
equal r7
set case_5_6_7
beq				//if head = 5, 6, 7, go to special case

//normal case, shift left and shift right, then add 1 to counter if match
set 4
st r8
set 0
add r3
sl r5
sr r8
equal r1
set 0
add r14
add r15         //count ++
st count
//check count within 255
set 255
st r7
set 0 
add r14
equal r7
set end_program
beq

// check out of bound case, handle looping
set 8
st r7
set 1
add r5
st r5
equal r7
set loop_32_96
beq
set head_0_7
j

label case_5_6_7
set 4
st r8
set 0
add r3
sl r6
sr r8 		//0000-xxx-0 similar case
st r2




set 12 		//shift right by 8 - head + 4
sub r5
st r9
set 0
add r4
sr r9
or r2
st r2
equal r1
set 0
add r14
add r15
st count

// check out of bound and handle looping 
set 8
st r7
set 1
add r5
st r5
equal r7
set loop_32_96
beq
set head_0_7
j



label end_program
set 10
sta r14
halt























