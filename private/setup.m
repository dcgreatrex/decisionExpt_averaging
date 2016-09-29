function [Pointers, Response] = setup(subNo, prepair)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
	datafilepointer = ml_open_files(subNo, prepair.outFolder, ...     % open output files:
	 								prepair.nOutfile, prepair.exptName, ...
	  								prepair.isLogfile); 
	
	ml_writetofile(datafilepointer(1), prepair.tableVariable);        % print headings to outfiles

    input_file  = strcat(prepair.inFolder, 'block_info.txt'); 
    practiceinput_file  = strcat(prepair.inFolder, 'practice_info.txt');   

	% setup ptb:   
	ptb_screen_setup(prepair.skipTest); 				              % prepair MATLAB for ptb
	[~, w, wRect, slack] = ptb_open_screen(prepair.textSize);	      % open a new experimental window						 	
	[screenXpixels, screenYpixels] = Screen('WindowSize', w); 	      % max x and y screen pixels
	[xs,ys] = RectCenter(wRect); 					                  % coordinates for screen mid point	
	Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); % Enable Alpha blending
    
    % Pointer variables associated with ptb window and open files
    f1 = 'subNo'; v1 = subNo;
    f2 = 'w';     v2 = w;									  
    f3 = 'wRect'; v3 = wRect;
    f4 = 'slack'; v4 = slack;
    f5 = 'screenCenter'; v5 = [screenXpixels, screenYpixels];
    f6 = 'fpointer'; v6 = datafilepointer;
    f7 = 'coordinates'; v7 = [xs, ys];
    f8 = 'input_file';  v8 = input_file;
    f9 = 'practiceinput_file';  v9 = practiceinput_file;
    Pointers = struct(f1, v1, f2, v2, f3, v3, f4, v4, ...
    	              f5, v5, f6, v6, f7, v7, f8, v8, ...
    	              f9, v9);

    % counterbalance response variables
    if mod(subNo,2) == 0
    %number is even
	    f1 = 'left';	v1 = KbName( prepair.keyArray{1} );    % left response key - "c" 
	    f2 = 'right';	v2 = KbName( prepair.keyArray{2} );    % right response key - "m"
    else
    %number is odd
	    f1 = 'left';	v1 = KbName( prepair.keyArray{2} );    % left response key - "m"
	    f2 = 'right';	v2 = KbName( prepair.keyArray{1} );    % right response key - "c"
    end 
	f3 = 'pause';		v3 = KbName( prepair.keyArray{3} );    % pause response key
	f4 = 'timeoutDur';	v4 = prepair.timeoutDur;		       % time out duration
	Response = struct(f1, v1, f2, v2, f3, v3, f4, v4);
	
	GetSecs; 											       % initiate timing functions
	WaitSecs(1);
	
    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------