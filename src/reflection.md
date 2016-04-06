Reflection
==========

<!--
What were the strengths and weaknesses of your team? How did you address the
weaknesses? From the perspective of your own experience, what did you need to
learn to do the project. How did you do that learning?
-->

### Team

Our team is fairly diverse within ECE.  Together we have significant background
(for undergrad students) in circuit design, embedded software, FPGA CAD flow and
good project workflow practices.  Most of us had also worked together closely
before, so we already had a good sense of each others strengths and weaknesses.
Overall, we were able to play to each of our strengths in this project.

Michael has a strong background in circuits and power electronics.  He also has
experience working with PLLs at the physical design level.

Patrick has a strong background in embedded software.  In addition, he has
experience working on timing modeling in FPGAs.

Roberto also has a strong background in embedded software and is overall very
well rounded in computer engineering.

We naturally divided up into two groups: Michael and I on the custom IP and
circuitry, and Roberto and Patrick on system level design and embedded software.
Across these two groups, we correspondingly split into two pairs for design and
control of the custom IP.  Patrick worked with Michael and being able to control
the laser and Roberto worked with me to interface with the object detection IP.
This division allowed us to work pretty well individually for a few weeks and
perform integration smoothly.

### Individual

#### Testing in the real environment

My greatest oversight in this project was testing both the software prototype
and hardware simulation on clean images only, and not camera images.

#### Regression testing

One thing I would have done differently is set up regression tests.  Ideally, I
would have a set of tests run nightly and automatic pass/fail reporting with
logs.  This set of tests should cover RTL, post-syn, post-impl functional tests,
timing closure and utilization tests.  The way I would implement the automatic
functional tests is with a golden test vector, where I store the correct output
and perform a binary file comparison on the test run output.  Timing and
utilization could be easily reported automatically by grepping the Vivado
reports.  Since I already had everything running from the command line and a
remote server running Vivado and Modelsim, it would not have been hard to extend
to automatic testing.

One of the reasons I didn't do this is because I didn't think of the result as a
pass/fail.  I always looked at the output image and never considered a simple
file comparison.  I felt like I had enough testing by running tests when I made
a change, but in retrospect there were situations where nightly tests would have
reported to me discrepancies that I didn't notice until later.  In particular, I
always tested on smaller images because a full 720p image takes almost ten
minutes to run in RTL sim.  Had I ran tests on full resolution images nightly, I
would have caught that before going to hardware.
