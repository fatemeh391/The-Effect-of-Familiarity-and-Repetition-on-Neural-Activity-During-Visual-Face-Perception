clear all
close all
clc

n_chans = 70;
num_windows = 275;

main_path = 'C:\Users\Study_1';
data_path = 'Pre-processed';
save_path = 'SVM\Separate_Presentation_Conditions';
path_libsvm = 'C:\Users\Scripts_Results\libsvm-3.22\matlab';
%%
cd (data_path)
list_dir = dir('P*');


accuracy_first = zeros(size(list_dir,1),3,num_windows);
accuracy_immediate = zeros(size(list_dir,1),3,num_windows);
accuracy_delayed = zeros(size(list_dir,1),3,num_windows);
for P = 1:size(list_dir,1)

    cd (main_path)
    cd (data_path)
    cd (list_dir(P,1).name)
    list_data = dir('*base.mat');

    for i = 1:size(list_data,1)
        load (list_data(i).name)
    end
    
    cd (path_libsvm)

% ------------------ First presentation ---------------------------------
% ------------------ First presentation ---------------------------------
    famous = x_5; 
    nonfamous = x_13;
    scr = x_17;

    DATA = [famous;nonfamous];
    label = [ones(size(famous,1),1);(-1)*ones(size(nonfamous,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_first(P,1,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end

    DATA = [famous;scr];
    label = [ones(size(famous,1),1);(-1)*ones(size(scr,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_first(P,2,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end

    DATA = [nonfamous;scr];
    label = [ones(size(nonfamous,1),1);(-1)*ones(size(scr,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_first(P,3,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end
    clear famous nonfamous scr
% ------------------ Immediate Repeat ---------------------------------
    famous = x_6; 
    nonfamous = x_14;
    scr = x_18;

    DATA = [famous;nonfamous];
    label = [ones(size(famous,1),1);(-1)*ones(size(nonfamous,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_immediate(P,1,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end

    DATA = [famous;scr];
    label = [ones(size(famous,1),1);(-1)*ones(size(scr,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_immediate(P,2,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end

    DATA = [nonfamous;scr];
    label = [ones(size(nonfamous,1),1);(-1)*ones(size(scr,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_immediate(P,3,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end
    clear famous nonfamous scr
% ------------------ Delayed Repeat   ---------------------------------
    famous = x_7; 
    nonfamous = x_15;
    scr = x_19;

    DATA = [famous;nonfamous];
    label = [ones(size(famous,1),1);(-1)*ones(size(nonfamous,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_delayed(P,1,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end

    DATA = [famous;scr];
    label = [ones(size(famous,1),1);(-1)*ones(size(scr,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_delayed(P,2,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end

    DATA = [nonfamous;scr];
    label = [ones(size(nonfamous,1),1);(-1)*ones(size(scr,1),1)];

    for thisTime = 1:num_windows
        tmp = squeeze(abs(DATA(:,:,thisTime))); 
        colmin = min(tmp);
        colmax = max(tmp);
        thisDat = double(rescale(tmp,'InputMin',colmin,'InputMax',colmax));
        accuracy_delayed(P,3,thisTime) = libsvmtrain(label,thisDat, '-s 0 -t 0 -c 1 -v 10 -q');
    end
    clear famous nonfamous scr
end

cd (main_path)
cd (save_path)
save('accuracy_first.mat','accuracy_first')
save('accuracy_immediate.mat','accuracy_immediate')
save('accuracy_delayed.mat','accuracy_delayed')