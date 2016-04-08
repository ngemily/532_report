Reflection
==========

<!--
What were the strengths and weaknesses of your team? How did you address the
weaknesses? From the perspective of your own experience, what did you need to
learn to do the project. How did you do that learning?
-->

Team
----

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

Testing in the real environment
-------------------------------

My greatest oversight in this project was testing both the software prototype
and hardware simulation on clean images only, and not camera images.

Regression testing
------------------

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

Approach to image processing
----------------------------

At the beginning of this project, I had no idea about anything related to
computer vision.  Since the focus of the course is hardware design, I didn't
want to spend too long researching and prototyping.  I learned most of what I
needed from OpenCV tutorials and following the topics introduced in further
depth.  I was able to prototype ideas very quickly using the OpenCV library
\cite{opencv}.  While I was doing my research, I tried to stick with algorithms
that were easy to understand and that were hardware friendly.

Charles introduced Viola Jones object detection in a little more detail than
discussed in lecture.  I dismissed it as being too complicated because of the
artificial intelligence component.  I did not think I would be able to
understand and implement and then train a Viola Jones detection module in the
timeframe of this project, primarily due to my lack of experience with training
a neural network.  In retrospect, the approach I chose was not all that easy to
implement in hardware because of the many memory accesses required and I'm sure
I would have gotten the help I needed to get Viola Jones.  Still, I went with
the more classical methods of computer vision where I know exactly what is being
calculated for each pixel.

At the end of this process, I learned just as much about computer vision as I
did hardware design.  I also learned that new and different, possibly better
ways of doing things are always on the horizon and it's best to keep an open
mind.  As Jason Foster would say to us in first year, keep strong opinions,
weakly held.  Such as it is that neural nets are taking over in computer vision,
high level synthesis is on the rise in the digital design world.  I would say
that I learned a lot here on extracting image features and designing at the RTL
level, but I wouldn't be opposed to continuing to pursue these topics in
slightly different avenues.
