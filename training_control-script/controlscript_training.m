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

% Arms
expt.north.name = 'North';
expt.east.name = 'East';
expt.south.name = 'South';

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

expt.photobeams = {expt.north.start_pb, expt.north.end_pb, expt.east.start_pb, expt.east.end_pb, ...
	expt.south.start_pb, expt.south.end_pb};

% Feeders
expt.feeder.n_pellets = 2;

expt.north.feeder.name = 'NorthFeeder';
expt.north.feeder.pin = 0;
expt.east.feeder.name = 'EastFeeder';
expt.east.feeder.pin = 1;
expt.south.feeder.name = 'SouthFeeder';
expt.south.feeder.pin = 2;

expt.feeders = {expt.north.feeder, expt.east.feeder, expt.south.feeder};

% Trial parameters
expt.max_time = 5 * 60 * 60; % max time for the experiment to run (sec)

% phase parameters
phase.name = 'training';
phase.n = 20;
phase.north = phase.n;
phase.east = phase.n;
phase.south = phase.n;
phase.template = {};
phase.total = phase.north+phase.east+phase.south;
phase.north_first = 0;

%% Check feeders
for i=1:length(expt.feeders)
	f = expt.feeders{i};
	disp(['Firing ', f.name, ' (', num2str(expt.feeder.n_pellets), ' pellets) ...']);
	fireFeeder(expt.feeder_port, f.pin, expt.feeder.n_pellets);
end

%% Run maze

% Running state
state.timer = tic();
state.display = [];

state = initDisplay(state);

phase = phases{i};
state.n = 0;

set(state.display.messages, 'String', '');

while state.n < phase.total
    [expt, phase, state] = getTrial(expt, phase, state);
    [expt, phase, state] = runTrial(expt, phase, state);
end

verifyTrial(expt, phase, state);
set(state.display.messages, 'String', sprintf('End of %s. Running phases are finished for this session.', phase.name));
drawnow;
