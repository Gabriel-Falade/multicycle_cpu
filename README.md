# Multi cycle cpu implementation 

## How does each module work?

### PC
PC module sole responsibility is keeping track of our program counter.
Inputs
- Clock: the clock of our cpu
- Reset 
- PCWriteCond: Comes from our control module. PC is written if zero output from ALU is also active (from control module)
- PCNext: next pc 
- Zero
- PCWrite: if active pc is written to (from control module) 

Output
- address: the pc (to memory)

### Mem
Shared storage array holding both program's instructions and any data your program uses

Inputs
- clk: clock
- MemRead: should you read from memory (from control module)
- MemWrite: should you write to memory (from control module)
- write_data: data that is written to memory (from registers)
- address: pc or ALUOut (from pc module or ALUOut)

Output
- mem_data: data that is read from register (to instruction register)

## ALU
The alu is in charge of the computation of the datapath. Based on alu_op the alu module will perform the correct calculations with the operands coming from srcA and srcB (these are the registers)
Inputs
srcA: register A (can either be pc or read data)
srcB: register B (can either be 4, read data, or immediate)
alu_op: operation for alu (from alu_control)

Outputs
zero: says if output of alu is zero (to control module)
alu_out: computation of alu (aluout)


## What I learned in each module 
### mem
- it is important to remember you are coding hardware not software. So once we initialize something it is there permanently (unless there's away to get rid of stuff that I have not learned). This is important when thinking about memory and initializing it
- we have to be careful when indexing mem array and using pc (program counter). PC can only be increments of four, but out memory array is 4 words (32 bits). This means for every one index of the memory array we have to + 4 to pc. To account for this we shift the pc to the right by 2 (divide by four) to match.
 
### imm_gen
- for case syntax the default case goes on the bottom

### alu 
- any signal inside an always or initial block must use reg as a declaration if outputting
- the default size of a reg is 1 so if you want a reg that is one bit wide then just declare reg
