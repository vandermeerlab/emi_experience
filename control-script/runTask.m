function complete = runTask(experiment, phase)

complete = 0;

if experiment.current_n < phase.total

	trial = getTrial(experiment, phase1)

	if ismember(trial, available_high)
		phase.high = phase.high - 1
	elseif ismember(trial, available_low)
		phase.low = phase.low - 1
	elseif ismember(trial, available_medium)
		phase.medium = phase.medium - 1
	elseif ismember(trial, available_random)
		phase.random = phase.random - 1
	end

else
	complete = 1;

end