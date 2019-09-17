import numpy as np
import nept

rat_id = 'R191'
session_id = rat_id+'_exp05'
date = '2019-09-17'
session = rat_id+'-'+date

location = 'RR1'

species = 'rat'
behavior = 'experience 4-arm maze'
experimenter = 'Emily Irvine'

event_filename = date + '-Events.nev'
event_labels = dict(recording_start='Starting Recording',
                    recording_stop='Stopping Recording',
                    north_feeder='TTL Output on AcqSystem1_0 board 0 port 2 value (0x0010).',
                    not_north_feeder='NOT firing feeder NorthFeeder',
                    north_pb='TTL Input on AcqSystem1_0 board 0 port 1 value (0x0010).',
                    east_feeder='TTL Output on AcqSystem1_0 board 0 port 2 value (0x0020).',
                    not_east_feeder='NOT firing feeder EastFeeder',
                    east_pb='TTL Input on AcqSystem1_0 board 0 port 1 value (0x0020).',
                    south_feeder='TTL Output on AcqSystem1_0 board 0 port 2 value (0x0040).',
                    not_south_feeder='NOT firing feeder SouthFeeder',
                    south_pb='TTL Input on AcqSystem1_0 board 0 port 1 value (0x0040).',
                    west_feeder='TTL Output on AcqSystem1_0 board 0 port 2 value (0x0080).',
                    not_west_feeder='NOT firing feeder WestFeeder',
                    west_pb='TTL Input on AcqSystem1_0 board 0 port 1 value (0x0080).',
                    trial_start='trial start',
                    trial_end='trial end',
                    unknown='TTL Input on AcqSystem1_0 board 0 port 1 value (0x00C0).',
                    approach_state='entering approach state',
                    return_state='entering return state')

position_filename = 'VT1.nvt'
pxl_to_cm = dict(x=3.13, y=2.73)

lfp_swr_filename = date + '_CSC4a.ncs'

fs = 2000

binsize = 12
xedges = np.arange(14, 715+binsize, binsize)
yedges = np.arange(0, 479+binsize, binsize)

task_times = dict()
task_times['rest1'] = nept.Epoch([868.96], [1770.91])
task_times['run1'] = nept.Epoch([1809.85], [2889.39])
task_times['rest2'] = nept.Epoch([2917.94], [3824.1])
task_times['run2'] = nept.Epoch([3859.66], [5118.36])
task_times['rest3'] = nept.Epoch([5138.34], [6061.86])

probe_choice = ['west', 'north', 'east', 'north',
                'east', 'north', 'east', 'north']