function [] = verifyTrial(phase, state)
    assert(state.n == phase.total);
end