# Logic synthesis
* The interconnection of logic gates is the process by which RTL is converted to an equivalent circuit.
![image](https://github.com/user-attachments/assets/7aeea6db-d2df-44f7-abc3-c34aed6f7b3c)
## Constraints
* Constraints guide the design flow, ensuring the circuit meets functionality and performance goals. They are applied during various steps in VLSI chip implementation to ensure timing, design rules, etc., are met. The Electronic Design Automation (EDA) tool uses these constraints as input.
* Purpose of Constraints
    * Guide design flow from initial synthesis to final implementation.
    * Ensure the circuit meets functionality and performance goals.
* Types of Constraints
    * Timing Constraints: Ensure signals arrive on time.
    * I/O Constraints: Specify input/output characteristics.
    * Area Constraints: Define physical space limits.
    * Power Constraints: Set power consumption limits.

**TOOL USED** - CADENCE GENUS
**INPUTS** - Constraints file (Counter_Constarints.sdc), Tcl file (run.tcl) , Design file (up_counter.v)
## Steps to perform Logic synthesis
1. Navigate to the synthesis folder and invoke the cadence environment
```
csh
source /home/installs/cshrc

```
2. Open the Genus tool
```
genus -gui 
```
3. Source Synthesis Script in the Genus command prompt
```
source Scripts/run.tcl

```
4. To View Schematic :
      * Click the ‘+’ icon.
      * Select ‘Schematic’ to view the design.

## Generated files
1. Generic Netlist
2. Technology-Mapped Netlist
3. Optimized Netlist
4. Technology-Mapped Constraint File
5. Area reports
6. Timing reports
7. Gate count reports

