function phase = initPhase(phase)

	phase.template = cell(1, phase.total);
	if phase.north_first
		phase.template(2:2:end) = {'East'};
		phase.template(1:4:end) = {'North'};
		phase.template(3:4:end) = {'South'};
    else
    	phase.template(2:2:end) = {'East'};
		phase.template(1:4:end) = {'South'};
		phase.template(3:4:end) = {'North'};
	end

	assert(sum(ismember(phase.template, {'North'})) == phase.n);
	assert(sum(ismember(phase.template, {'East'})) == phase.n * 2);
	assert(sum(ismember(phase.template, {'South'})) == phase.n);

end