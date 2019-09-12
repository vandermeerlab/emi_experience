import numpy as np
import nept

rat_id = 'R192'
session_id = rat_id+'_exp03'
date = '2019-09-12'
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

lfp_swr_filename = date + '_CSC4b.ncs'

fs = 2000

binsize = 12
xedges = np.arange(14, 715+binsize, binsize)
yedges = np.arange(0, 479+binsize, binsize)

task_times = dict()
task_times['rest1'] = nept.Epoch([821.59], [1723.05])
task_times['run1'] = nept.Epoch([1760.61], [3487.15])
task_times['rest2'] = nept.Epoch([3516.35], [4418.8])
task_times['run2'] = nept.Epoch([4460.63], [5439.21])
task_times['rest3'] = nept.Epoch([5496.99], [6398.86])

probe_choice = ['south', 'west', 'south', 'west',
                'north', 'west', 'south', 'west']