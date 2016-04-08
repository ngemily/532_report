Tools
-----

### Pen and Paper

My most invaulable possession relating to this project is my notebook.  In this
notebook I kept my milestone reports, meeting notes, notes on digital logic,
notes on image processing, debugging notes, block diagrams, schematics and
thoughts.  I frequently referred to and annotated older notes.  Overall it
helped me organize and develop my thoughts.  Select pages from my notebook can
be found in Appendix \ref{app:notebook}.

### Verilog

Throughout this project, I learned to use more features of Verilog.  This is by
far the largest Verilog project I have taken on and I need to keep it modular
and easy to work with.  I used parameters and modules to organize my design
hierarchically.  I used macros in a header file to easily adjust bus widths and
access debug features.  Eventually, I wanted my design to compile differently
depending on if I was in simulation or compiling for hardware.  Here I used
Modelsim's interface for defining macros at compile time.

I hit a limitation with Modelsim ASE.  It doesn't support the use of
SystemVerilog asserts, which was unfortunate as it seemed like a good way to
introduce unit testing in my modules.

### Vivado

#### RTL Viewer

The first challenge in Verilog is to remember that it is a hardware description
language.  It is very easy to fall into procedural coding habits.  I often drew
out what I thought my design looked like and compared it to what I saw in the
RTL viewer.

#### Timing reports

I frequently checked the timing reports to get a sense of where the critical
paths were.  This allowed me to insert registers and incorporate pipelining
stages as required.

### Modelsim

#### Testing

After each change I used Modelsim to verify that my design was working.
Overall, this testing gave me a high degree of confidence that my design would
work in hardware.  My tests ran very quickly on small (550 x 300) bitmaps so my
main design iteration time was actually comparable to working with software.

#### Debugging

Modelsim was my main debug tool.  I used it extensively when things weren't
working.  Learning to work with the various features, such as saving wave views
or using the jump to next change buttons really sped debugging along.

#### Memory dump

Some components of my design in involved keeping data in tables.  Sometimes the
contents of these tables were the most useful information for debugging.  I used
Modelsim to dump the contents to text files to browse through the contents
easily.  This was especially helpful at times when the waveforms were
unnecessary.

### Autossh

Using autossh, I never dropped an ssh tunnel connection (as opposed to my team
mates using Putty).  The only times I lost a connection was when the remote went
down.  Droppend connections became a great source of annoyance to my teammates.
This was important to me because it  was one more source of workflow friction
that I avoided easily.
