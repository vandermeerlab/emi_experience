function [expt, phase, state] = getTrial(expt, phase, state)
	%  Selects next trial given a list of available available_trials
    
	state.n = state.n + 1;

	% possible states are:
	%  'return': initial state, returning from feeder to center
	%  'approach': running from center to feeder
	state.state = 'return';
	state.last_pb_state = 0;

	state.trial = phase.template{state.n};

	% Update display

	% Template
	display_template = phase.template(1:end);
	display_template{state.n} = ['\bf ', display_template{state.n}, ' \rm'];
	set(state.display.template, 'String', display_template);

	% Trial
	set(state.display.trial, 'String', sprintf('Forced trial, %s', state.trial.name));
end