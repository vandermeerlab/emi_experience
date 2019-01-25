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
expt.north.pb.pin = 2^4;
expt.north.pb.name = 'NorthPB';

expt.east.pb.pin = 2^5;
expt.east.pb.name = 'EastPB';

expt.south.pb.pin = 2^6;
expt.south.pb.name = 'SouthStartPB';

expt.photobeams = {expt.north.pb, expt.east.pb,	expt.south.pb};

% Feeders
expt.feeder.n_pellets = 2;

expt.north.feeder.name = 'NorthFeeder';
expt.north.feeder.pin = 6;
expt.east.feeder.name = 'EastFeeder';
expt.east.feeder.pin = 7;
expt.south.feeder.name = 'SouthFeeder';
expt.south.feeder.pin = 8;

expt.feeders = {expt.north.feeder, expt.east.feeder, expt.south.feeder};

% Trial parameters
expt.max_time = 5 * 60 * 60; % max time for the experiment to run (sec)

% phase parameters
phase.name = 'training';
phase.n = 20;
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
phase = initPhase(phase);

state.n = 0;

set(state.display.messages, 'String', '');

while state.n < phase.total
    [phase, state] = getTrial(phase, state);
    [expt, phase, state] = runTrial(expt, phase, state);
end

verifyTrial(phase, state);
set(state.display.messages, 'String', sprintf('End of %s. Running phases are finished for this session.', phase.name));
drawnow;
