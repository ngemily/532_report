Milestone 3
-----------

I. Summary of milestone

- skeleton IP to interface with the rest of the system
- preliminary version of laser detecting IP
- set up tests to compare to software

II. Status

- surveyed possibilities for getting input in simulation, considered:
	- custom ASCII format data file ("VHDL test bench for digital image processing systems using a new image format" explores this idea)
	- existing image file format (e.g. bitmap)
- completed test bench that reads bitmap into memory, and writes memory to bitmap
https://github.com/ngemily/detectinator

III. Challenges faced

- milestone too ambitious

IV. Next week's milestones

- implement software functions from Milestone 2 as hardware modules that work on pixel stream input

V. Project modifications

- pushed start of Vivado IP project to next milestone, since it's not necessary for starting work on IP and not very useful until we begin integration
- laser detecting moved to Michael's responsibility
