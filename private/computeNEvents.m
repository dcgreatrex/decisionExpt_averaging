function ResponseData = computeNEvents(ResponseData, Sequence)
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
    nEvents = length(Sequence.IOIarray) + 1;
    eventTotal = 0;
    for (i = 1:length(Sequence.IOIarray))
        event = Sequence.IOIarray(i);
        eventTotal = eventTotal + event;
        if eventTotal >= ResponseData.RT;
            nEvents = i;
            break
        end
    end
    [ResponseData(:).nEvents] = nEvents;
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------