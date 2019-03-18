function [expt, phase, state] = runTrial(expt, phase, state)

	disp(sprintf('Starting trial %d', state.n));
	NlxSendCommand(sprintf('-PostEvent "trial start" 0 0'));
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
	    if strcmp(state.state, 'return')
	    	if strcmp(state.trial, 'Probe-HighLow')
	    		arm = expt.outcome2arm('High');
    			if isequal(pb, arm.start_pb)
    				new_state = 'approach';
    				approaching = state.high;
    			else
    				arm = expt.outcome2arm('Low');
    			    if isequal(pb, arm.start_pb)
    					new_state = 'approach';
    					approaching = state.low;
                    end
    			end
	    	elseif strcmp(state.trial, 'Probe-Mediums')
	    		arm = expt.outcome2arm('Medium');
    			if isequal(pb, arm.start_pb)
    				new_state = 'approach';
    				approaching = state.medium;
    			else
    				arm = expt.outcome2arm('Control');
    			    if isequal(pb, arm.start_pb)
    					new_state = 'approach';
    					approaching = state.control;
                    end
    			end
	    	else
    			arm = expt.outcome2arm(state.trial.name);
    			if isequal(pb, arm.start_pb)
    				new_state = 'approach';
    				approaching = state.trial;
    			end
    		end
    	else
    		assert(strcmp(state.state, 'approach'));
	    	if strcmp(state.trial, 'Probe-HighLow')
	    		arm = expt.outcome2arm('High');
    			if isequal(pb, arm.end_pb)
    				new_state = 'return';
    			else
    				arm = expt.outcome2arm('Low');
    			    if isequal(pb, arm.end_pb)
    					new_state = 'return';
                    end
    			end
	    	elseif strcmp(state.trial, 'Probe-Mediums')
	    		arm = expt.outcome2arm('Medium');
    			if isequal(pb, arm.end_pb)
    				new_state = 'return';
    			else
    				arm = expt.outcome2arm('Control');
    			    if isequal(pb, arm.end_pb)
    					new_state = 'return';
                    end
    			end
	    	else
    			arm = expt.outcome2arm(state.trial.name);
    			if isequal(pb, arm.end_pb)
    				new_state = 'return';
    			end
    		end
		end

		% Do state change actions
		if strcmp(new_state, 'return')
			if state.rewarded
				fireFeeder(expt.feeder_port, arm.feeder.pin, expt.feeder.n_pellets);
				NlxSendCommand(sprintf('-PostEvent "firing feeder %s" 0 0', arm.feeder.name));
            else
                NlxSendCommand(sprintf('-PostEvent "NOT firing feeder %s" 0 0', arm.feeder.name));
			end
			NlxSendCommand(sprintf('-PostEvent "entering %s state" 0 0', new_state));
			state.state = new_state;
			finished = 1;
		elseif strcmp(new_state, 'approach')
			if state.tone
				play(expt.tone);
				NlxSendCommand(sprintf('-PostEvent "tone on" 0 0'));
                approaching.tones = approaching.tones - 1;
% 				if isequal(approaching, state.control)
% 					state.control.tones = state.control.tones - 1;
% 				end
			end
			NlxSendCommand(sprintf('-PostEvent "entering %s state" 0 0', new_state));

			% Update trial outcome totals
			if state.rewarded
				approaching.rewarded = approaching.rewarded - 1;
			else
				approaching.unrewarded = approaching.unrewarded - 1;
			end
			state.state = new_state;
        end


		seconds = toc(state.timer);
		time.hours = floor(seconds / (60 * 60));
		time.minutes = mod(floor(seconds / 60), 60);
		time.seconds = mod(seconds, 60);

	    set(state.display.status, 'String', ...
	    	sprintf('Time %02.0f:%02.0f:%02.0f \t Phase %s \t State: %s', time.hours, time.minutes, time.seconds, phase.name, state.state));
    
		drawnow;
    end

    if strcmp(state.trial, 'Probe-HighLow') | strcmp(state.trial, 'Probe-Mediums')
        fprintf(state.log, '%s~\n', arm.name);
    else
        fprintf(state.log, '%s~\n', arm.name);
    end
    
    if strcmp(approaching.name, 'High')
        state.high = approaching;
    elseif strcmp(approaching.name, 'Low')
        state.low = approaching;
    elseif strcmp(approaching.name, 'Medium')
        state.medium = approaching;
    elseif strcmp(approaching.name, 'Control')
        state.control = approaching;
    end

	NlxSendCommand(sprintf('-PostEvent "trial end" 0 0'));
end