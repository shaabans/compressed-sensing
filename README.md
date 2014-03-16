compressed-sensing
==================
A couple of simple compressed sensing examples, based on examples from [the notes](http://courses.washington.edu/amath582/582.pdf) (the section starting at page 170 of the PDF) of the excellent Computational Methods for Data Analysis course on Coursera taught by Nathan Kutz.

This was written for Matlab but includes a randintrlv function (borrowed from the Octave [communication package](http://octave.sourceforge.net/communications/)) and a dct function (from Octave's [signal package](http://octave.sourceforge.net/signal/)) that alleviate the requirement for Matlab's communication or signal processing toolboxes.

Usage
-----
Just install [CVX](http://cvxr.com/cvx/) in Matlab, then run the examples.

Unfortunately, CVX is not yet compatible with Octave, so this will only work in Matlab. If anyone knows of a good substitute for CVX for Octave, please let me know.

Have a look at the code to see what's going on and let me know how you improve it with pull requests.

Basic Idea
----------
The first example shows how well a variety of methods of solving an underdetermined system do at coming up with sparse representations.  The second example demonstrates the reconstruction of a signal using only 10% of the orignal data. 
