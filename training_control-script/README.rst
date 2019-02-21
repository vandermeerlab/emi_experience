========
Overview
========

This control script is used for training rats to run on a maze.
The layout of the maze is a T-shape, with 2 track segments for each arm.
Every trial is **forced**, with a transparent barrier blocking one arm, 
such that the rat returning from one feeder only has one option for the next trial.
Initially, rats receive 2 pellets at the completion of every trial.
This is to ensure the rat:

1. Runs on a maze for reward
2. Is familiar with the feeders giving reward
3. Is familiar with the transparent barriers and experimenter nearby

Once the rat is familiar with the task, 
the trial sequence is varied and only 50% of trials are rewarded.
This mimics the conditions for the experience task in RR1.

Each session consists of the following:

- Pre-run [On pedestal; 5 minutes]
- Run [On maze; 45 minutes or 40 trials]
- Post-run [On pedestal; 5 minutes]

===============
Getting started
===============

Follow the detailed instructions in `daily_tmaze <https://github.com/vandermeerlab/emi_experience/training_control-script/daily_tmaze.pdf>`_.

====================
Detailed description
====================

The experimenter defines:

- the number of trials
- the start location (phase.north_first), which determines if the trials are clockwise or counterclockwise

All trials are **forced**, where the experimenter blocks all but the current and next trial's arm.

The end of the phase will report that 
*Running phases are finished for this session.* 
in the ``messages`` box on the display.