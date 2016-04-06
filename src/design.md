Design Flow
-----------

### Testbench

I designed my testbench to read an image from disk into memory, feed it as a
pixel stream to the IP core, write the output stream to memory and finally write
that to disk.  At the time I wasn't aware of this, but it's quite similar to how
we ended up working with frame buffers and VDMAs.  To do this I had to choose a
file format and be able to read and write it.  I chose bitmap for its
simplicity.  I wanted to do this so I could look at what the IP was doing
without needing to run in hardware.  This was crucial to being able to work with
confidence before we had the hardware setup with HDMI and also to being able to
work with a reasonable design cycle time.

As the core evolved to do more things beyond edge detection, I enhanced my
testbench to follow.  For connected components, I had the testbench color each
label a colour rather than just the label, which would have been a subtle
grayscale.  When I had centroids of objects, I got my testbench to draw dots in
the image by manipulating the "frame buffer" contents.

### Version Control

I maintained only source files and compile scripts.

When the time came for integration, I added my work as a submodule in the main
project.  In retrospect, it would have been better to have the submodule divide
at the IP level, not the IP core.  This came just as an artifact of the fact
that Michael worked on the AXI stream IP skeleton, and I worked on the
processing core.
