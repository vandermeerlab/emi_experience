function speaker = makeTone(duration_seconds, frequency)
	%  Generates a tone based on a sine wave
	volume = 0.1;
	sample_rate = 44100; % the bit rate of the tone
	output_channel = 4; % 11 and 12 are the two OSD amplifiers
	left_channel = 1; % left or right channel (0/1), i.e. which of the two speakers connected to amp to use
	n_bits = 16;

	sine_wave = sin(linspace(0, duration_seconds * frequency * 2 * pi, round(duration_seconds * sample_rate));
	tone = [sine_wave'*left tone'*abs(left_channel-1)]; 
	tone = tone.*volume;
	speaker = audioplayer([tone], sample_rate, n_bits, output_channel);
end