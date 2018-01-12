# Audio files stored in the memory: 
* Two feedback sounds for the keys and one background music(the BGM). 

A audio-control module is set to receive the signal coming from PS/2 part, and send output signal to the main module.
All sound files is modified to sample rate at 8000 Hz and turned to be 8-bit signal. A 8000 Hz counter is connected to memory. 
Data from memory is sent to audio port at rate, so then we can hear the music from speaker. 
Because of the limit of on-Chip memory, the longest BGM can stored is around 40 seconds.
The BGM address counter is activated when player start the game, and when background music is finishing, the audio module will send a signal to VGA part to print the result page.
