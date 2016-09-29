function threshold  = PARENT_staircaseTrialLoop(Pointers, Stimuli, Response, datafilepointer)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try  
    muList = [Stimuli.startLevel];
    isCorrectList = [];
    firstError = false;
    reversal = 0;    
    outBounds = 0;
    index = 1;
    thresholdList = [];
    trial_rhythms = [];
    override_no = 3;
    while true
        % randomly assign rhythmic flag: 1 = Periodic, 0 = Aperiodic
        if randi([0,1]) == 1
            isPeriodic = 1;
        else
            isPeriodic = 0;
        end

        disp(trial_rhythms);
        
        % override selection if there is more that 2 of the same rhythms in a row
        if length(trial_rhythms) >= override_no
            if trial_rhythms(end-override_no+1:end) == [1,1,1]
                isPeriodic = 0;
            elseif trial_rhythms(end-override_no+1:end) == [0,0,0]
                isPeriodic = 1;
            end
        end

        % randomly assign mean direction: 1 = right(positive), 0 = left(negative)
        if randi([0,1]) == 1
            mu = muList(end);
            direction = 1;
        else
            mu = muList(end) * -1;
            direction = -1;
        end

        % assign level depending on the sign of mu
        if mu < 0
            level = -1;
        elseif mu > 0
            level = 1;
        else
            level = 0;
        end 

        % compute target array and return sequence information
        [Sequence] = PARENT_sequenceGen(Stimuli, level, mu, isPeriodic, index);

        % load audio sequence into audio buffers ready for playback
        [paTarget, Sequence, paTestTone] = PARENT_loadSound(Stimuli, Sequence);

        % play trial sequence, compute trial data
        ResponseData = PARENT_playTrial(Pointers, Sequence, Response, paTarget, paTestTone);

        % compute staircase
        [muList, isCorrectList, firstError, ...
        reversal, outBounds, thresholdList] = staircaseCompute(Stimuli, Sequence, ...
                                                                ResponseData, muList, ...
                                                                isCorrectList, firstError, ...
                                                                reversal, outBounds, ...
                                                                thresholdList);

        % save trial data
        staircaseSaveData(Pointers.subNo, datafilepointer, Sequence, ResponseData, reversal)

        % assess reversals
        if reversal >= Stimuli.noReversals
            break;
        end

        % assess out of bounds
        if outBounds > 2;
            disp('%%%% MORE PRACTICE IS REQUIRED ON THE TASK... ABORTING THE SESSION %%%%');
            break
        end

        % update trial index and description variables
        WaitSecs(0.600);
        index = index + 1;
        trial_rhythms(end + 1) = isPeriodic;
    end
    threshold = mean(thresholdList(5:10));
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------