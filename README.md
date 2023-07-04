# Physics Simulation in Haskell

2d Physics Simulation using Verlet integration implemented in Haskell.
This project is inspired by the work of
[johnBuffer's Writing a Physics Engine from scratch](https://www.youtube.com/watch?v=lS_qeBy3aQI)
and the corresponding [Github repo](https://github.com/johnBuffer/VerletSFML).

This also serves as my final project for the course
[CIS 194: Introduction to Haskell](https://www.cis.upenn.edu/~cis1940/spring13/lectures.html).
My solutions to the assignments and homework in the course is
[here](https://github.com/beekill95/cis_194_intro_to_haskell).

## TODO

* Read more about strict evaluation in Haskell to optimize the collision solvers;
* Implement a multi-thread collision solver;
* Implement a string object;
* Implement a box container;
* Maybe implement an abstract container;
* Write-up.

## Build

This project depends on [gloss](http://gloss.ouroborus.net/) to render.
Make sure you installed the required dependencies for the gloss library:
openGL, GLU, freeglut.
Next, you can install the required libraries for the project:

> cabal install

And, finally: `cabal build` to build the project.

## Executables

Right now, there are two executables in the project:

* `simple_app` is just a simple world with 4 balls in it.
You can execute the program by running `cabal run simple_app`.
* `random_app` is a world in which balls are continuously added,
execute the program by `cabal run random_app`.
