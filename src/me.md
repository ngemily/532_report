What I did
==========
<!--
Include discussions of items like:
- How was the project partitioned?
    - What did you do on the project?
    - How did you ensure that your part would work with the parts done by other members of
    your team?
    - Comment on the balance of work among your team members.
- What hurdles did you have to overcome?
- What other things did you learn about the various tools?
- What other tools did you try to use?
- What did you do to ensure success, or at least improve the likelihood of success?
    - what was your design flow?
    - what kind of source code control did you use?
    - what kind of simulations and/or testing did you do on your code?
- What modules did you write? How did you test them?
- What did you learn?
- Anything else you spent your time on (related to the project :-)
-->

Responsibilities
----------------

### Image Processing Research

#### Overview

>I was tasked with selecting an algorithm to do what we needed for our project,
prototyping it on software and implementing it in hardware.  I allocated one
week for research, one week for prototyping, two weeks for building and two
weeks for integration, which left one week buffer.

>Secondly, as I was prototyping in software, which in itself was a challenge, I
was supposed to consider the feasibility of hardware implementation.  At the
time, I thought that meant to avoid recursion and graph traversal.  I hadn't
really considered memory accesses and the challenge they would present as I
moved to hardware implementation.

Our aim was to identify objects and be able to recognize friends and foes.  The
objects were to be on a plain monochrome background and non overlapping.  This
task was broken down into the following smaller tasks: (1) locate non-background
objects (2) perform a binary classification of friend or foe.

This was performed in the following steps:

- grayscale
- edge detection
- flooding
- connected components analysis
- data extraction


#### Sobel

The Sobel operator is an image filter designed to extract edges by computing the
derivative at each pixel.  Gradients correlate well with edges because an even
surface contains pixels that are very similar to each other whereas pixels along
edges show a high level of difference, or gradient, along the direction of the
edge.

$$
G_y = 
\left(
\begin{matrix}
    -3 & -10 & -3 \\
     0 &   0 &  0 \\
    +3 & +10 & +3
\end{matrix}
\right)
\ast
A
$$

$$
G_x =
\left(
\begin{matrix}
     -3 & 0 &  +3 \\
    -10 & 0 & +10 \\
     -3 & 0 &  +3
\end{matrix}
\right)
\ast
A
$$

$$
G = \left|G_x\right| + \left|G_y\right|
$$

##### Grayscale

Grayscale was calculated using the ITU-R Rec. 601

$$ I = 0.299 R + 0.587 G + 0.114 B $$

##### Image Filter

Image filters can produce interesting effects, such as blur, sharpen, emboss, or
outline.  This diverse range of effects is achieved with a very simple and
compact computation.  It is performed by convolving an _image kernel_ with an
input image to produce an output image.  The kernel is a small matrix that
defines the resultant pixel as a weighted summation of the pixels in the window
surrounding it.  The output is computed by convolving at each input pixel a
window of the input with the kernel.

\begin{figure}
    \centering
    \begin{tikzpicture}[x=0.4cm,y=-0.4cm]

        % image
        \draw (0,0) -- (9,0) -- (9,9) -- (0,9)
            node[below,midway]{image} -- cycle;
        % grid
        \draw[step=0.4cm,gray,very thin] (0.1, 0.1) grid (8.9,8.9);
        % neighbourhood
        \draw[thick] (1,1) rectangle (4,4);

        \node at (10, 4.5) {$\ast$};

        % kernel
        \draw[thick] (11, 3) -- (14, 3) -- (14, 6) -- (11, 6)
            node[below,midway]{kernel} -- cycle;
        % grid
        \draw[step=0.4cm,gray,very thin] (10.9, 2.9) grid (13.9, 5.9);

        \node at (15, 4.5) {$=$};

        % result
        \draw (16,0) -- (25,0) -- (25,9) -- (16, 9)
            node[below,midway]{result} -- cycle;
        % grid
        \draw[step=0.4cm,gray,very thin] (16.1, 0.1) grid (24.9, 8.9);
        % neighbourhood
        \draw[thick] (18, 2) rectangle (19, 3);

    \end{tikzpicture}

    \caption{Image kernel convolution.}
    \label{fig:kernel}
\end{figure}


#### Flooding

#### Connected Components Analysis

\begin{figure}
    \centering

    \begin{subfigure}{0.3\linewidth}
    \centering
        \begin{tikzpicture}[x=.6cm,y=-.6cm]

            \draw[step=0.6cm,gray,very thin] (0, 0) grid (5, 5);

            \filldraw[fill=black,draw=white] (2, 1) rectangle (3, 2);
            \filldraw[fill=black,draw=white] (1, 2) rectangle (2, 3);
            \filldraw[fill=black,draw=white] (3, 2) rectangle (4, 3);
            \filldraw[fill=black,draw=white] (2, 3) rectangle (3, 4);

            \node at (2.5, 2.5) {p};

        \end{tikzpicture}
        \caption{4-connectivity}
    \end{subfigure}%
    \begin{subfigure}{0.3\linewidth}
        \centering
        \begin{tikzpicture}[x=.6cm,y=-.6cm]

            \draw[step=0.6cm,gray,very thin] (0, 0) grid (5, 5);

            \filldraw[fill=black,draw=white] (1, 1) rectangle (2, 2);
            \filldraw[fill=black,draw=white] (2, 1) rectangle (3, 2);
            \filldraw[fill=black,draw=white] (3, 1) rectangle (4, 2);
            \filldraw[fill=black,draw=white] (1, 2) rectangle (2, 3);
            \filldraw[fill=black,draw=white] (3, 2) rectangle (4, 3);
            \filldraw[fill=black,draw=white] (1, 3) rectangle (2, 4);
            \filldraw[fill=black,draw=white] (2, 3) rectangle (3, 4);
            \filldraw[fill=black,draw=white] (3, 3) rectangle (4, 4);

            \node at (2.5, 2.5) {p};

        \end{tikzpicture}
        \caption{8-connectivity}
    \end{subfigure}

    \caption{4- and 8- connectivity}
    \label{fig:connectivity}
