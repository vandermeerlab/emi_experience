function rewarded = isRewarded(outcome, paired_outcome, reward_prob)
	if outcome.rewarded == 0
		rewarded = 0;
	elseif outcome.unrewarded == 0
		rewarded = 1;
	elseif outcome.rewarded == 1 && paired_outcome.unrewarded == 0
		assert(outcome.unrewarded > 0);
		rewarded = 0;
	elseif outcome.unrewarded == 1 && paired_outcome.rewarded == 0
		assert(outcome.rewarded > 0);
		rewarded = 1;
	else
		rewarded = rand() < reward_prob;
	end
end