function PARENT_practiceLoop(Pointers, Stimuli, Response, Prepair)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try 
    % Welcome and practice instructions
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 1);
    ptb_onscreen_text(Pointers.w, m);
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 2);
    ptb_onscreen_text(Pointers.w, m);
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 3);
    ptb_onscreen_text(Pointers.w, m);
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 4);
    ptb_onscreen_text(Pointers.w, m);

    % reseed random generator
    rng('default') 
    rng shuffle

    % show trial texture
    referent = trialTexture(Pointers, 500);
    Screen('Flip', Pointers.w, 0);
    WaitSecs = 0.500; 
        
    % load trial information    
    [index, level, isPeriodic] = textread(Pointers.practiceinput_file,'%f %f %f');
    ntrials     = length(index);            % get number of trials
    
    % pseudorandomly order trials - avoid small level values in the first 2 practice trials.
    exclude = [-1.5, -1, 0, 1, 1.5];
    while true
        randomorder = randperm(ntrials);        % random permiatations
        index       = index(randomorder);       % randomise input list
        level       = level(randomorder);
        isPeriodic  = isPeriodic(randomorder);
        if(sum(ismember(level(1:3),exclude)) > 0); 
            continue;
        else
            break;
        end
    end

    for i = 1:ntrials;

        % assign mean ILD for the PDF
        mu = level(i)

        % compute target array and return sequence information
        [Sequence] = PARENT_sequenceGenPractice(Stimuli, level(i), mu, isPeriodic(i), index(i));

        % load audio sequence into audio buffers ready for playback
        [paTarget, Sequence, paTestTone] = PARENT_loadSound(Stimuli, Sequence);

        % play trial sequence, compute trial data
        ResponseData = PARENT_playTrial(Pointers, Sequence, Response, paTarget, paTestTone);

        % pause before starting next trial
        WaitSecs = 0.600;
    end  

    message = 'End of the practice session. Do you have any questions? \n\n click the mouse to continue...';
    ptb_onscreen_text(Pointers.w, message)

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------