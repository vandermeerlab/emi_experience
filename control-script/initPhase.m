function [] = initPhase(expt, phase, state)
	phase.total = phase.high+phase.medium+phase.low+phase.control;
	state.n = 0;
	state.rewarded = 0;
	state.tone = 0;
	state.probed_highlow = 0;
	state.probed_mediums = 0;

	state.high = initOutcome(state.high, phase.high, expt.feeder.prob);
	state.low = initOutcome(state.low, phase.low, expt.feeder.prob);
	state.medium = initOutcome(state.medium, phase.medium, expt.feeder.prob);
	state.control = initOutcome(state.control, phase.control, expt.feeder.prob);

	phase.template = cell(1, phase.total);
	if phase.highlow_first
		phase.template(1:2:end) = 'Forced_HighLow';
		phase.template(2:2:end) = 'Forced_Mediums';
	else
		phase.template(1:2:end) = 'Forced_Mediums';
		phase.template(2:2:end) = 'Forced_HighLow';
	end

	probe.first = floor(phase.total/3);
	probe.second = probe.first * 2;
	if phase.probe_highlow_first
		probe.first_choice = 'HighLow';
		probe.second_choice = 'Mediums';
	else
		probe.first_choice = 'Mediums';
		probe.second_choice = 'HighLow';
	end

	if ~strcmp(phase.template{probe.first}, strcat('Forced_', probe.first_choice))
		probe.first = probe.first + 1;
	end
	assert(strcmp(phase.template(probe.first), strcat('Forced_', probe.first_choice)));
	phase.template(probe.first) = strcat('Probe_', probe.first_choice);
	if ~strcmp(phase.template{probe.second}, strcat('Forced_', probe.second_choice))
		probe.second = probe.second + 1;
	end
	assert(strcmp(phase.template(probe.second), strcat('Forced_', probe.second_choice)));
	phase.template(probe.second) = strcat('Probe_', probe.second_choice);

	assert(sum(contains(phase.template, "Forced_HighLow")) == phase.high + phase.low - 1);
	assert(sum(contains(phase.template, "Forced_Mediums")) == phase.medium + phase.control - 1);
	assert(sum(contains(phase.template, "Probe_HighLow")) == 1);
	assert(sum(contains(phase.template, "Probe_Mediums")) == 1);
end