function outcome = initOutcome(outcome, n_trials, reward_prob)
	outcome.rewarded = floor(n_trials * reward_prob);
	outcome.unrewarded = floor(n_trials * (1 - reward_prob));
	if outcome.rewarded + outcome.unrewarded ~= n_trials
		if strcmp(outcome.carryover, 'rewarded')
			outcome.rewarded = outcome.rewarded + 1;
			outcome.carryover = '';
		elseif strcmp(outcome.carryover, 'unrewarded')
			outcome.unrewarded = outcome.unrewarded + 1;
			outcome.carryover = '';
		elseif rand() < reward_prob
			outcome.rewarded = outcome.rewarded + 1;
			outcome.carryover = 'unrewarded';
		else
			outcome.unrewarded = outcome.unrewarded + 1;
			outcome.carryover = 'rewarded';
		end
		assert(outcome.rewarded + outcome.unrewarded == n_trials);
	end
	outcome.tones = outcome.rewarded;
end