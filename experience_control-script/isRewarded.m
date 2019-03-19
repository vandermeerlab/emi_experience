function rewarded = isRewarded(outcome, reward_prob)
	if outcome.rewarded == 0
		rewarded = 0;
	elseif outcome.unrewarded == 0
		rewarded = 1;
	else
		rewarded = rand() < reward_prob;
	end
end