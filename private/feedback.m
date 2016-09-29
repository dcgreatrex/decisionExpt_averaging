function feedback(ResponseData, Sequence, Pointers)
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
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% make onscreen trial texture
	if ResponseData.isCorrect     
        referent = trialTexture(Pointers, 500); 
        drawAngle(Pointers.w, -90, 500, referent(1), referent(2), [0 255 0], 0);
        [~, startFeedback] = Screen('Flip', Pointers.w, 0);  
    else
        referent = trialTexture(Pointers, 500); 
        drawAngle(Pointers.w, -90, 500, referent(1), referent(2), [255 0 0], 0);
        [~, startFeedback] = Screen('Flip', Pointers.w, 0);  
    end
    
    referent = trialTexture(Pointers, 500); 
    when = startFeedback + 0.200;
    [~, startFeedback] = Screen('Flip', Pointers.w, when - Pointers.slack);  
	%---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------