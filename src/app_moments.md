Moment Invariants
=================
\label{app:moments}

>This method was intended for the differentiation between targets and
>non-targets in our design.  Due to time constraints, we were unable to
>complete this.  I had originally selected this method because I thought it was
>elegant to essentially hash an image based on its moments, which are relatively
>easy to extract from the image in one pass.

Moment invariants were introduced by Hu in 1962 \cite{hu} as a means of uniquely
identifying an object.  By this method, the outlines could be characterized as a
unique fingerprint of seven numbers.  In a training phase, outlines of friends
are committed to memory.  Then, the set of moments are calculated for each
object detected and if they don't match any of the committed moments, it is
deemed a foe.

Invariants
----------

The invariants used are listed below.

### Translational invariants

$$
u_{ij} = \sum_x \sum_y (x - \bar{x}) ^ i (y - \bar{y}) ^ j p_{ij}
$$

### Scale invariants
$$
n_{ij} = \frac{u_{ij}}{u_{00} ^ {1 + \frac{i + j}{2}}}
$$

### Rotational invariants

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

Comparison
----------

The sum of square differences was used to calculate a difference score to
determine how different a given image is from a known image.  The smaller the
score, the more similar the images.  A score of 0 indicates that the images are
identical.

$$
x = \sum_{i=0}^5 \frac{(I_i - I^\prime_i) ^ 2}{I_i I^\prime_i}
$$

\newpage

Software Prototyping
--------------------

This method was reasonably successfully in software.  It could correctly
identify scaled, shifted and rotated images.  It is not designed to match skewed
images.  A sample image annotated with difference scores is shown in Figure
\ref{fig:sw_moments}.

\begin{figure}[htbp]
    \centering
    \includegraphics[scale=0.4,trim={0 0 0 0},clip]{imgs/sw_moments.png}
    \caption{Moments}
    \label{fig:sw_moments}
\end{figure}
