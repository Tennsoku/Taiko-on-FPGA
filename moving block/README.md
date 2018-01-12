Every pattern of beat moving on the screen is controlled by an individual FSM. 
# 
The module has inputs from PS/2 part to find the pattern is hitted by the player or not, and is connected to a 64 Hz counter to generate X position showed on the screen (position Y is not changed). 
# 
Also there is an input of signal from noteSquence part to help the block to decide which kind of pattern should be showed and which input from key is correct input. If the pattern is hitted, a hitStatus is sent to scoreboard part to help calculate the score. The current state of the FSM is sent to note sequence manager to help read sequence. All other output is sent to Processor.
