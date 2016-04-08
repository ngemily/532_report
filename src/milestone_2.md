Milestone 2
-----------

I. Summary of milestone

- prototype object detection algorithms in software
- demonstrate functionality on some sample images

II. Status

- implemented in C:
    - color to grayscale
    - isolate single colour out of full colour image
    - Sobel operator for edge detection
    - isolate individual objects in image
    - calculate image moments
- successfully identified laser point from image
- successfully identified an object as a scaled version of a reference image, and reject dissimilar objects using image moment invariants

III. Challenges faced

- abandoned shape context approach for evaluating object similarity, due to complexity and because it is computation intensive
- haven't checked for robustness of image moments on real picture from camera

IV. Next week's milestones

- skeleton IP to interface with the rest of the system
- preliminary version of laser detecting IP
- set up tests to compare to software

V. Project modifications

None so far.
