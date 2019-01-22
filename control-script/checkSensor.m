function pin_state = checkSensor(port)
	[succeeded, cheetah_reply] = NlxSendCommand(cat(2, '-GetDigitalIOPortString AcqSystem1_0 ', num2str(port)));
	pin_state = bin2dec(cheetahReply);
end