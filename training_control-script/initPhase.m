function [expt, phase, state] = initPhase(expt, phase, state)

	phase.template = cell(1, phase.total);
	if phase.north_first
		phase.template(1:3:end) = {'North'};
		phase.template(2:3:end) = {'East'};
		phase.template(3:3:end) = {'South'};
    else
		phase.template(1:3:end) = {'South'};
		phase.template(2:3:end) = {'East'};
		phase.template(3:3:end) = {'North'};
	end

	assert(sum(ismember(phase.template, {'North'})) == phase.north);
	assert(sum(ismember(phase.template, {'East'})) == phase.east);
	assert(sum(ismember(phase.template, {'South'})) == phase.south);

end