\end{figure}

Connected components analysis is a method to extract information about objects
in a _binarized_ image.  _Connectivity_, illustrated in Figure
\ref{fig:connectivity}, is defined loosely as pixels that are touching each
other.  A _binarized_ image is an image where there are only two pixel values,
which represent background or non-background.  This method was used to locate
the different objects in view.


\begin{tikzpicture}[x=1cm,y=-1cm]

\draw (0, 0) grid (3, 2);

\node at (0.5, 0.5) {A};
\node at (1.5, 0.5) {B};
\node at (2.5, 0.5) {C};
\node at (0.5, 1.5) {D};
\node at (1.5, 1.5) {p};

\end{tikzpicture}

#### Location

Locations of objects were found by finding the centre of mass of the outlines.

#### Moment Invariants

Moment invariants were introduced by Hu in 1962 \cite{hu} as a means of uniquely
identifying an object.

##### Translational invariants

$$
u_{ij} = \sum_x \sum_y (x - \bar{x}) ^ i (y - \bar{y}) ^ j p_{ij}
$$

##### Scale invariants
$$
n_{ij} = \frac{u_{ij}}{u_{00} ^ {1 + \frac{i + j}{2}}}
$$

##### Rotational invariants

$$
\begin{aligned}
I_0 &= n_{20} + n_{02} \\
I_1 &= (n_{20} - n_{02}) ^ 2 + 4 n_{11}^2 \\
I_2 &= (n_{30} - 3 n_{12}) ^ 2 + (3 n_{21} - n_{03}) ^ 2 \\
I_3 &= (n_{30} + n_{12}) ^ 2 + (n_{32} + n_{03}) ^ 2 \\
I_4 &= (n_{30} - 3 n_{12}) (n_{30} + n_{12})
        \left((n_{30} + n_{12}) ^ 2 - 3 (n_{21} + n_{03}) ^ 2\right) \\
        &+ (3 n_{21} - n_{03}) (n_{21} + n_{03})
        \left(3 (n_{30} + n_{12}) ^ 2 - (n_{21} + n_{03}) ^ 2\right) \\
I_5 &= (n_{20} - n_{02})
        \left((n_{30} + n_{12}) ^ 2 - (n_{21} + n_{03}) ^ 2\right) \\
        &+ 4 n_{11} (n_{30} + n_{12}) (n_{21} + n_{03}) \\
I_6 &= (3 n_{21} - n_{03}) (n_{30} + n_{12})
        \left((n_{30} + n_{12}) ^ 2 - 3 (n_{21} + n_{03}) ^ 2 \right) \\
        &- (n_{30} - 3 n_{12}) (n_{21} + n_{03})
        \left(3 (n_{30} + n_{12}) ^ 2 - (n_{21} + n_{03}) ^ 2 \right)
\end{aligned}
$$



### Hardware Implementation

#### Top Level
<!--
BD
-->

#### Connected Components

#### Debug Features

<!--
Diagram with mux and color table ROM.
-->


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



Design Flow
-----------

### Testbench

I designed my testbench to read an image from disk into memory, feed it as a
pixel stream to the IP core, write the output stream to memory and finally write
that to disk.  At the time I wasn't aware of this, but it's quite similar to how
we ended up working with frame buffers and VDMAs.  To do this I had to choose a
file format and be able to read and write it.  I chose bitmap for its
simplicity.  I wanted to do this so I could look at what the IP was doing
without needing to run in hardware.  This was crucial to being able to work with
confidence before we had the hardware setup with HDMI and also to being able to
work with a reasonable design cycle time.

As the core evolved to do more things beyond edge detection, I enhanced my
testbench to follow.  For connected components, I had the testbench color each
label a colour rather than just the label, which would have been a subtle
grayscale.  When I had centroids of objects, I got my testbench to draw dots in
the image by manipulating the "frame buffer" contents.

One thing I regret not doing is setting up proper regression tests.  I did have
a great setup, but not something I could run and parse the results for a
pass/fail binary answer.

### Version Control

I maintained only source files and compile scripts.

When the time came for integration, I added my work as a submodule in the main
project.  In retrospect, it would have been better to have the submodule divide
at the IP level, not the IP core.  This came just as an artifact of the fact
that Michael worked on the AXI stream IP skeleton, and I worked on the
processing core.

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

