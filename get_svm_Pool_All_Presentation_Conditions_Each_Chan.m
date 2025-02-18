clear all
close all
clc

n_chans = 70;
num_windows = 275;

main_path = 'C:\Users\Study_1';
data_path = 'Pre-processed';
save_path = 'SVM\Pool_All_Presentation_Conditions_Each_Chan';
path_libsvm = 'C:\Users\Scripts_Results\libsvm-3.22\matlab';
%%
cd (data_path)
list_dir = dir('P*');

accuracy = zeros(size(list_dir,1),3,n_chans,num_windows);
for P = 1:size(list_dir,1)
    disp(['participant number: ', int2str(P)])

    cd (main_path)
    cd (data_path)
    cd (list_dir(P,1).name)
    list_data = dir('*base.mat');

    for i = 1:size(list_data,1)
        load (list_data(i).name)
    end
    
    cd (path_libsvm)

    famous = [x_5;x_6;x_7]; 
    nonfamous = [x_13;x_14;x_15];
    scr = [x_17;x_18;x_19];

    DATA = [famous;nonfamous];
    label = [ones(size(famous,1),1);(-1)*ones(size(nonfamous,1),1)];
    for ch = 1:n_chans
        for thisTime = 1:num_windows
            tmp = squeeze(abs(DATA(:,ch,thisTime))); 
            colmin = min(tmp);
            colmax = max(tmp);
            thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
            accuracy(P,1,ch,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
        end
    end

    DATA = [famous;scr];
    label = [ones(size(famous,1),1);(-1)*ones(size(scr,1),1)];

    for ch = 1:n_chans
        for thisTime = 1:num_windows
            tmp = squeeze(abs(DATA(:,ch,thisTime))); 
            colmin = min(tmp);
            colmax = max(tmp);
            thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
            accuracy(P,2,ch,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
        end
    end

    DATA = [nonfamous;scr];
    label = [ones(size(nonfamous,1),1);(-1)*ones(size(scr,1),1)];

    for ch = 1:n_chans
        for thisTime = 1:num_windows
            tmp = squeeze(abs(DATA(:,ch,thisTime))); 
            colmin = min(tmp);
            colmax = max(tmp);
            thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
            accuracy(P,3,ch,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
        end
    end

end

cd (main_path)
cd (save_path)
save('accuracy.mat','accuracy')

%%
cd (main_path)
cd (save_path)
load('accuracy.mat')
acc = squeeze(mean(accuracy, 1));
load('elec.mat');

%%
% t-test
size(accuracy)
pvalue = zeros(3,n_chans,num_windows);
for time = 1:num_windows
    for channel = 1: n_chans
        for conditions = 1:3
            [h,p] = ttest(squeeze(accuracy(:, conditions, channel, time)),50);
            pvalue(conditions, channel, time) = p;
        end
    end
end


idx = zeros(3,n_chans,num_windows);
for time = 1:num_windows
    for channel = 1: n_chans
        for conditions = 1:3
            if pvalue(conditions, channel, time) <= 0.05
                idx(conditions, channel, time) = 1;
            elseif pvalue(conditions, channel, time) > 0.05
                idx(conditions, channel, time) = NaN;
            end
        end
    end
end