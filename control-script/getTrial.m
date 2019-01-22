function [] = getTrial(expt, phase, state)
	%  Selects next trial given a list of available available_trials

	state.n = state.n + 1;
	% possible states are:
	%  'return': initial state, returning from feeder to center
	%  'approach': running from center to feeder
	state.state = 'return';
	state.last_pb_state = 0;

	template = phase.template{state.n};
	if strcmp(template, 'Forced_HighLow')
		n_high = state.high.rewarded + state.high.unrewarded;
		n_low = state.low.rewarded + state.low.unrewarded;
		p_high = n_high / (n_high + n_low);
		if rand() < p_high
			state.trial = state.high;
		else
			state.trial = state.low;
		end
		state.rewarded = isRewarded(state.trial, state.probed_highlow, expt.feeder.prob);
	elseif strcmp(template, 'Forced_Mediums')
		n_medium = state.medium.rewarded + state.medium.unrewarded;
		n_control = state.control.rewarded + state.control.unrewarded;
		p_medium = n_medium / (n_medium + n_control);
		if rand() < p_medium
			state.trial = state.medium;
		else
			state.trial = state.control;
		end
		state.rewarded = isRewarded(state.trial, state.probed_mediums, expt.feeder.prob);
	else
		state.trial = template;
		if strcmp(template, 'Probe_HighLow')
			combined.rewarded = min([state.high.rewarded, state.low.rewarded]);
			combined.unrewarded = min([state.high.unrewarded, state.low.unrewarded]);
		else
			assert(strcmp(template, 'Probe_Mediums'))
			combined.rewarded = min([state.medium.rewarded, state.control.rewarded]);
			combined.unrewarded = min([state.medium.unrewarded, state.control.unrewarded]);
		end
		state.rewarded = isRewarded(combined, 0, expt.feeder.prob);
	end

	if eq(state.trial, state.control)
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

	% Trial
	lines = cell(1, 2);
	if strcmp(state.trial, 'Probe_HighLow')
		high = expt.outcome2arm('High').name;
		low = expt.outcome2arm('Low').name;
		lines{1} = sprintf('Probe trial, %s vs %s', high, low);
	elseif strcmp(state.trial, 'Probe_Mediums')
		medium = expt.outcome2arm('Medium').name;
		control = expt.outcome2arm('Control').name;
		lines{1} = sprintf('Probe trial, %s vs %s', medium, control);
	else
		arm = expt.outcome2arm(state.trial.name).name;
		lines{1} = sprintf('Forced trial, %s', arm);
	end
	lines{2} = sprintf("Rewarded: %d\tTone: %d", state.rewarded, state.tone);
	set(state.display.trial, 'String', lines);
end