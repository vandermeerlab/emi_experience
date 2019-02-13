function rewarded = isRewarded(outcome, probed, reward_prob)
	if probed
		min_rewarded = 0;
		min_unrewarded = 0;
	else
		min_rewarded = 1;
		min_unrewarded = 1;
	end

	if outcome.rewarded < min_rewarded
		rewarded = 0;
	elseif outcome.unrewarded < min_unrewarded
		rewarded = 1;
	else
		rewarded = rand() < reward_prob;
	end
end