Experience Task Description
===========================

The main Experience task includes the following structure: a 15 minute prerecord rest period (Rest 1), running Phase 1 with 36 total trials, a 15 minute rest (Rest 2), running Phase 2 with 36 total trials, and a 15 minute postrecord rest period (Rest 3).
In each running phase of the experiment, the High experience trajectory will have 15 trials, the Medium experience and Control trajectories will each have 9 trials, and the Low experience trajectory with have 3 trials.
Although most of these trials will be forced by blocking the other trajectories with dark wooden barriers,
each running phase includes 4 probe trials in which the rat is given free choice between two trajectories.
Two probe trials offers choice between the High and Low experience trajectories,
and two probe trials offers choice between the Medium experience and Control trajectories.
Additionally, exactly 50% of the trials (18 per phase) are rewarded with 3 food pellets for all of the trajectories in the Experience maze.
This reward is associated with a 2 second tone upon trial initiation for the High, Medium, and Low experience trajectories.
Trials from the Control trajectory are rewarded the same amount as the Medium experience trajectory, and the tone occurs an equal number of times, but the tone and outcome are unpaired for the Control trajectory to account for trajectory preference.
Finally, the placement of the pedestal where the rats are confined during the rest periods alternates between the northwest and southwest corners.

Following data collection, putative neurons are identified through a spike sorting process using KlustaKwik and MClust (version 3.5; A. D. Redish et al. http://redishlab.neuroscience.umn.edu/MClust/MClust.html).
The data analysis pipeline is implemented with custom Python scripts that rely heavily on NeuroElectroPhysiology Tools (nept).
The pipeline involves establishing tuning curves for each neuron during running periods in each session.
These tuning curves are used in a Bayesian decoding algorithm,
which is optimized and evaluated using data from running periods where there is a known position for every timestamp.
Finally, I apply the algorithm to offline replay events and evaluate whether the decoded representations can be reliably classified as being in one and only one trajectory.

Data will be collected from male Long-Evans rats, each implanted with a 16-array hyperdrive targeting the CA1 region of the right dorsal hippocampus.
I plan to record from six rats to allow for counterbalancing six different maze layouts that can control for any environmental cues influencing the results.

This aim relies on two mazes, a T-maze for training and the main Experience maze.
The T-maze is 166x89 cm and is located in a sound attenuating room in an entirely different physical location from the Experience maze.
The Experience maze is 248x168 cm and has a 4-trajectory layout, with each trajectory extending from the central node.
The configuration for the Experience maze is designed in pairs, with the Low and High experience arms opposite each other and the Medium experience and Control arms opposite each other.
The trial sequence alternates between these pairs, making sure that each trial involves a physical turn to encourage more deliberative decision making on the probe trials and involvement of the hippocampal network.
With counterbalancing, the relationship between the mapping of the physical location and its experimental condition changes to control for the impact of environmental cues,
but the pairs remain consistent for all subjects.
So, for one subject the north trajectory may be the Control arm, east is the High experience arm, south is the Medium experience arm, and west is the Low experience arm.
However, no other subject will receive the same mapping.
Another subject may have north as the Low experience arm, east as the Medium experience arm, south as the High experience arm, and west as the Control arm, for example.

The training phase on the T-maze is designed to optimize the conditions for the rats' performance on the main Experience maze during recording sessions.
The training phase is divided into subgoals with a common structure of a 5 minute rest period on a pedestal nearby, followed by running on the maze for either 80 trials or 45 minutes, whichever is shorter, and the session ends with another 5~minute rest period.
For the first subgoal, each behavioral training session consists of forced trials that alternate predictably and are rewarded with 100% probability.
For the second subgoal, the sequence of trials is made unpredictable, but continues to alternate between the east trajectory and the north or south trajectories.
We do this so that each trial is initiated following a physical turn in the maze, as will be the case on the main Experience maze.
From the second subgoal onward, there may be a series of trials where one trajectory is not visited, analogous to the Low experience trajectory in the Experience maze.
For the third subgoal, the reward ratio on the T-maze is reduced to 75% in preparation for the 50% reward ratio on the Experience maze.
A subject progresses to the next subgoal when he completes 80 trials of the current task within 45 minutes for at least two consecutive sessions.

Once a rat performs well on the training T-maze, he undergoes surgery to implant the 16-array hyperdrive targeting the CA1 region of the right dorsal hippocampus.
Following surgery, the rat recovers and tetrodes are individually advanced to the hippocampal cell layer.
The rat is then re-trained on the T-maze, first without a tether attached to the implant, then with a tether. Neural data is recorded on this training task once the tether is attached.
The Experience task begins only after the rat completes all 80 trials of the T-maze consistently and unit recordings of cells in the CA1 hippocampal cell layer are stable.

The reason that the task includes both Medium and Control trajectories is to vary the predictability of the reward independent of experience level.
The Medium trajectory pairs a tone cue with the presence of reward, while in the Control trajectory the cue and reward are unpaired but each presented the same number of times as in the Medium trajectory.
Experience levels should therefore be the same in the Medium and Control trajectories, but one trajectory has predictable rewards while the other does not.

Current State
=============

Following the behavioral pilot, I trained ten subjects, seven of which were implanted with a 16-array hyperdrive.
Unfortunately, all but two subjects' implants had issues that resulted in aborted experiments.
The layout of the Experience maze for R191 was: north-Control, east-Low, south-Medium, and west-High.
The layout of the Experience maze for R192 was: north-High, east-Medium, south-Low, and west-Control.
They both ran well during the training sessions.
Their probe choices on the Experience maze favored the Low experience trajectory and the Control (unpredictable) trajectory and there was no behavioral bias based on the physical trajectory location.

Materials Used
==============

The UV epoxy used to make shuttles degrades over time, most notable because the curing time lengthens as the product degrades. In hindsight, I believe this contributed to the longevity of some of the shuttles and resulted in the recording cannula detaching from the shuttle while the tetrodes were being lowered into brain. This is at a critical timepoint and I could not readily salvage those shuttles. The dental cement seems to be more robust over time, but has a much higher initial failure rate for shuttle construction.

The current 16Ga cannula used for the targetting piece can only fit 19 30Ga cannula, resulting in one fewer reference than possible with the HS-36 Neuralynx boards.

The some material used for the 3D printing of the drive bodies caused issues because it was impossible to ream out the necessary openings and/or the openings were too tight and resulted in cannula sticking in the drive body and separating from the shuttle. 

The cables in RR1 are too long for the shortest distance when the rat is in the center of the maze, but allows for the rats to reach all feeder locations on the outskirts of the maze. Since the experimenter had to be in the center of the maze to physically move the barriers, they also ensured the cables did not interfere with the rat as they approached the center of the maze. For rest periods, a simple clip that could be easily removed shortens the cable length.

All clips used in RR1 were painted with black nail polish to limit reflection and interference with the position tracking data.

We have 4 breakout boards to reduce human error when 2 rats are run concurrently. Each breakout board can be configured to display the reference for a given headstage on a given rat, such that switching between rats is just a matter of changing the two breakout boards rather than reconfiguring them.

Neuralynx changed their style of board such that the screw hole to attach it to the drive body cannot be threaded. I ended up installing the board and attaching it to the drive body with epoxy/glue and screws before installing any of the tetrodes. This made installing the tetrodes more challenging, but still relatively straightforward. With this more tricky installation, I would recommend that you install the tetrodes counter-clockwise if you are right-handed (and clockwise if you are left-handed).

Overview of Rats Used
=====================

R171 - trained on T-maze, behavior only on Experience maze in RR1. Behavioral probe trials & metrics quantified.

R181 - trained on T-maze, implanted & retrained. Implant came off prematurely when plugged in for Day 1 in RR1.

R182 - trained on T-maze.

R187 - trained on T-maze, implanted, retrained & plugged-in in RR1. Drive shifted relative to brain. Did not proceed with recordings in RR1.

R188 - trained on T-maze.

R189 - trained on T-maze.

R190 - trained on T-maze, implanted & retrained. Surgery bleed, resulting in few moving tetrodes. Did not proceed with recordings in RR1.

R191 - trained on T-maze, implanted, retrained & recorded in RR1. Spike sorted. Behavioral probe trials & metrics quantified. N_neurons days 1-5: 83, 76, 57, 62, 45.

R192 - trained on T-maze, implanted, retrained & recorded in RR1. Behavioral probe trials & metrics quantified.

R193 - trained on T-maze, implanted & retrained. Issue with tetrodes on HS2 becoming stuck, resulting in a total of 6 moving tetrodes. Did not proceed with recordings in RR1.

R194 - trained on T-maze, implanted, retrained & Day 1 in RR1. HS2 reference failed Day 1 and troubleshooting  for multiple hours resulted in the rat having a Day 1 experience that was not compatible with the experiment.
