function state = initDisplay(state)
	clf;
	state.display.fig = figure(1);
	set(state.display.fig, 'Position', [400, 100, 900, 900]);

	% annotation dim = [x y w h]

	state.display.template_a = annotation('textbox', [0.05, 0.05, 0.25, 0.9]);
	set(state.display.template_a, 'String', 'Template A');
	set(state.display.template_a, 'FitBoxToText', 'off');
	set(state.display.template_a, 'FontSize', 12);
	set(state.display.template_a, 'HorizontalAlignment', 'left'); % left center right
	set(state.display.template_a, 'VerticalAlignment', 'middle'); % top middle bottom

	state.display.template_b = annotation('textbox', [0.15, 0.05, 0.15, 0.9]);
	set(state.display.template_b, 'String', 'Template B');
	set(state.display.template_b, 'FitBoxToText', 'off');
	set(state.display.template_b, 'FontSize', 12);
	set(state.display.template_b, 'HorizontalAlignment', 'right'); % left center right
	set(state.display.template_b, 'VerticalAlignment', 'middle'); % top middle bottom
	set(state.display.template_b, 'LineStyle', 'none')
% 	set(state.display.template_b, 'HeadStyle', 'none')

	state.display.status = annotation('textbox', [0.35, 0.75, 0.6, 0.2]);
	set(state.display.status, 'String', 'Status');
	set(state.display.status, 'FitBoxToText', 'off');
	set(state.display.status, 'FontSize', 16);
	set(state.display.status, 'HorizontalAlignment', 'center');
	set(state.display.status, 'VerticalAlignment', 'middle');

	state.display.trial = annotation('textbox', [0.35, 0.35, 0.6, 0.3]);
	set(state.display.trial, 'String', 'Trial');
	set(state.display.trial, 'FitBoxToText', 'off');
	set(state.display.trial, 'FontSize', 18);
	set(state.display.trial, 'HorizontalAlignment', 'center');
	set(state.display.trial, 'VerticalAlignment', 'middle');

	state.display.messages = annotation('textbox', [0.35, 0.05, 0.6, 0.2]);
	set(state.display.messages, 'String', 'Messages');
	set(state.display.messages, 'FitBoxToText', 'off');
	set(state.display.messages, 'FontSize', 16);
	set(state.display.messages, 'HorizontalAlignment', 'center');
	set(state.display.messages, 'VerticalAlignment', 'middle');
    set(state.display.messages, 'Color', 'red');

	axis off;
end