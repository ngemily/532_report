Milestone 6
-----------

I. Summary of milestone

- show Sobel on hardware, with Michael and Rob's help to integrate
- complete connected components and write location of objects to AXI registers

II. Status

Integration:

- integrated into group block design
- Sobel is showing up on HDMI output with some glitches

IP development:

- extended test bench to color merged labels, and draw dots to indicated centre of objects
- connected components labeling with merges is done
- connected components data collection is partially done
	- correctly finds centre of simple objects

III. Challenges faced

Integration:

- long compile time
- random hardware behaviour

IP development:

- getting cycles to line up; can't just access memory like in software
- failing setup time on merge table read address, need to pipeline

IV. Next week's milestones

- finalize interface to Microblaze so main software can be completed
- show connected components on HDMI display
- output locations of objects to AXI interface

V. Project modifications

- none so far

