The primary goal of functional verification is to confirm that the design, described using an HDL like Verilog or VHDL, correctly implements the specified functionality. This involves checking that the design meets all the requirements and specifications without any logical errors using tools such as Modelsim ,QuestaSim, Xcelium,etc. For Functional Verification we require the Design files and the Testbench of the Design written in HDL like Verilog or VHDL Through which we can generate a Waveform to
verify the functionality of the Design is correctly implemented as written in the Code.

**TOOL USED** : XELIUM  <br>
**INPUT FILES**: Design file (Counter.v) and Testbench file (CounterTB.v) <br>
**STEPS TO PERFORM SIMULATION** <br>
1. Invoke the Cadence tool in the folder where both the design and the testbench files are present
```
csh
source /home/installs/cshrc
```
2. Invoke the Xcelium simulation tool.
`Xrun Counter.v CounterTB.v -access +rwc -gui`
3. In the simulation window click on your design (here Conuter)
4. Select the required signals. Right-click and send to the waveform window
5. In the waveform window click on the run option, once the simulation is done verify your design 
