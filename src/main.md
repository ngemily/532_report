---
title: 'Individual Report'
date: April 8, 2016
author: Emily Ng
filter: pandoc-eqnos
bibliography: main.bib
classoption: oneside
header-includes:
    - \usepackage{sty/myTitle}
    - \usepackage{fullpage}
    - \usepackage{tikz}
    - \usepackage{caption}
    - \usepackage{subcaption}
    - \usepackage[section]{placeins}
    - \usepackage[backend=biber]{biblatex}
    - \addbibresource{bib/main.bib}
---

\renewcommand{\bibname}{References}

\frontmatter
\include{acknowledgements}

\tableofcontents
\listoffigures

\mainmatter
\include{me}
    \include{responsibilities}
    \include{tools}
    \include{design}
    \include{challenges}
\include{reflection}
\include{community}
\include{xilinx}
\include{course}

\appendix

# Sample image processing output
\include{sw}
\include{sim}

# Workflow scripts
\include{do}
\include{tcl}

# Schematics
\includegraphics{schematics/cc.pdf}
\includegraphics{schematics/moment_generator.pdf}
\includegraphics{schematics/sobel.pdf}
\includegraphics{schematics/top.pdf}

\backmatter
\printbibliography[heading=bibintoc]
