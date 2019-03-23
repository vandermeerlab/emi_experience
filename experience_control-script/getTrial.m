function [expt, phase, state] = getTrial(expt, phase, state)
	%  Selects next trial given a list of available available_trials
    
	state.n = state.n + 1; % +1 for the right index
	% possible states are:
	%  'return': initial state, returning from feeder to center
	%  'approach': running from center to feeder
	state.state = 'return';
	state.last_pb_state = 0;
    
	template = phase.template{state.n};
	if strcmp(template, 'HighLow')
        probes_left = phase.n_each_probe - state.probed_highlow;
		n_high = state.high.rewarded + state.high.unrewarded;
		n_low = state.low.rewarded + state.low.unrewarded;
        if n_high <= probes_left
            state.trial = state.low;
        elseif n_low <= probes_left
            state.trial = state.high;
        else
            p_high = n_high / (n_high + n_low);
            if rand() < p_high
                state.trial = state.high;
            else
                state.trial = state.low;
            end
        end
        state.rewarded = isRewarded(state.trial, expt.feeder.prob);
	elseif strcmp(template, 'Mediums')
        probes_left = phase.n_each_probe - state.probed_mediums;
		n_medium = state.medium.rewarded + state.medium.unrewarded;
		n_control = state.control.rewarded + state.control.unrewarded;
        if n_medium <= probes_left
            state.trial = state.control;
        elseif n_control <= probes_left;
            state.trial = state.medium;
        else
            p_medium = n_medium / (n_medium + n_control);
            if rand() < p_medium
                state.trial = state.medium;
            else
                state.trial = state.control;
            end
        end
        state.rewarded = isRewarded(state.trial, expt.feeder.prob);
	else
		state.trial = template;
		if strcmp(template, 'Probe-HighLow')
			combined.rewarded = min([state.high.rewarded, state.low.rewarded]);
			combined.unrewarded = min([state.high.unrewarded, state.low.unrewarded]);
		else
			assert(strcmp(template, 'Probe-Mediums'))
			combined.rewarded = min([state.medium.rewarded, state.control.rewarded]);
			combined.unrewarded = min([state.medium.unrewarded, state.control.unrewarded]);
        end
        assert(combined.rewarded + combined.unrewarded > 0)
        state.rewarded = isRewarded(combined, expt.feeder.prob);
    end

	if isequal(state.trial, state.control)
		% For control, randomly select tone unless we are forced
		if state.control.rewarded + state.control.unrewarded == state.control.tones
			state.tone = 1;
		elseif state.control.tones == 0
			state.tone = 0;
		else
			state.tone = rand() < expt.feeder.prob;
		end
	else
		% note: means that the control arm will have predictable reward on probe trials
		state.tone = state.rewarded;
	end

	% Update display

	% Template
	display_template = phase.template(1:end);
	display_template{state.n} = ['\bf ', display_template{state.n}, ' \rm'];
	set(state.display.template, 'String', display_template);
    
    high = expt.outcome2arm('High').name;
	low = expt.outcome2arm('Low').name;
    medium = expt.outcome2arm('Medium').name;
	control = expt.outcome2arm('Control').name;
        
	% Trial
	lines = cell(1, 3);
	if strcmp(state.trial, 'Probe-HighLow')
		lines{1} = sprintf('Probe trial, %s vs %s', high, low);
	elseif strcmp(state.trial, 'Probe-Mediums')
		lines{1} = sprintf('Probe trial: %s vs %s', medium, control);
	else
		arm = expt.outcome2arm(state.trial.name).name;
		lines{1} = sprintf('Forced trial: %s', arm);
	end
	lines{3} = sprintf('Rewarded: %d \t Tone: %d', state.rewarded, state.tone);
	set(state.display.trial, 'String', lines);
    
    % Trial
	lines = cell(1, 4);
    lines{1} = sprintf('%s: \t %d+ \t %d- \t total %d', high, state.high.rewarded, state.high.unrewarded, state.high.rewarded + state.high.unrewarded);
    lines{2} = sprintf('%s: \t %d+ \t %d- \t total %d', low, state.low.rewarded, state.low.unrewarded, state.low.rewarded + state.low.unrewarded);
    lines{3} = sprintf('%s: \t %d+ \t %d- \t total %d', medium, state.medium.rewarded, state.medium.unrewarded, state.medium.rewarded + state.medium.unrewarded);
    lines{4} = sprintf('%s: \t %d+ \t %d- \t total %d', control, state.control.rewarded, state.control.unrewarded, state.control.rewarded + state.control.unrewarded);
    set(state.display.messages, 'Color', 'black');
    set(state.display.messages, 'String', lines);
    
    drawnow;
end