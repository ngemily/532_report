Challenges
----------

### Software/Hardware Paradigms

The biggest challenge I faced was the shift in mindset from software to
hardware.  This is the largest hardware project I have ever taken on, and
although I would not consider myself to be in expert in either, I have had much
more time to develop a mental model for writing imperative, procedural software.

I've come to realize that there are two assumptions that I make every day that I
don't even think about when writing software:

1. Sequential semantics
2. Uniform latency across all operations

That is, each line that I write is executed in order and each result is
available on the next line.  As I write my verilog, I need to always think
instead about what circuit I am describing.  I need to consider that
combinational logic happens all at once, in parallel.  I need to consider that
results that pass through registers are not available until the following clock
cycle, and I may need to line things up.  

In reality CPUs have all the same limitations except that they are all hidden
behind the ISA.  This contract allows the programmer to safely write software
under these assumptions while the CPU architecture is free to finely schedule
these operations of various latencies.

The best tool that I had here was drawing out diagrams before writing my Verilog
and checking the schematic in Vivado after writing my Verilog.  By consciously
making this effort, it became not hard in not too long to figure out how to
implement most of my software in hardware.

### Timing Closure and Pipelining

As I started designing our video processing IP, I soon ran into timing
violations, to which the answer was always to register and pipeline.  It took a
considerable amount of time that I didn't account for in the original project
timeline to deal with timing closure.

I initially wrestled with how to insert systematically pipeline my design and
how to think about the data flow and dependencies in my design.  I quickly
developed a habit of drawing pipeline diagrams.  This experience further
developed my understanding of sequential and combinational logic, as well as
timing logic to line up in a given cycle.

### Noise

The real environment proved to be much more challenging than I had anticipated.
As a team, we scoped out our project such that we would control the environment
by having a plain monochrome background with some crisp images projected onto
it.  Unfortunately, lighting and camera quality made what we had hoped to be an
"easy" environment quite noisy.

It was especially hard because as we tried to deal with the noise, we would
break up the outlines of our objects.  Our design depends on the objects that we
are detecting to show up as a connected outline.  If it broke up into two, it
would be detected as two objects.  However, if there was too much noise it would
end up connected two objects that are in fact separate.  This lead to a constant
trade-off between rejecting noise and not being so aggressive as to break up the
outlines.
