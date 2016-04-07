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
    - \usepackage{bytefield}
    - \usepackage{booktabs}
    - \usepackage{longtable}
    - \usepackage[section]{placeins}
    - \usepackage[backend=biber]{biblatex}
    - \addbibresource{bib/main.bib}
---

\renewcommand{\chaptername}{Section}
\renewcommand{\bibname}{References}

\frontmatter
\include{acknowledgements}

\tableofcontents
\listoffigures

\mainmatter
\include{me}
\include{reflection}
\include{community}
\include{xilinx}
\include{course}

\appendix

\input{app_doc}
\input{app_bd}
\input{app_moments}
\input{app_simout}

# Workflow
\input{app_simlib}
\input{app_tcl}
\input{app_do}

<!--
# Schematics
\includegraphics{schematics/cc.pdf}
\includegraphics{schematics/moment_generator.pdf}
\includegraphics{schematics/sobel.pdf}
\includegraphics{schematics/top.pdf}
-->

\backmatter
\printbibliography[heading=bibintoc]
