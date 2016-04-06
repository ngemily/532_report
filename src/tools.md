Tools
-----

### Pen and Paper

My most invaulable possession relating to this project is my notebook.  In this
notebook I kept my milestone reports, meeting notes, notes on digital logic,
notes on image processing, debugging notes, block diagrams, schematics and
thoughts.  I frequently referred to and annotated older notes.  Overall it
helped me organize and develop my thoughts.

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

#### Debugging

#### Memory dump

I used Modelsim ASE extensively.  I used it first and foremost to check the
output whenever I was developing the core, in RTL sim.  This allowed me to check
the correctness of my work with a high degree of confidence in seconds, without
needing to fully compile my design.

I used it extensively for debugging.  Looking at the signals change each cycle
in some situations gave me good insight into what I was building.


### Autossh

Using autossh, I never dropped an ssh tunnel connection (as opposed to my team
mates using Putty).  The only times I lost a connection was when the remote went
down.  Droppend connections became a great source of annoyance to my teammates.
This was important to me because it  was one more source of workflow friction
that I avoided easily.
