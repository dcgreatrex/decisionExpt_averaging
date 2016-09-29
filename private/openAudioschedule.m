function sequenceDur = openAudioschedule(periodicIOI, paTarget, paTestTone, pabufTarget, pabufTestTone, IOIarray)
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
	%---------------------
	% assign probe tone primer
	%---------------------
	PsychPortAudio('UseSchedule', paTestTone, 1);
	cmdCode = -(1 + 16); % set AddToSchedule special command to ensure accurate timing presentation

	for i = 1:2
	    if i == 1 % assign onset asychrony to each of the target sequence values
	        PsychPortAudio('AddToSchedule', paTestTone, pabufTestTone);
	    else
	        PsychPortAudio('AddToSchedule', paTestTone, cmdCode, 0.080);
	        PsychPortAudio('AddToSchedule', paTestTone, pabufTestTone);
	    end
	end
	PsychPortAudio('AddToSchedule', paTestTone, cmdCode, periodicIOI);

	%---------------------
	% assign target tone sequence to an audio schedule
	%---------------------
	PsychPortAudio('UseSchedule', paTarget, 1);
	cmdCode = -(1 + 16); % set AddToSchedule special command to ensure accurate timing presentation

	sequenceDur = 0;
	for i = 1:length(pabufTarget)
	    if i == 1 % assign onset asychrony to each of the target sequence values
	        PsychPortAudio('AddToSchedule', paTarget, pabufTarget(i));
	    else
	        PsychPortAudio('AddToSchedule', paTarget, cmdCode, IOIarray(i-1));
	        PsychPortAudio('AddToSchedule', paTarget, pabufTarget(i));
	        sequenceDur = sequenceDur + IOIarray(i-1);
	    end
	end
	PsychPortAudio('AddToSchedule', paTarget, cmdCode, periodicIOI);

	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------