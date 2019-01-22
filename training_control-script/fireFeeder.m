function fireFeeder(TTL_port, TTL_pin, n_pellets)
pulseDuration = n_pellets*700;

if (n_pellets ~= 0) % nonzero number
    [succeeded, ~] = NlxSendCommand(cat(2,'-SetDigitalIOPulseDuration AcqSystem1_0 ',num2str(TTL_port),' ',num2str(pulseDuration)));
    if succeeded == 0
        disp 'FAILED to set duration'
        return;
    end

    [succeeded, ~] = NlxSendCommand(cat(2,'-DigitalIOTTLPulse AcqSystem1_0 ',num2str(TTL_port),' ',num2str(TTL_pin),' High'));
    if succeeded == 0
        disp 'FAILED to pulse'
        return;
    end
else
    [succeeded, ~] = NlxSendCommand('-PostEvent "Null Pellet" 128 666');
    if succeeded == 0
        disp 'FAILED to set duration. Set number of pellets > 0.'
        return;
    end
end
end
