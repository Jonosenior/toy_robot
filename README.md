# ToyRobot

## Description

* The application is a simulation of a toy robot moving
on a square tabletop, of dimensions 5 units x 5 units.
* There are no other obstructions on the table surface.
* The robot is free to roam around the surface of the table,
but must be prevented from falling to destruction.
Any movement that would result in the robot falling
from the table must be prevented, however further
valid movement commands must still be allowed.

## Installation

Open your terminal/command line. Navigate to the directory where you want this project to live. To clone and play, type:
```
$ git clone https://github.com/Jonosenior/toy_robot.git
$ cd toy_robot
$ ruby lib/toy_robot.rb
```

To run the test suite, type:
```
$ rspec spec
```

## Notes

* There are three classes:

  * **Application**. Directs overall application logic, mainly: eliciting user input; converting the input into an instruction; checking the instruction is valid (and ignoring it if not) and applying the instruction.

  * **Table**. Stores the dimensions of the table, whether location is valid (ie, if it lies on the table), and whether a given 'MOVE' command is possible.

  * **Robot**. Stores the current location and facing direction of the robot, and can edit either (by moving or turning).

* The Table is initialized with a size array - the default is 5 * 5 but a manual size input will override this, which gives the flexibility of using different size tables.  

* The Robot is initialized with an options hash (which reduces the dependency on fixed-order arguments, a trick from Sandi Metz's POODR).

* The app stores the x,y co-ordinates like so: [x, y]. I considered using a more descriptive hash, like this `location = { x-coordinate: 1, y-coordinate: 2 }` but decided this would be overly fussy since ordered pairs (x,y) are the norm for Cartesian coordinate system.

* I've added an 'EXIT' command (not required by the specs), so the user can gracefully exit the program.

* Since the input comes from standard input, there are also input validations so the app won't crash if, for example, the user inputs a nonsense command like 'PLACE f,g,EAST'. This is also tested for.

## Task

Create an application that can read in commands of the following form:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

* `PLACE` will put the toy robot on the table in position X,Y
and facing `NORTH`, `SOUTH`, `EAST` or `WEST`.
* The origin (0,0) can be considered to be the `SOUTH WEST` most corner.
* The first valid command to the robot is a `PLACE` command,
after that, any sequence of commands may be issued, in any order,
including another `PLACE` command.
The application should discard all commands in the sequence
until a valid `PLACE `command has been executed.
* `MOVE` will move the toy robot one unit forward
in the direction it is currently facing.
* `LEFT` and `RIGHT` will rotate the robot 90 degrees
in the specified direction
without changing the position of the robot.
* `REPORT` will announce the X,Y and F of the robot.
This can be in any form, but standard output is sufficient.

* A robot that is not on the table can choose
to ignore the `MOVE`, `LEFT`, `RIGHT` and `REPORT` commands.
* Input can be from a file, or from standard input, as the developer chooses.
* Provide test data to exercise the application.
* It is not required to provide any graphical output
showing the movement of the toy robot.

## Constraints

The toy robot must not fall off the table during movement.
This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

Example Input and Output:

```
# Example a
PLACE 0,0,NORTH
MOVE
REPORT
# Output: 0,1,NORTH
```


```
# Example b
PLACE 0,0,NORTH
LEFT
REPORT
# Output: 0,0,WEST
```


```
# Example c
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
# Output: 3,3,NORTH
```

## Acknowledgement

The Toy Robot Challenge was originally formulated by [Jon Eaves](https://twitter.com/joneaves). This project and the explanation in the README comes from [Ask Charlie](https://github.com/askcharlie/toy_robot).
