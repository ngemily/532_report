Responsibilities
----------------

### Overview

>I was tasked with selecting an algorithm to do what we needed for our project,
>prototyping it on software and implementing it in hardware.  I allocated one
>week for research, one week for prototyping, two weeks for building and two
>weeks for integration, which left one week buffer.

>Secondly, as I was prototyping in software, which in itself was a challenge, I
>was supposed to consider the feasibility of hardware implementation.  At the
>time, I thought that meant to avoid recursion and graph traversal.  I hadn't
>really considered memory accesses and the challenge they would present as I
>moved to hardware implementation.

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


### Grayscale

Grayscale was calculated using the ITU-R Rec. 601

$$ I = 0.299 R + 0.587 G + 0.114 B $$

### Sobel

#### Image Filter

Image filters can produce interesting effects, such as blur, sharpen, emboss, or
outline.  This diverse range of effects is achieved with a very simple and
compact computation.  It is performed by convolving an _image kernel_ with an
input image to produce an output image.  The kernel is a small matrix that
defines the resultant pixel as a weighted summation of the pixels in the window
surrounding it.  The output is computed by convolving at each input pixel a
window of the input with the kernel.

\begin{figure}[htbp]
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

The Sobel operator is an image filter designed to extract edges by computing the
derivative at each pixel.  Gradients correlate well with edges because an even
surface contains pixels that are very similar to each other whereas pixels along
edges show a high level of difference, or gradient, along the direction of the
edge.

\begin{subequations}
\begin{align}
    G_y &=
        \begin{bmatrix}
            -3 & -10 & -3 \\
             0 &   0 &  0 \\
            +3 & +10 & +3
        \end{bmatrix}
        \ast A\\
    G_x &=
        \begin{bmatrix}
             -3 & 0 &  +3 \\
            -10 & 0 & +10 \\
             -3 & 0 &  +3
        \end{bmatrix}
        \ast A \\
    G &= \left|G_x\right| + \left|G_y\right|
\end{align}
\label{eq:sobel}
\end{subequations}

### Flooding

When the edge detection was tested in hardware, two main issues arose.  First,
there were many small speckles of noise.  Second, the outline appeared grainy,
like in a sketch where some of the paper still shows through a penciled outline.
A filter was applied that takes a population count of the window, by applying an
image kernel of all one's.  Then, if this count meets a threshold the input
pixel is accepted as part of the outline, otherwise it is rejected and marked
part of the background.

$$
count =
    \begin{bmatrix}
        1 & 1 & 1 & 1 & 1 \\
        1 & 1 & 1 & 1 & 1 \\
        1 & 1 & 1 & 1 & 1
    \end{bmatrix}
    \ast A
$$

### Connected Components Analysis

Connected components analysis is a method to extract information about objects
in a _binarized_ image.  _Connectivity_, illustrated in Figure
\ref{fig:connectivity}, is defined loosely as pixels that are touching each
other.  A _binarized_ image is an image where there are only two pixel values,
which represent background or non-background.  This method was used to locate
the different objects in view.

\begin{figure}[htbp]
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

The analysis works by scanning the image in raster order, scanning each row from
left right from the top to the bottom of the image.  At the time that pixel $p$
is processed, the pixels before it have already been labeled, as shown in Figure
\ref{fig:cc_labels}.  The label for $p$ is selected based on the labels A
through D.

There are several possible scenarios:

1. $p$ is a background pixel.

    It is not given a label.

2. $p$ is not a background pixel and A through D are background pixels.

    $p$ is the start of a new object, so it gets a new label.

3. $p$ is not a background pixel, and among A through D there is a single
label.

    $p$ is part of this object, it copies that label.

4. $p$ is not a background pixel, and among A through D there are two or more
labels.

    These labels need to be merged.  $p$ is assigned the smallest of these
    labels.


\begin{figure}[htbp]
\centering
\begin{tikzpicture}[x=1cm,y=-1cm]
    \draw (0, 0) grid (3, 2);

    \node at (0.5, 0.5) {A};
    \node at (1.5, 0.5) {B};
    \node at (2.5, 0.5) {C};
    \node at (0.5, 1.5) {D};
    \node at (1.5, 1.5) {$p$};
\end{tikzpicture}
\captionsetup{width=0.8\textwidth}
\caption{Neighbourhood of input pixel $p$.  Labels A through D are the labels of
the pixels that have already been processed through connected components
analysis and $p$ is an input pixel from the binarized image.}
\label{fig:cc_labels}
\end{figure}

Bailey and Johnston \cite{cc} illustrate a single pass connected components
analysis implementation on an FPGA.  This approach was followed with some
simplifications.  The main components are shown in Figure \ref{fig:cc_pipeline}.
There is a label selection module, a merge table, and a data table.

\begin{figure}[htbp]
    \centering
    \includegraphics[width=\textwidth]{imgs/pipeline.png}
    \caption{Connected components pipeline.}
    \label{fig:cc_pipeline}
\end{figure}


### Location

Locations of objects were found by finding the centre of mass of the outlines.
As the objects were being labeled, their moments up to the third order were
accumulated in a data table.

The locations were then extracted using Equations (\ref{eq:xy}).

\begin{subequations}
\begin{align}
    area &= m_{00} \\
    \bar{x} &= \frac{m_{10}}{m_{00}} \\
    \bar{y} &= \frac{m_{01}}{m_{00}}
\end{align}
\label{eq:xy}
\end{subequations}

### Moment Invariants

>This module was only prototyped in software.  For a discussion on the
>challenges of hardware implementation, see Appendix \ref{app:moments}.

Moment invariants were introduced by Hu in 1962 \cite{hu} as a means of uniquely
identifying an object.  By this method, the outlines could be characterized as a
unique fingerprint of seven numbers.  In a training phase, outlines of friends
are committed to memory.  Then, the set of moments are calculated for each
object detected and if they don't match any of the committed moments, it is
deemed a foe.

#### Translational invariants

$$
u_{ij} = \sum_x \sum_y (x - \bar{x}) ^ i (y - \bar{y}) ^ j p_{ij}
$$

#### Scale invariants
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

##### Comparison

$$
x = \sum_{i=0}^5 \frac{(I_i - I^\prime_i) ^ 2}{I_i I^\prime_i}
$$

### Top Level

\begin{figure}[htbp]
    \centering
    \includegraphics[scale=0.45]{imgs/top.png}
    \caption{Top level.}
\end{figure}

### Debug Features

In order to facilitate debugging, each stage of image processing can be
displayed to video output.  In particular, the connected components labels are
coloured in a colour-by-numbers fashion so the different outlines can be easily
observed.  Internally, they are labeled $1, 2, 3, ...$, which would appear as
various shades of grey if displayed directly.

\begin{figure}[htbp]
    \centering
    \includegraphics[scale=0.6]{imgs/output_modes.png}
    \caption{Output modes}
\end{figure}
