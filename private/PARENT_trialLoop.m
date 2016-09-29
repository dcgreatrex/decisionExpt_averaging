function PARENT_trialLoop(Pointers, Stimuli, Response, Prepair, threshold)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try 
    % instructions
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 7);
    ptb_onscreen_text(Pointers.w, m);
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 8);
    ptb_onscreen_text(Pointers.w, m);
    % run the noise centering script:
    noisecentering(Stimuli, Pointers);
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 9);
    ptb_onscreen_text(Pointers.w, m);

    % reseed random generator
    rng('default') 
    rng shuffle

    % show trial texture
    referent = trialTexture(Pointers, 500);
    Screen('Flip', Pointers.w, 0);
    WaitSecs = 0.500; 

    % run the experimental loop
    n_blocks = 8;
    for block = 1:n_blocks;
        
        if block > 1;
            if block == (n_blocks/2)+1;
                m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 10);
                ptb_onscreen_text(Pointers.w, m);
                % run the noise centering script:
                noisecentering(Stimuli, Pointers); 
                m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 9);
                ptb_onscreen_text(Pointers.w, m);
            else
                m = ['End of block ',num2str(block-1),'\n\n Take a short pause to gather energy and re-focus. \n\n DO NOT TAKE YOUR HEADPHONES OFF\n\n When you are ready, click the mouse to continue....'];
                ptb_onscreen_text(Pointers.w, m);
                m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 9);
                ptb_onscreen_text(Pointers.w, m);
            end
        end

        % load trial information    
        [index, level, isPeriodic] = textread(Pointers.input_file,'%f %f %f');
        ntrials     = length(index);            % get number of trials
        randomorder = randperm(ntrials);        % random permiatations
        index       = index(randomorder);       % randomise input list
        level       = level(randomorder);
        isPeriodic  = isPeriodic(randomorder);
        
        for i = 1:ntrials;

            % compute mean ILD for the PDF using the threshold estimate and stimulus level for the trial.
            mu = level(i) * threshold;
            disp(mu);

            % compute target array and return sequence information
            [Sequence] = PARENT_sequenceGen(Stimuli, level(i), mu, isPeriodic(i), index(i));

            % load audio sequence into audio buffers ready for playback
            [paTarget, Sequence, paTestTone] = PARENT_loadSound(Stimuli, Sequence);

            % play trial sequence, compute trial data
            ResponseData = PARENT_playTrial(Pointers, Sequence, Response, paTarget, paTestTone);

            % save trial data
            saveData(Pointers.subNo, Pointers.fpointer, Sequence, ResponseData, block);
            
            % pause before starting next trial
            WaitSecs = 0.600;
        end  
    end
    message = 'Thank you for your time \n\n click the mouse to exit...';
    ptb_onscreen_text(Pointers.w, message)

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------