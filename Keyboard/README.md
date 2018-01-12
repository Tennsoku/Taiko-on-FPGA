# PS-2 Input
* A five-state FSM is created to receive the signal came from PS/2 ports, and the outputs are set to be 6 enableN signal (easier to debug on board using KEY[3:0]).
* For the detailed state clarification:  
  - Prepare: reset state, wait for the first signal from input.
  - Enable: send output corresponding to signal input and wait for break signal.
  - BreakPoint: Activated when receive break signal. Change all the output to default.
  - Skip: Handle the signal received after break signal.
  - EndStep: For safety reasons. Set all regs to default and return to prepare state.
