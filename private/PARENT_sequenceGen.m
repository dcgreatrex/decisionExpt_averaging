function [Sequence] = PARENT_sequenceGen(Stimuli, level, mu, isPeriodic, index)
%------------------------------------------
% SCRIPT HEADER
%------------------------------------------
try
    rng('default') 
    rng shuffle

    % generate target array using a probabiltiy density function
    pd = makedist('Normal', mu, Stimuli.pdf_Sd);

    % select X random numbers from probability density function
    while true
        for i = 1:Stimuli.nTarget; 
            targetArray(i) = random(pd); 
        end
        lMu = mean(targetArray) < (mu + 0.1); 
        uMu = mean(targetArray) > (mu - 0.1);
        if (lMu && uMu)
            lSd = std(targetArray) < (Stimuli.pdf_Sd + 0.1); 
            uSd = std(targetArray) > (Stimuli.pdf_Sd - 0.1);
            if (lSd && uSd)
                if ( (targetArray(1) > (mu + Stimuli.pdf_Sd)) | (targetArray(1) < (mu - Stimuli.pdf_Sd)) );
                    continue
                else
                    if mu > 0
                        if mean(targetArray) > 0
                            break
                        end
                    elseif mu < 0
                        if mean(targetArray) < 0
                            break
                        end
                    elseif mu == 0
                        break
                    else
                        continue
                    end
                end
            else
                continue
            end
        else
            continue
        end
    end

    % calculate the IOI array
    nIOI = length(targetArray) - 1;
    IOIarray = {};
    IOIarray = computeIOIArray(isPeriodic, nIOI, Stimuli.periodicIOI);

    % build structure
    f1 = 'targetArray';    v1 = {targetArray};
    f2 = 'level';          v2 = level;
    f3 = 'mu';             v3 = mu;
    f4 = 'isPeriodic';     v4 = isPeriodic;
    f5 = 'IOIarray';       v5 = {IOIarray};
    f6 = 'index';          v6 = index;

    Sequence = struct(f1, v1, f2, v2, f3, v3, f4, v4, ...
                      f5, v5, f6, v6);

    %---------------------
catch ME
    rethrow(ME);
end
%------------------------------------------