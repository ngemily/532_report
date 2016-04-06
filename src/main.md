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

\frontmatter

\tableofcontents
\listoffigures
\include{acknowledgements}

\mainmatter
\include{me}
\include{reflection}
\include{community}
\include{xilinx}
\include{course}

\backmatter
\printbibliography[heading=bibintoc]
