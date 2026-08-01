# Multi cycle cpu implementation 

## How does each module work?

### PC
PC module sole responsibility is keeping track of our program counter.  The following are the inputs it receives, what each does and where it comes from 
Clock: the clock of our cpu
Reset 
PCWriteCond: Comes from our control module. PC is written if zero output from ALU is also active 
Zero: from alu 
PCWrite: if active pc is written to 

The output is the following 
address: the address of our pc

### Mem
The mem module is responsible for outputting the next address of our program
