import os
import numpy as np
import nept

rat_id = 'R182'

species = 'rat'
behavior = 't-maze'
experimenter = 'Emily Irvine'

sessions = ["2019-04-03", "2019-04-04", "2019-04-05", "2019-04-06", "2019-04-07", "2019-04-08", "2019-04-09",
			"2019-04-10", "2019-04-11", "2019-04-12", "2019-04-14", "2019-04-15", "2019-04-16", "2019-04-17",
			"2019-04-18"]

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