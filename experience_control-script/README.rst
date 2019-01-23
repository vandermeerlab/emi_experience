========
Overview
========

This control script is used for the experience experiment in RR1 at Dartmouth College.
The layout of the maze has 4 arms, labeled by cardinal directions (North, East, South, West).
Most trials are *forced*, with a transparent barrier blocking the other arms, 
such that the rat returning from one feeder has only one option for the next trial.
Some trials are *probe* trials, where the rat is given the option between two arms
(either high/low experience or medium/control).
Rats receive 2 pellets at the completion of rewarded trials,
which is 50% of total trials.
Arms are in pairs of North-South and East-West,
where each pair is either high/low experience or medium experience and control.
Reward outcome for the 3 experience arms are paired with a tone presentation at the onset of the trial.
Reward outcome for the control arm is unpaired with tone.

Each session consists of the following:

- Pre-record [On pedestal; 15 minutes]
- Phase1 [On maze; 35 trials (2 probe)]
- PauseA [On pedestal; 15 minutes]
- Phase2 [On maze; 35 trials (2 probe)]
- PauseB [On pedestal; 15 minutes]
- Phase3 [On maze; 34 trials (2 probe)]
- Post-record [On pedestal; 15 minutes]

===============
Getting started
===============

- Open Neuralynx
- Open Matlab & press ``experience`` shortcut
- Run controlscript_experience.m

====================
Detailed description
====================

TODO