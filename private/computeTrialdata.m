function [ResponseData] = computeTrialdata(ResponseData, Response, level)
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
    % key id pressed by subject
    pressedKey = KbName(ResponseData.keyCode);    

    % mark response NR if both response keys were pressed.
    doubleResponse = length(pressedKey) > 1 ;
    if  (doubleResponse)                  % assign category response id (single value integer)
        pressedKey = 'NR';
        answer = 0;
    else
        if pressedKey == KbName(Response.left)
            answer = -1;                  % left
        elseif pressedKey == KbName(Response.right) 
            answer = 1;                   % right
        else
            pressedKey = 'NR';
            answer = 0;                   % no response
        end
    end

    % flag correct and incorrect trials
    if abs(answer) > 0
        if level < 0 && answer == -1                  
            isCorrect = 1;
        elseif level > 0 && answer == 1          
            isCorrect = 1;
        elseif level == 0
            % if level is zero, randomly assign a pseudo answer with 60% of being correct.
            isCorrect = randsample([0,1],1,true,[0.40,0.60]); 
        else
            isCorrect = 0;
        end
    else
        isCorrect = 0;
    end

    disp(strcat('Pressed key: ', pressedKey));
    disp(strcat('Answer given: ', num2str(answer)));
    disp(strcat('IsCorrect ', num2str(isCorrect)));

    % append computed data to the responseData structure
    [ResponseData(:).pressedKey] = pressedKey;
    [ResponseData(:).answer] = answer;
    [ResponseData(:).isCorrect] = isCorrect;

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------