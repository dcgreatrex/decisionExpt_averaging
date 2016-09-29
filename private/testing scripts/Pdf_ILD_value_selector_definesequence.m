sd = 3.3;
mu = -0.5;
nTarget = 20;

rng('default') 
rng shuffle

% generate target array using a probabiltiy density function
pd = makedist('Normal', mu, sd);

arrayMaster = {};
for j = 1:30
    % select X random numbers from probability density function
    while true
        for i = 1:nTarget; 
            targetArray(i) = random(pd); 
        end
        lMu = mean(targetArray) < (mu + 0.02); 
        uMu = mean(targetArray) > (mu - 0.02);
        if (lMu && uMu)
            lSd = std(targetArray) < (sd * 1.02); 
            uSd = std(targetArray) > (sd * 0.98);
            if (lSd && uSd)
                if mu > 0
                    if mean(targetArray) > 0
                        disp('mu > 0 and TA > 0');
                        break
                    end
                elseif mu < 0
                    if mean(targetArray) < 0
                        disp('mu < 0 and TA < 0');
                        break
                    end
                elseif mu == 0
                    disp('mu == 0');
                    break
                else
                    continue
                end
            else
                continue
            end
        else
            continue
        end
    end
    arrayMaster{j} = targetArray;
end

figure
for k = 1:length(arrayMaster) 
    subplot(6,5,k)
    hist(arrayMaster{k})
    title(strcat('Run: ', num2str(k)))
    line([mean(arrayMaster{k}) mean(arrayMaster{k})], [0 10], 'color', 'r');
    text(-15,8,strcat('MU = ', num2str(mean(arrayMaster{k}))));
    text(-15,6,strcat('SD = ', num2str(std(arrayMaster{k}))));
    axis([-15 15 0 inf]); 
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0
1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');

text(0.5, 1,'\bf Simulations testing the array value generator to be used in Expt. 4a.','HorizontalAlignment','center','VerticalAlignment', 'top')