function phase = initPhase(phase)

	phase.template = cell(1, phase.total);
    phase.template(2:2:end) = {'East'};
    
    if phase.ordered
        if phase.north_first
            phase.template(1:4:end) = {'North'};
            phase.template(3:4:end) = {'South'};
        else
            phase.template(1:4:end) = {'South'};
            phase.template(3:4:end) = {'North'};
        end
    else
        randomized = cell(1, phase.north+phase.south-1);
        if phase.north_first
            n_north = phase.north-1;
            n_south = phase.south;
            phase.template(1) = {'North'};
        else
            n_north = phase.north;
            n_south = phase.south-1;
            phase.template(1) = {'South'};
        end
        randomized(1:n_north) = {'North'};
        randomized(n_north+1:n_south+n_north) = {'South'};
        randomized = datasample(randomized, length(randomized), 'Replace', false);
        phase.template(3:2:end) = randomized;
    end
    
	assert(sum(ismember(phase.template, {'North'})) == phase.n);
	assert(sum(ismember(phase.template, {'East'})) == phase.n * 2);
	assert(sum(ismember(phase.template, {'South'})) == phase.n);

end