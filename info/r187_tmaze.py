import os
import numpy as np
import nept

rat_id = 'R187'

species = 'rat'
behavior = 't-maze'
experimenter = 'Emily Irvine'

sessions = ["2019-07-01", "2019-07-02", "2019-07-03", "2019-07-04", "2019-07-05", "2019-07-06", "2019-07-07",
			"2019-07-08", "2019-07-09", "2019-07-10", "2019-07-11", "2019-07-12", "2019-07-13", "2019-07-14",
			"2019-07-15", "2019-07-16", "2019-07-17", "2019-07-18", "2019-07-30", "2019-07-31", "2019-08-01",
            "2019-08-02", "2019-08-03", "2019-08-04", "2019-08-05"]

n_sessions_presurgery = 18

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

pxl_to_cm = dict(x=3.93, y=3.4)