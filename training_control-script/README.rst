========
Overview
========

This control script is used for training rats to run on a maze.
The layout of the maze is a T-shape, with 3 segments for each arm.
Every trial is **forced**, with a transparent barrier blocking one arm, 
such that the rat returning from one feeder only has one option for the next trial.
Rats receive 2 pellets at the completion of every trial.
This is to ensure the rat:

1. Runs on a maze for reward
2. Is familiar with the feeders giving reward
3. Is familiar with the transparent barriers and experimenter nearby

Each session consists of the following:

- Pre-run [On pedestal; 10 minutes]
- Run [On maze; 20 of each 3 trial types]
- Post-run [On pedestal; 10 minutes]

===============
Getting started
===============

- Open Neuralynx
- Open Matlab & press ``experience`` shortcut
- Run controlscript_training.m
- Place barriers
- Start rat in the center
- Change barriers based on the trial indicated by the display
- At the end of the phase remove the rat from the maze and place him on a pedestal nearby

====================
Detailed description
====================

The experimenter defines:

- the number of trials
- the start location (phase.north_first), which determines if the trials are clockwise or counterclockwise

The states involved in an experimental run are **return** and **approach**.

**return** occurs when the rat arrives at a feeder and breaks the feeder photobeam.
Pellets are delivered at that feeder and the next trial is determined.
The next trial information will appear in the ``trial`` box on the display.

**approach** occurs when the rat breaks the central photobeam for the arm of its current trial.

All trials are **forced**, where the experimenter blocks all but the next trial's arm.

The end of the phase will report that *Running phases are finished for this session.* in the ``messages`` box on the display.