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
          inner=1.5in,
          outer=1.5in,
          bottom=1.25in,
          headheight=3ex,
          headsep=2ex,
      }
---
\setlength\headheight{33pt}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\leftmark}
\fancyhead[RE,LO]{\rightmark}
\cfoot{\thepage}
<!--
\fancyfoot[CE,CO]{\thepage}
\fancyfoot[LE,RO]{\thepage}
\rhead{Individual Report}
\lhead{ECE532}
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
\input{app_notebook}

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
