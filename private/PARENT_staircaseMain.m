function threshold = PARENT_staircaseMain(subNo, Pointers, Response, Prepair, Stimuli)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    %---------------------
    % staircasing instructions:
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 5);
    ptb_onscreen_text(Pointers.w, m);

    % run the noise centering script:
    noisecentering(Stimuli, Pointers); 
    m = ptb_get_text(Prepair.textFolder, Prepair.textFile, 6);
    ptb_onscreen_text(Pointers.w, m);

    % show trial texture
    referent = trialTexture(Pointers, 500); 
    Screen('Flip', Pointers.w, 0);
    WaitSecs = 0.500; 

    % folder and ptb setup: 
    datafilepointer = staircaseSetup(subNo, Prepair);   
    
    % run stiarcase procedure
    threshold = PARENT_staircaseTrialLoop(Pointers, Stimuli, Response, ...    
                                    datafilepointer);
    disp(threshold);

    % cap threshold
    threshold = threshold - 0.3;
    disp(threshold);

    % edit threshold if selected value is too small or large
    if threshold < 1
        threshold = 1;
    elseif threshold > 2.3
        threshold = 2.3;
    end

    %m = strcat('Your threshold is: ', num2str(threshold));
    %ptb_onscreen_text(Pointers.w, m);                  
    %---------------------
catch ME
    disp( getReport(ME,'extended') );
    cleanup();                                                         
end
%------------------------------------------