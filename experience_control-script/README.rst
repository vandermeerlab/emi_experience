========
Overview
========

This control script is used for the experience experiment in RR1 at Dartmouth College.
The layout of the maze has 4 arms, labeled by cardinal directions (North, East, South, West).
Most trials are **forced**, with a transparent barrier blocking the other arms, 
such that the rat returning from one feeder has only one option for the next trial.
Some trials are **probe** trials, where the rat is given the option between two arms
(either high/low experience or medium/control).
Rats receive 2 pellets at the completion of rewarded trials,
which is 50% of total trials.
Arms are in pairs of North-South and East-West,
where each pair is either high/low experience or medium experience and control.
Pair-outcome remains constant for individual rats, but is counterbalanced between rats.
So, one rat will have North-South be high/low, another will have East-West as high/low.
Reward outcome for the 3 experience arms are paired with a tone presentation at the onset of the trial.
Reward outcome for the control arm is unpaired with tone.

Each session consists of the following:

- Prerecord [On pedestal; 15 minutes]
- Phase1 [On maze; 35 trials (2 probe)]
- PauseA [On pedestal; 15 minutes]
- Phase2 [On maze; 35 trials (2 probe)]
- PauseB [On pedestal; 15 minutes]
- Phase3 [On maze; 34 trials (2 probe)]
- Postrecord [On pedestal; 15 minutes]

===============
Getting started
===============

- Open Neuralynx
- Open Matlab & press ``experience`` shortcut
- Run controlscript_experience.m
- Place barriers
- Start rat in the center
- Change barriers based on the trial indicated by the display
- Between phases remove the rat from the maze and place him on a pedestal nearby

====================
Detailed description
====================

The experimenter defines:

- the number of phases
- the number of high, medium, low, and control trials
- the order of the alternating trials (expt.highlow_first)
- the order of the two probe (expt.probe_highlow_first) trials (can be set differently within each phase)
- the duration and frequency of the tone

The states involved in an experimental run are **return** and **approach**.

**return** occurs when the rat arrives at a feeder and breaks the feeder photobeam.
Pellets are delivered at that feeder if the trial was rewarded and the next trial is determined.
The next trial information will appear in the ``trial`` box on the display.

**approach** occurs when the rat breaks the central photobeam for the arm of its current trial.
A tone will sound upon this start photobeam break for the duration of the tone object if the trial has a tone.

The experiment has **forced** and **probe** trials.

**forced** trials have transparent barriers blocking all but the trial arm and where the rat was coming from.

**probe** trials are in high-low or medium-control pairs, 
where the rat has the coice between a pair of arms.

Both **forced** and **probe** trials can be rewarded or unrewarded. 
All **probe** trials are have predictable pairings with the tone and reward.
Prior to the probe trial for a given pair the available trials for trial selection is subtracted by 1.
This means that the choice at the probe trial is accounted for in the totals.

At the end of a phase a message will appear in the ``messages`` box on the display.
The next phase is started by a button press or mouse click in the display.

The end of the last phase will report that *Running phases are finished for this session.* in the ``messages`` box on the display.