function pin_state = checkSensor(port)
	[~, cheetah_reply] = NlxSendCommand(cat(2, '-GetDigitalIOPortString AcqSystem1_0 ', num2str(port)));
	pin_state = bin2dec(cheetah_reply);
end