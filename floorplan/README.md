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

3. In the Innovus GUI
    * Click on the File option
    * Click ok Import design
![image](https://github.com/user-attachments/assets/a17155b8-fb30-4405-82c8-a762ef628ad0)

4. In the Import design window
    * Add the netlist file is generated after synthesis. Note to add the power pads before importing
    * Select the `Auto assign` option
    * Select the lef files and add the required lef files according to the pdk being used
    * Add in the IO file
    * Declare the power and ground nets
    * For MMMC definition, click on `Create analysis Configuration` <br>
            * In the library sets, add in the fast cells liberty file for minimum timing analysis and slow cells liberty file for maximum timing analysis <br>
            * Define the best and worst RC corners by specifying the appropriate temperature according to the PDK <br>
            * Define the best and worst operating conditions using the PVT values specified in the PDK <br>
            * Now specify the delay corners. Set the analysis to `On-Chip Variation`. Create maximum delay analysis using the worst RC corner and minimum analysis using the best RC corner. Note that Early timing would be related to the minimum timing and the best operating condition while the late timing would be related to maximum timing and worst operating condition <br>
            * In the `Constraints mode` option add in the sdc file obtained after technology mapping and optimization via synthesis stage <br>
    * Save the MMMC analysis defined file as a `.view` file
    * Click on OK, the die along with IO pads is now ready for the next stage
![image](https://github.com/user-attachments/assets/af0467a1-0846-4c23-883d-5fd63ed24f2b)

5. Once the design is imported, go to the `Floorplan` option and click on `Specify Floorplan`
6. Based on your approach, either define the core size or the die size and then define the space between the core and the IO boundary. The Core and Die width and height can be calculated based on the formulas below
![image](https://github.com/user-attachments/assets/b080ac83-6622-42d3-ae51-67a053696ca4)
7. Floorplanning is now completed and the design is now ready for the next process which is power planning. Save the file as an `.enc` file

     
   
