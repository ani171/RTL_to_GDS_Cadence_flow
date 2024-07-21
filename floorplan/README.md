# Floorplan

* Floorplanning is an early stage in the physical design flow of integrated circuits (ICs) where the layout of major functional blocks on a chip is defined. It involves arranging and optimizing the placement of these blocks to ensure efficient routing, minimize delays, and meet design specifications.
* Why is Floorplanning Essential?
    1. Optimal Layout: Defines the placement of major blocks, ensuring an efficient and organized chip layout.
    2. Interconnect Optimization: Reduces the length and complexity of interconnections between blocks, minimizing delays and improving performance.
    3. Area Utilization: Ensures that the chip area is used effectively, preventing wasted space and ensuring the design fits within the given constraints.
    4. Timing Requirements: Helps meet timing constraints by strategically placing blocks to minimize critical path delays.
    5. Design Rule Compliance: Ensures that the layout adheres to design rules and manufacturing constraints, preventing errors during fabrication.

**TOOL USED** : INNOVUS <br>
**INPUTS**: Constraints file (up_counter_incremental.sdc), IO file (up_counter.io), Technology mapped and optimized netlist file (up_counter_incremental.v) <br.

## Steps for floorplanning in Cadence Innovus

1. Navigate to the floorplan folder and invoke the cadence environment
```
csh
source /home/installs/cshrc
```
2. Open the Innovus tool
```
innovus
```
![image](https://github.com/user-attachments/assets/a17155b8-fb30-4405-82c8-a762ef628ad0)

3. In the Innovus GUI
    * Click on File option
    * Click ok Import design
4. In the Import design window
    * Add the netlist file is generated after synthesis. Note to add the power pads before importing
    * Select the `Auto assign` option
    * Select the lef files and add the required lef files according to the pdk being used
    * Declare the power and ground nets
    * For MMMC definition, click on `Create analysis Configuration`
     
   
