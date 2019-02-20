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

            NlxSendCommand(sprintf('-PostEvent "broken photobeam %s" 0 0', pb.name));

            state.last_pb_state = pb_state;

            arm = expt.outcome2arm(state.trial);

            if isequal(pb, arm.pb)
                fireFeeder(expt.feeder_port, arm.feeder.pin, expt.feeder.n_pellets);
                NlxSendCommand(sprintf('-PostEvent "firing feeder %s" 0 0', arm.feeder.name));
                finished = 1;
            end
        end

        seconds = toc(state.timer);
        time.hours = floor(seconds / (60 * 60));
        time.minutes = mod(floor(seconds / 60), 60);
        time.seconds = mod(seconds, 60);

        set(state.display.status, 'String', ...
            sprintf('Time %02.0f:%02.0f:%02.0f \t Phase: %s \t Trial: %d', time.hours, time.minutes, time.seconds, phase.name, state.n));

        drawnow;
    end

    fprintf(state.log, '%s\n', arm.name);
    
	NlxSendCommand(sprintf('-PostEvent "trial end" 0 0'));
end