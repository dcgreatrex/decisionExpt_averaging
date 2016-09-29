function [muList, isCorrectList, firstError, reversal, outBounds, thresholdList] = staircaseCompute(Stimuli, Sequence, ResponseData, muList, isCorrectList, firstError, reversal, outBounds, thresholdList)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try  
    % only process if the current trial has an aperiodic rhythm
    switch Sequence.isPeriodic
        case 1
            i = 0;
        otherwise
            i = 1;
    end
    disp(strcat('IsAperiodic', num2str(i)));

    if i
        disp(strcat('Starting Staircase Procedure - aperiodic trial:', num2str(i)));
        
        muLevel = abs(Sequence.mu);
        isCorrectList(length(isCorrectList) + 1) = ResponseData.isCorrect;    % update isCorrect list

        % compute reversals - 3 up 1 down staircase
        if length(isCorrectList) >= 3
            a = [isCorrectList(end - 1), isCorrectList(end)];       
            c1 = [1, 0];
            c2 = [0, 1];
            if a == c1
                reversal = reversal + 1;
                thresholdList(end + 1) = muLevel;
            elseif a == c2
                reversal = reversal + 1;
                thresholdList(end + 1) = muLevel;
            end
        end

        % compute staircase
        if reversal
            disp('New reversal');
            newLevel = staircase3u1d(muLevel, isCorrectList, Stimuli.stdStepSize);
        else
            disp('No reversals yet');
            newLevel = staircase3u1d(muLevel, isCorrectList, Stimuli.beginStepSize);
        end
        disp(strcat('The new mean will be: ', num2str(newLevel)));

        % stop mu being assigned that is greater than the starting level
        if newLevel > Stimuli.startLevel
            newLevel = Stimuli.startLevel;
            outBounds = outBounds + 1;
            disp('The new level is greater than starting level - incrementing outBounds variable')
        end

        % append new mean to list of means
        muList(end + 1) = newLevel; 

    else
        muList = muList;
        isCorrectList = isCorrectList;
        firstError = firstError;
        reversal = reversal;
        outBounds = outBounds;
    end

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------