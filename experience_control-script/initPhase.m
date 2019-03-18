function [expt, phase, state] = initPhase(expt, phase, state)
    assert(phase.low > phase.n_each_probe)
    
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
		phase.template(1:2:end) = {'HighLow'};
		phase.template(2:2:end) = {'Mediums'};
    else
		phase.template(1:2:end) = {'Mediums'};
		phase.template(2:2:end) = {'HighLow'};
    end
    
    probe.n = phase.n_each_probe * 2;
    probe_idx = floor(phase.total/(probe.n+1));
    
    for i=1:probe.n % there's got to be a better way to do this logic...
        idx = probe_idx * i;
        if phase.highlow_first
            if phase.probe_highlow_first
                if rem(i, 2) % if i is odd
                    if rem(idx, 2) % make sure that idx is odd
                        phase.template{idx} = 'Probe-HighLow';
                    else
                        phase.template{idx-1} = 'Probe-HighLow';
                    end
                else % if i is even
                    if ~rem(idx, 2) % make sure that idx is even
                        phase.template{idx} = 'Probe-Mediums';
                    else
                        phase.template{idx-1} = 'Probe-Mediums';
                    end
                end
            else
                if ~rem(i, 2) % if i is even
                    if rem(idx, 2) % make sure that idx is odd
                        phase.template{idx} = 'Probe-HighLow';
                    else
                        phase.template{idx-1} = 'Probe-HighLow';
                    end
                else % if i is odd
                    if ~rem(idx, 2) % make sure that idx is even
                        phase.template{idx} = 'Probe-Mediums';
                    else
                        phase.template{idx-1} = 'Probe-Mediums';
                    end
                end
            end
        else
            if phase.probe_highlow_first
                if rem(i, 2) % if i is odd
                    if ~rem(idx, 2) % make sure that idx is even
                        phase.template{idx} = 'Probe-HighLow';
                    else
                        phase.template{idx-1} = 'Probe-HighLow';
                    end
                else % if i is even
                    if rem(idx, 2) % make sure that idx is odd
                        phase.template{idx} = 'Probe-Mediums';
                    else
                        phase.template{idx-1} = 'Probe-Mediums';
                    end
                end
            else
                if ~rem(i, 2) % if i is even
                    if ~rem(idx, 2) % make sure that idx is even
                        phase.template{idx} = 'Probe-HighLow';
                    else
                        phase.template{idx-1} = 'Probe-HighLow';
                    end
                else % if i is odd
                    if rem(idx, 2) % make sure that idx is odd
                        phase.template{idx} = 'Probe-Mediums';
                    else
                        phase.template{idx-1} = 'Probe-Mediums';
                    end
                end
            end
        end
    end

	assert(sum(ismember(phase.template, {'HighLow'})) == phase.high + phase.low - phase.n_each_probe);
	assert(sum(ismember(phase.template, {'Mediums'})) == phase.medium + phase.control - phase.n_each_probe);
	assert(sum(ismember(phase.template, {'Probe-HighLow'})) == phase.n_each_probe);
	assert(sum(ismember(phase.template, {'Probe-Mediums'})) == phase.n_each_probe);
end