Milestone 4
-----------

I. Summary of milestone

- implement software functions from Milestone 2 as hardware modules that work on pixel stream input

II. Status

- fixed bug in test bench; previously did not account for row padding
- implemented sobel operator
	- verified functionality in rtl sim 
	- checked synthesis and implementation in Vivado
	- passes timing at 100 MHz
- started on connected components in software
- added IP skeleton to team git repo

III. Challenges faced

- it's hard to write hardware
	- thinking in circuits vs sequential semantics
	- less experience
- having trouble getting post-syn, post-impl sim
	- Vivado won't generate libraries for Modelsim

IV. Next week's milestones

- iron out single pass connected components algorithm
- implement connected components in hardware

V. Project modifications

- detection IP milestones have been shifted back about a week
- clarification of integration work, aim for Milestone 6:
	- modify IP to accept input accordingly, after Rob has HDMI feed
	- work with team to integrate/debug our IP with microblaze
