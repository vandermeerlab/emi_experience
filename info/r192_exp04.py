import os
import numpy as np
import nept

rat_id = 'R192'
session_id = rat_id+'_exp04'
date = '2019-09-13'
session = rat_id+'-'+date

location = 'RR1'

species = 'rat'
behavior = 'experience 4-arm maze'
experimenter = 'Emily Irvine'

arm_to_outcome = dict()
arm_to_outcome['north'] = 'High'
arm_to_outcome['east'] = 'Medium'
arm_to_outcome['south'] = 'Low'
arm_to_outcome['west'] = 'Control'

data_filepath = os.path.join("E:\\", "data", "data-experience", rat_id, "RR1", rat_id+"_"+ date +"_recording")

event_filename = os.path.join(data_filepath, date + '-Events.nev')
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

position_filename = os.path.join(data_filepath, 'VT1.nvt')
pxl_to_cm = dict(x=3.13, y=2.73)

lfp_swr_filename = os.path.join(data_filepath, date + '_CSC4b.ncs')

fs = 2000

binsize = 12
xedges = np.arange(14, 715+binsize, binsize)
yedges = np.arange(0, 479+binsize, binsize)

task_times = dict()
task_times['rest1'] = nept.Epoch([1333.58], [2235.47])
task_times['run1'] = nept.Epoch([2296.26], [3293.95])
task_times['rest2'] = nept.Epoch([3328.28], [4229.93])
task_times['run2'] = nept.Epoch([4280.08], [5399.03])
task_times['rest3'] = nept.Epoch([5421.18], [6356.31])

probe_choice = ['east', 'south', 'east', 'south',
                'west', 'south', 'west', 'south']