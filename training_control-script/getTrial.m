function [phase, state] = getTrial(phase, state, reward_prob)
	%  Selects next trial given a template of all trials
    
	state.n = state.n + 1;
	state.last_pb_state = 0;

	state.trial = phase.template{state.n};

	state.rewarded = rand() < reward_prob;

	% Update display template
	display_template = phase.template(1:end);
	display_template{state.n} = ['\bf ', display_template{state.n}, ' \rm'];

	halfway_idx = ceil(length(display_template)/2);

	set(state.display.template_a, 'String', display_template(1:halfway_idx));
	set(state.display.template_b, 'String', display_template(halfway_idx+1:end));

	% Update display trial
	set(state.display.trial, 'String', sprintf('Forced trial, %s', state.trial));
    
    drawnow;
end