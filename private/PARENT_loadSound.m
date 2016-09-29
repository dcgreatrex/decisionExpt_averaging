function [paTarget, Sequence, paTestTone] = PARENT_loadSound(Stimuli, Sequence)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    % open audio slave for each targetArray
    [paMASTER, paTarget, paTestTone] = openAudioslave(Sequence.targetArray, Stimuli.playbackFreq);

    % assign localised noise bursts to an audioslave
    [pabufTarget, pabufTestTone] = loadAudioslave(paTarget, Sequence.targetArray, Stimuli, paTestTone);
    
    % create audio schedule - requires array input
    duration = openAudioschedule(Stimuli.periodicIOI, paTarget, paTestTone, ...
                                        pabufTarget, pabufTestTone, Sequence.IOIarray);

    % update the Sequence structure with the duration value
    [Sequence(:).duration] = duration;

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------