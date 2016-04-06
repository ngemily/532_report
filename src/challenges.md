Challenges
----------

### Software/Hardware Paradigms

The biggest challenge I faced was the shift in mindset from software to
hardware.  This is the largest hardware project I have ever taken on, and
although I would not consider myself to be "experienced" per se in either, I
have had much more time to develop a mental model for writing imperative,
procedural software.

I've come to realize that there are two assumptions that I make every day that I
don't even think about when writing software:

1. Sequential semantics
2. Uniform latency across all operations

That is, each line that I write is executed in order and each result is
available on the next line.  As I write my verilog, I need to always think
instead about what circuit I am describing.  I need to consider that
combinational logic happens all at once, in parallel.  I need to consider that
results that pass through registers are not available until the following clock
cyle, and I may need to line things up.  Now, I know that in reality CPUs are
registers with combinational logic blocks in between them, but software writing
has these complications abstracted away by having an ISA to act as a contract
between hardware and software.

The best tool that I had here was drawing out diagrams before writing my Verilog
and checking the schematic in Vivado after writing my Verilog.  By consciously
making this effort, it became not hard in not too long to figure out how to
implement most of my software in hardware.

### Timing Closure

I soon ran into timing violations, to which the answer was always to register
and pipeline.  I'm lucky to have known to set clock constraints and report
timing on the IP I was writing without compiling the whole block design.  This
allowed me to quickly diagnose critical paths and rarely hit timing issues in
hardware.  I had on one occaision neglected to check the timing report and ended
up with a completely broken bitstream.


### Pipelining

I initially wrestled with how to insert pipelining into my Verilog in a sane
manner.  I quickly began to develop a skill for drawing pipeline diagrams.  This
experience further developed my understanding of sequential and combinational
logic, as well as timing logic to line up in a given cycle.  Looking at
simulations was key to debugging some early bugs here, and understanding again
how registers work.

### Integration

Integration went as smoothly as I could have hoped for.  Most of my work was
integrated into the team's in one week.  My stuff worked almost out of box
thanks to the confidence I had through simulation.


### Noise

