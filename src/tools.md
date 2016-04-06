Tools
-----

### Pen and Paper (and Printer)

My most invaulable possession relating to this project is my notebook.  In this
notebook I kept my milestone reports, meeting notes, notes on digital logic,
notes on image processing, debugging notes, block diagrams, schematics and
thoughts.  This is where I went to think about what I was going to implement
before I did so.  I also maintained a project log with short one line
descriptions of what I accomplished each day, which went a long way to
maintaining morale.

### Vivado

Running on a virtual machine, pulling up guis is expensive.  I worked almost
exclusively from the command line, using Vivado in batch mode, except to pull up
schematics.

#### RTL Viewer

#### Timing reports

Utilization reports, timing reports, and warnings were quite useful.

Autossh deserves a mention here, as I never dropped an ssh tunnel connection as
opposed to my team mates using Putty.  The only times I lost a connection was
when the remote went down.

### Modelsim

#### Testing

#### Debugging

#### Memory dump

I used Modelsim ASE extensively.  I used it first and foremost to check the
output whenever I was developing the core, in RTL sim.  This allowed me to check
the correctness of my work with a high degree of confidence in _seconds_,
without needing to fully compile my design.

I used it extensively for debugging.  Looking at the signals change each cycle
in some situations gave me good insight into what I was building.
