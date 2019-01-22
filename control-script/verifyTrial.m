function [] = verifyTrial(phase, state)
	assert(state.high.rewarded == 0);
	assert(state.high.unrewarded == 0);
	assert(state.low.rewarded == 0);
	assert(state.low.unrewarded == 0);
	assert(state.medium.rewarded == 0);
	assert(state.medium.unrewarded == 0);
	assert(state.control.rewarded == 0);
	assert(state.control.unrewarded == 0);
	assert(state.control.tones == 0);
end