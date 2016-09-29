function [keyCode, ResponseData] = playStimulus(Pointers, paTarget, sequenceDur, paTestTone, Response)
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
	% run checks
	[~, ~, keyCode] = KbCheck(-1);% Initialize KbCheck:
	WaitSecs(0.050);
	diameter = 500;
    startInterval = 0.333.* rand(1,1) + 1.400;   % any number between 1750 - 2000 ms
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % start trial
    referent = trialTexture(Pointers, diameter);        % make onscreen trial texture
    drawAngle(Pointers.w, -90, diameter, referent(1), referent(2), [255 255 255], 0)
	[~, startTrial] = Screen('Flip', Pointers.w, 0); 				             
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % probe tone
	PsychPortAudio('Start', paTestTone, [], 0);  % start probe tone
	PsychPortAudio('Stop', paTestTone, 3);	     % stop probe tone
	referent = trialTexture(Pointers, diameter);   % make onscreen trial texture
	when = startTrial + 0.200;
	[~, startTrial] = Screen('Flip', Pointers.w, when - Pointers.slack); 	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Refresh response keys
    l_key = Response.left; r_key = Response.right;
    if keyCode(l_key)==1 || keyCode(r_key)==1
        keyCode(l_key)=0; keyCode(r_key)=0;      % set to zero (no response) if both response keys are pressed.
    end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% noise sequence
    trialTexture(Pointers, diameter);        % make onscreen trial texture
    when = startTrial + startInterval;
	[~, startSequence] = Screen('Flip', Pointers.w, when - Pointers.slack);  
	PsychPortAudio('Start', paTarget, 1, when - Pointers.slack); % start sequence
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% record response times
	timeOut = startSequence + Response.timeoutDur;
    while GetSecs < timeOut
	    if keyCode(l_key)==1 || keyCode(r_key)==1
	    	% stop playback
            PsychPortAudio('Stop', paTarget, 0);  
            % save timing information
	        RT_raw = endSequence - startSequence;
	        totalDuration = endSequence - startTrial; 
	        break;
	    end
	    [~, endSequence, keyCode]=KbCheck(-1); 
	    WaitSecs(0.0005);   
    end
    % assign default response time value (0ms) if the response is void.
	if (keyCode(l_key)==0 && keyCode(r_key)==0)
		endSequence = timeOut;
		% stop playback
	    PsychPortAudio('Stop', paTarget, 0);  
	    % save timing information
	    RT_raw = startSequence;
	    totalDuration = endSequence - startTrial; 
	end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
	% store response data
	RT = round(RT_raw * 1000) / 1000;     % rounded response time

    % save response data to structure
    f1 = 'startResponse'; v1 = startSequence;
	f2 = 'endResponse';   v2 = endSequence;
	f3 = 'keyCode';       v3 = keyCode;
	f4 = 'RT';			  v4 = RT;
    f5 = 'startInterval'; v5 = startInterval;
    f6 = 'totalDuration'; v6 = totalDuration; 
	ResponseData = struct(f1, v1, f2, v2, f3, v3, f4, v4, ...
		                  f5, v5, f6, v6);
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------