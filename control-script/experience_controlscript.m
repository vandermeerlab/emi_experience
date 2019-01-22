%% Reset & connect to Cheetah
clear all;

% Connect to Cheetah
connected = NlxAreWeConnected();
if connected
    disp 'We are already connected';
else
    serverName = '192.168.3.100';
    disp(['Connecting to ', serverName, '...']);
    success = NlxConnectToServer(serverName);
    if ~success
        error(['FAILED to connect to ', serverName]);
    else
        disp(['Connected to Cheetah at ', serverName]);
    end
end

%% Initialize settings for photobeams and feeders
disp('Initializing settings');

expt.photobeam_port = 1; % TTLInputPort
expt.feeder_port = 2; % TTLOutputPort

%% Arms
expt.north.name = 'North';
expt.east.name = 'East';
expt.south.name = 'South';
expt.west.name = 'West';

% Photobeams

expt.north.start_pb.pin = 2^0;
expt.north.start_pb.name = 'NorthStartPB';
expt.north.end_pb.pin = 2^1;
expt.north.end_pb.name = 'NorthEndPB';

expt.east.start_pb.pin = 2^2;
expt.east.start_pb.name = 'EastStartPB';
expt.east.end_pb.pin = 2^3;
expt.east.end_pb.name = 'EastEndPB';

expt.south.start_pb.pin = 2^4;
expt.south.start_pb.name = 'SouthStartPB';
expt.south.end_pb.pin = 2^5;
expt.south.end_pb.name = 'SouthEndPB';

expt.west.start_pb.pin = 2^6;
expt.west.start_pb.name = 'WestStartPB';
expt.west.end_pb.pin = 2^7;
expt.west.end_pb.name = 'WestEndPB';

expt.photobeams = {expt.north.start_pb, expt.north.end_pb, expt.east.start_pb, expt.east.end_pb, ...
	expt.south.start_pb, expt.south.end_pb, expt.west.start_pb, expt.west.end_pb};

% Feeders
expt.feeder.n_pellets = 2;
expt.feeder.prob = 0.5;

expt.north.feeder.name = 'NorthFeeder';
expt.north.feeder.pin = 0;
expt.east.feeder.name = 'EastFeeder';
expt.east.feeder.pin = 1;
expt.south.feeder.name = 'SouthFeeder';
expt.south.feeder.pin = 2;
expt.west.feeder.name = 'WestFeeder';
expt.west.feeder.pin = 3;

expt.feeders = {expt.north.feeder, expt.east.feeder, expt.south.feeder, expt.west.feeder};

% Map from outcome to arm
expt.outcome2arm = containers.Map();
expt.outcome2arm('High') = expt.east;
expt.outcome2arm('Low') = expt.west;
expt.outcome2arm('Medium') = expt.north;
expt.outcome2arm('Control') = expt.south;

% Trial parameters
expt.highlow_first = 0;
expt.probe_highlow_first = 0;
expt.max_time = 5 * 60 * 60; % max time for the experiment to run (sec)

% Make the tone cue
expt.tone_duration = 2;
expt.tone_frequency = 880;
expt.tone = makeTone(tone_duration, tone_frequency);

% phase parameters
phase1.name = '1';
phase1.high = 15;
phase1.medium = 9;
phase1.low = 2;
phase1.contol = 9;
phase1.highlow_first = expt.highlow_first;
phase1.probe_highlow_first = expt.probe_highlow_first;

phase2.name = '2';
phase2.high = 15;
phase2.medium = 9;
phase2.low = 2;
phase2.contol = 9;
phase2.highlow_first = expt.highlow_first;
phase2.probe_highlow_first = expt.probe_highlow_first; % or ~probe_highlow_first or whatever

phase3.name = '3';
phase3.high = 16;
phase3.medium = 8;
phase3.low = 2;
phase3.contol = 8;
phase3.highlow_first = expt.highlow_first;
phase3.probe_highlow_first = expt.probe_highlow_first;

%% Check feeders
for i=1:length(expt.feeders)
	f = expt.feeders{i};
	disp(['Firing ', f.name, ' (', num2srt(expt.feeder.n_pellets), ' pellets) ...']);
	fireFeeder(expt.feeder_port, f.pin, expt.feeder.n_pellets);
end

%% Run maze

% Running state
state.timer = tic();
state.high.name = 'High';
state.high.carryover = '';
state.medium.name = 'Medium';
state.medium.carryover = '';
state.control.name = 'Control';
state.control.carryover = '';
state.low.name = 'Low';
state.low.carryover = '';

initDisplay(state);

phases = {phase1, phase2, phase3};
for i=1:length(phases)
	phase = phases{i};

	set(state.display.messages, 'String', '');
	initPhase(expt, phase, state);
	while state.current_n < phase.total
		getTrial(expt, phase, state);
		runTrial(expt, phase, state);
	end
	verifyTrial(expt, phase, state);
	set(state.display.messages, 'String', sprintf('End of phase %d. Press a key or mouse button to continue.', i));
	waitforbuttonpress();
end
