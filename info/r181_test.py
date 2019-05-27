import os
import numpy as np
import nept

rat_id = 'R181'
session_id = 'R181_test'
session = 'R181-2019-05-18'
date = '2019-05-18'
location = 'RR3'

species = 'rat'
behavior = 't-maze'
experimenter = 'Emily Irvine'

event_filename = date + '-Events.nev'
event_labels = dict(north_feeder='TTL Output on AcqSystem1_0 board 0 port 0 value (0x0010).',
                    not_north_feeder='NOT firing feeder NorthFeeder',
                    north_pb='TTL Input on AcqSystem1_0 board 0 port 1 value (0x0010).',
                    east_feeder='TTL Output on AcqSystem1_0 board 0 port 0 value (0x0020).',
                    not_east_feeder='NOT firing feeder EastFeeder',
                    east_pb='TTL Input on AcqSystem1_0 board 0 port 1 value (0x0020).',
                    south_feeder='TTL Output on AcqSystem1_0 board 0 port 0 value (0x0040).',
                    not_south_feeder='NOT firing feeder SouthFeeder',
                    south_pb='TTL Input on AcqSystem1_0 board 0 port 1 value (0x0040).',
                    trial_start='trial start',
                    trial_end='trial end')

position_filename = 'VT1.nvt'

lfp_swr_filename = 'CSC11a.ncs'
lfp_theta_filename = 'CSC11b.ncs'

binsize = 12
xedges = np.arange(14, 715+binsize, binsize)
yedges = np.arange(0, 479+binsize, binsize)
