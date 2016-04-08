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

The full top level diagram showing all these components is available in Figure
\ref{fig:top} in Appendix \ref{app:bd}.

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
    G &=
        \left|G_x\right| + \left|G_y\right| \\
    q &=
        \begin{cases}
            1 & \quad G \geq \text{threshold} \\
            0 & \quad G <    \text{threshold}
        \end{cases}
\end{align}
\label{eq:sobel}
\end{subequations}

Performing the computation requires access to a 3 x 3 neighbourhood of pixels.
This requires two line buffers to access the pixels from the previous two rows,
shown in Figure \ref{fig:sobel}.  Once two rows have been filled up, the output
can be computed at one clock cycle per pixel.

\begin{figure}[htbp]
    \centering
    \includegraphics[scale=0.45]{imgs/bd_sobel.png}
    \caption{Generating the pixel array for Sobel computation.}
    \label{fig:sobel}
\end{figure}


### Flooding

When the edge detection was tested in hardware, two main issues arose.  First,
there were many small speckles of noise.  Second, the outline appeared grainy,
like in a sketch where some of the paper still shows through a penciled outline.
A filter was applied that takes a population count of the window, by applying an
image kernel of all one's.  Then, if this count meets a threshold the input
pixel is accepted as part of the outline, otherwise it is rejected and marked
part of the background.

\begin{subequations}
\begin{align}
    \text{count} &=
        \begin{bmatrix}
            1 & 1 & 1 & 1 & 1 \\
            1 & 1 & 1 & 1 & 1 \\
            1 & 1 & 1 & 1 & 1
        \end{bmatrix}
        \ast A \\
    q &=
        \begin{cases}
            1 & \quad \text{count} \geq \text{threshold} \\
            0 & \quad \text{count} <    \text{threshold}
        \end{cases}
\end{align}
\label{eq:flood}
\end{subequations}

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

There are several possible scenarios:

1. $p$ is a background pixel.

    It is not given a label.

2. $p$ is not a background pixel and A through D are background pixels.

    It is the start of a new object, so it gets a new label.

3. $p$ is not a background pixel, and among A through D there is a single
label.

    It is part of this object, it copies that label.

4. $p$ is not a background pixel, and among A through D there are two or more
labels.

    These labels need to be merged.  $p$ is assigned the smallest of these
    labels.

Scanning in this fashion, there comes a point where two regions may need to be
merged.  Consider a 'U' shape.  The two arms of the 'U' will be labeled
separately, and it is not until the bottom right of the 'U' that the two labels
appear in the same neighbourhood.  At this point, the data for the two objects
can be merged.  This is valid since the entries are just a summation of data
points for each pixel considered to be part of the object.

Bailey and Johnston \cite{cc} illustrate a single pass connected components
analysis implementation on an FPGA.  This approach was followed with some
simplifications.  The main components are shown in Figure \ref{fig:cc_pipeline}.
There is a label selection module, a merge table, and a data table.

The first two stages select the label for the current pixel.  The first stage is
label selection.  This block is all combinational logic.  The next stage reads
from the merge table.  It looks up the selected lable in the merge table which
is in BRAM to see if this pixel really belongs to another label.  At the end of
this stage, we know the correct label for this pixel.

The next two stages update the data for this label.  The features being
extracting from the objects are its moments, up to the third order.  In the
third stage, the data for the resolved label is read out of the table, updated
and in the fourth stage written back.

\begin{figure}[htbp]
    \centering
    \includegraphics[width=\textwidth]{imgs/bd_cc_pipeline.png}
    \caption{Connected components pipeline.}
    \label{fig:cc_pipeline}
\end{figure}


### Feature Extraction

In the one pass method described by Bailey and Johnston \cite{cc}, data is
extracted on the fly as the objects are being labeled.

#### Location

Locations of objects were found by finding the centre of mass of the outlines.
As the objects were being labeled, their moments up to the third order were
accumulated in a data table.

The locations were then extracted using Equations (\ref{eq:xy}).  Due to the
nature of division in hardware, this was left to the microblaze.  When it was
attempted in hardware, it resulted in an astounding 75 ns delay on a single
path.

\begin{subequations}
\begin{align}
    area &= m_{00} \\
    \bar{x} &= \frac{m_{10}}{m_{00}} \\
    \bar{y} &= \frac{m_{01}}{m_{00}}
\end{align}
\label{eq:xy}
\end{subequations}

#### Higher order moments

Higher order moments were extracted for use to characterize each object.  The
characterization method was only prototyped in software.  Unfortunately, delays
in the project schedule did not allow for this to be fully implemented in
hardware.  For a discussion of the theory and software results, see Appendix
\ref{app:moments}.

The multiplications themselves also required effort to close timing.  The
highest order moment $\text{m}_{30}$, involves raising a number to the power of
three, where the maximum input value is the frame width, 1280.  That means, at
worse case, the computation is $1280^3 \approx 2x10^9$.  In order to break it
down into smaller computations, it was pipelined so that the the next order
moment was calculated at each stage using the result from the previous stage.
For a block diagram, see Figure \ref{fig:mul} in Appendix \ref{app:bd}.  It
takes three cycles, which conveniently matches the number of cycles until the
data write stage in the connected components pipeline.

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
