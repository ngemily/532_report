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
    - \usepackage{fancyhdr}
    - \usepackage{layout}
    - \usepackage[section]{placeins}
    - \usepackage[backend=biber]{biblatex}
    - \usepackage{geometry}
    - \addbibresource{bib/main.bib}
    - \geometry{
          top=1in,
          inner=1in,
          outer=1in,
          bottom=1in,
          headheight=3ex,
          headsep=2ex,
      }
---
\setlength\headheight{33pt}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{Individual Report}
\fancyhead[RE,LO]{ECE532}
\fancyfoot[CE,CO]{\leftmark}
\fancyfoot[LE,RO]{\rightmark}
<!--
\rhead{Individual Report}
\lhead{ECE532}
\cfoot{\thepage}
\renewcommand{\footrulewidth}{0.4pt}% default is 0pt (ie make footer rule non-zero)
-->

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
\newpage
\input{app_tcl}
\newpage
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
