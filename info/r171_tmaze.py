import os
import numpy as np
import nept

rat_id = 'R171'

species = 'rat'
behavior = 't-maze'
experimenter = 'Emily Irvine'

sessions = ["2019-02-18", "2019-02-19", "2019-02-20", "2019-02-21", "2019-02-22", "2019-02-23", "2019-02-24",
            "2019-02-25", "2019-02-26", "2019-03-01", "2019-03-02", "2019-03-03",
            "2019-03-04", "2019-03-05", "2019-03-06", "2019-03-07", "2019-03-08", "2019-03-09", "2019-03-10",
            "2019-03-11", "2019-03-12", "2019-03-13"]

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