function [expt, phase, state] = runTrial(expt, phase, state)

	disp(sprintf('Starting trial %d', state.n));
	NlxSendCommand(sprintf('-PostEvent "starting trial %d" 0 0', state.n));
	finished = 0;

	while ~finished && toc(state.timer) < expt.max_time

	    % check for any broken photobeams and update
	    pb_state = checkSensor(expt.photobeam_port);
	    pb = [];
	    
	    if pb_state > 0 && pb_state ~= state.last_pb_state
	    	for i=1:length(expt.photobeams)
	    		pb = expt.photobeams{i};
	    		if pb_state == pb.pin
	    			break;
	    		end
	    	end
	    	assert(pb.pin == pb_state)
            
            NlxSendCommand(sprintf('-PostEvent "photobeam %s" 0 0', pb.name));
            
            state.last_pb_state = pb_state;
	    end

	    arm = state.trial.name;
		if isequal(pb, arm.pb)
			fireFeeder(expt.feeder_port, arm.feeder.pin, expt.feeder.n_pellets);
			NlxSendCommand(sprintf('-PostEvent "feeder %s" 0 0', arm.feeder.name));
			finished = 1;
			% Update trial outcome totals
			state.trial = state.trial - 1;
		end

		seconds = toc(state.timer);
		time.hours = floor(seconds / (60 * 60));
		time.minutes = mod(floor(seconds / 60), 60);
		time.seconds = mod(seconds, 60);

 	    set(state.display.status, 'String', ...
 	    	sprintf('Time %02.0f:%02.0f:%02.0f \t Phase %s \t State: %s', time.hours, time.minutes, time.seconds, phase.name, state.state));
        
        drawnow;
	end

	NlxSendCommand(sprintf('-PostEvent "end of trial %d" 0 0', state.n));
end