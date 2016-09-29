function ResponseData = PARENT_playTrial(Pointers, Sequence, Response, paTarget, paTestTone)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    while KbCheck; end    % flush keyboard events
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % play sequence and get trial data
    [keyCode, ResponseData] = playStimulus(Pointers, paTarget, Sequence.duration, ...
                                            paTestTone, Response);    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute trial data
    ResponseData = computeTrialdata(ResponseData, Response, Sequence.level);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % present feedback
    feedback(ResponseData, Sequence, Pointers);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute number of observed noise bursts.
    ResponseData = computeNEvents(ResponseData, Sequence);
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------