function [pabufTarget, pabufTestTone] = loadAudioslave(paTarget, targetArray, Stimuli, paTestTone)
%FUNCTION_HEADER - 
% 
% Syntax:  [y] = FUNCTION_HEADER(x)
%
% Input: 
%           x:             
%
% Output:
% 
%           y:            
%
% Example:
%
%           [y] = FUNCTION_HEADER(x)
%
% m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: David C Greatrex
% Work Address: Centre for Music and Science, Cambridge University
% email: dcg32@cam.ac.uk
% Website: http://www.davidgreatrex.com
% mmm YYYY; Last revision: DD-MM-YYYY
    
%------------------------------------------
try 
    % load and lateralise target noise burst sequence
	lateralized = {}; 
	for i = 1:length(targetArray)    	
        % create broadband Gaussian noise    
		noise = noiseGen(Stimuli.noiseDur, Stimuli.playbackFreq, ...    
				  Stimuli.isRamp, Stimuli.gateDur, 0);

		% IID lateralisation - Db input
        lateralized{i} = IIDSchnupp(targetArray(i), noise, Stimuli.playbackFreq);
        % fill targetArray buffer
		pabufTarget(i) = PsychPortAudio('CreateBuffer', [], lateralized{i}); 
	    PsychPortAudio('FillBuffer', paTarget, pabufTarget(i)); 
	end

    % create probe tone 2 kHz stimulus
    freq1 = 2000;
    numSamples=round(Stimuli.playbackFreq*0.050);
    time=(1:numSamples)/Stimuli.playbackFreq;
    tone=sin(2*pi*freq1*time);  % pure tone
    gate = cos(linspace(pi, 2*pi, Stimuli.playbackFreq*0.005));
    gate = gate+1;
    gate = gate/2;
    offsetgate = fliplr(gate);
    sustain = ones(1, (length(tone)-2*length(gate)));
    envelope = [gate, sustain, offsetgate];
    audio = envelope .* tone;

    % Set the ILD for the probe tone to zero as it will function as a reference for mid-point
    IID = 0;
    %lateralise probetone
    testTone = IIDSchnupp(IID, audio, Stimuli.playbackFreq);
    % fill testtone buffer
    pabufTestTone = PsychPortAudio('CreateBuffer', [], testTone); 
	PsychPortAudio('FillBuffer', paTestTone, pabufTestTone); 

	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------