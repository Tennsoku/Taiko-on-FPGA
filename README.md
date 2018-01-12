# Taiko-on-FPGA
* ECE241 Project - Rhythm games on Nios2 FPGA
* All img and audio are converted to .mif, and due to the limit of VGA output and ram of FPGA board, these resources are relatively simplifed.
* Most parts of the proj are verilog.

* Inspired by a Japanese rhyme game - Taiko no tatsujin presented by Namco.  
  - To finish the game, player needs to accurately hit the patterns on screen, which stand for the beats of a song. 
  - Score will be received based on the timing of hitting, and a scoreboard will show the updated score on the screen and on the result page after finishing the song. 
  - The goal of this game is keeping trying to obtain higher score.

## Note Sequence
* The sequence of patterns appeared on the screen is fixed, since it is based on the beat of BGM. 
* The sequence is stored in the memory, initializing by mif, and is connected to a counter to give outputs at a constant rate corresponding to the beats per minute (BPM) of BGM. 
* Since there are 15 blocks for patterns moving on the screen, there is a FSM called sequenceManager to find block available for receiving the note(patterns that are still moving cannot receive new note before complete current note).

## Scoreboard
* Scoreboard records player’s game points, which are obtained when the player hit the sequence at the correct moment, also with the correct keys. The final score will be displayed at the screen each time the game ends, reflecting player’s performance to make the game more competitive. 
* Ten mif files are stored in FPGA memory corresponding to images of 0-9 numbers. Scoreboard has three digits in total, therefore it can record up to decimal base 999, and it will be reset to zero automatically for the next round of the game. 
* The status of each digit is stored in three different registers that have 4-bit width, with “0000” representing “0” and “1000” representing “9”. When the value inside the register exceeds the maximum, which is nine(1000), it will be set back to 0. The scores are added to the register of the first digit , the second digit is incremented by 1 when the first digit reach the maximum before it will be set to “0” . Increment of digit three is controlled by digit two in the same way.
* If 0000 is the current status of one of the digit, a 9to1 mux will choose image of  “0” stored beforehand to be display by VGA.

## Animated Background 
* Animating effect of the background is achieved by constantly changing backgrounds in sequence of six images extracted from a gif file. A 2Hz counter controls time for each images to stay at the screen to be exactly 0.5 second. 
* An “in_game” register determines when the counter comes into effect, otherwise the background stays the same at the “game beginning” and “game end” stages. 
