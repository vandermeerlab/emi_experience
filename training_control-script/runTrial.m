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

	    % Determine state changes
	    new_state = '';
	    if state.state == 'return'
			arm = state.trial.name;
			if isequal(pb, arm.start_pb)
				new_state = 'approach';
				approaching = state.trial;
    		end
    	else
    		assert(state.state, 'approach');
			arm = state.trial.name;
			if isequal(pb, arm.end_pb)
				new_state = 'return';
    		end
		end

		% Do state change actions
		if strcmp(new_state, 'return')
			fireFeeder(expt.feeder_port, arm.feeder.pin, expt.feeder.n_pellets);
			NlxSendCommand(sprintf('-PostEvent "feeder %s" 0 0', arm.feeder.name));
			NlxSendCommand(sprintf('-PostEvent "entering %s state" 0 0', new_state));
			state.state = new_state;
			finished = 1;
		elseif strcmp(new_state, 'approach')
			NlxSendCommand(sprintf('-PostEvent "entering %s state" 0 0', new_state));

			% Update trial outcome totals
			approaching = approaching - 1;
			state.state = new_state;
		end

 	    set(state.display.status, 'String', ...
 	    	sprintf('Time %0.1f \t Phase %s \t State: %s', toc(state.timer), phase.name, state.state));
        
        drawnow;
	end

	NlxSendCommand(sprintf('-PostEvent "end of trial %d" 0 0', state.n));
end