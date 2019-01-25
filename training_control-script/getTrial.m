function [phase, state] = getTrial(phase, state)
	%  Selects next trial given a template of all trials
    
	state.n = state.n + 1;
	state.last_pb_state = 0;

	state.trial = phase.template{state.n};

	% Update display template
	display_template = phase.template(1:end);
	display_template{state.n} = ['\bf ', display_template{state.n}, ' \rm'];
	set(state.display.template, 'String', display_template);

	% Update display trial
	set(state.display.trial, 'String', sprintf('Forced trial, %s', state.trial.name));
    
    drawnow;
end