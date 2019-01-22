function [] = initDisplay(state)
	clf;
	state.display.fig = figure(1);
	set(state.display.fig, 'Position', [400, 100, 900, 900]);

	% annotation dim = [x y w h]

	state.display.template = annotation('textbox', [0.05, 0.05, 0.15, 0.9]);
	set(state.display.template, 'String', 'Template');
	set(state.display.template, 'FitBoxToText', 'off');
	set(state.display.template, 'FontSize', 16);
	% set(state.display.template, 'HorizontalAlignment', 'center'); % left center right
	set(state.display.template, 'VerticalAlignment', 'middle'); % top middle bottom

	state.display.status = annotation('textbox', [0.25, 0.05, 0.7, 0.2]);
	set(state.display.status, 'String', 'Status');
	set(state.display.status, 'FitBoxToText', 'off');
	set(state.display.status, 'FontSize', 16);
	% set(state.display.status, 'HorizontalAlignment', 'center');
	set(state.display.status, 'VerticalAlignment', 'middle');

	state.display.trial = annotation('textbox', [0.25, 0.35, 0.7, 0.3]);
	set(state.display.trial, 'String', 'Trial');
	set(state.display.trial, 'FitBoxToText', 'off');
	set(state.display.trial, 'FontSize', 16);
	% set(state.display.trial, 'HorizontalAlignment', 'center');
	set(state.display.trial, 'VerticalAlignment', 'middle');

	state.display.messages = annotation('textbox', [0.25, 0.75, 0.7, 0.2]);
	set(state.display.messages, 'String', 'Messages');
	set(state.display.messages, 'FitBoxToText', 'off');
	set(state.display.messages, 'FontSize', 16);
	% set(state.display.messages, 'HorizontalAlignment', 'center');
	set(state.display.messages, 'VerticalAlignment', 'middle');

	axis off;
end