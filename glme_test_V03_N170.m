clear all
load('locs.mat')
load('peaks.mat')
load('elec.mat')
%%
parts = cell(19*2*3*3,1);
condition = cell(19*2*3*3,1);
lateralization = cell(19*2*3*3,1);
presentation = cell(19*2*3*3,1);

Lat = {'left','left','left','left','left','left','left','left','left',...
    'right','right','right','right','right','right','right','right','right'};

present = {'First','Immediate', 'Delayed','First','Immediate', 'Delayed'};

for i = 1:19
    conds1 = {};
    for j = 1:3
        conds1{end+1} = 'famous';
    end
    conds2 = {};
    for j = 1:3
        conds2{end+1} = 'nonfamous';
    end
    conds3 = {};
    for j = 1:3
        conds3{end+1} = 'scrambled';
    end
    condition ((i-1)*2*3*3 + 1: i*3*3*2,1) = [conds1,conds2,conds3,conds1,conds2,conds3]';
    lateralization ((i-1)*3*2*3 + 1: i*3*3*2,1) = [Lat]';
    presentation ((i-1)*3*2*3 + 1: i*3*3*2,1) = [present,present,present]';

    part = {};
    for j = 1:3*3*2
        part{end+1} = num2str(i);
    end
    parts ((i-1)*2*3*3 + 1: i*3*3*2,1) = part';
end

T = table(parts,condition,lateralization, presentation);

%%
% Occipito-temporal
left = [1 29 30 40 41 51 52 53 54 55 62 63 67];
right = [3 38 39 49 50 57 58 59 60 61 65 66 69];
locs_left = locs(:,:,left,:);
locs_right = locs(:,:,right,:);

peaks_left = peaks(:,:,left,:);
peaks_right = peaks(:,:,right,:);

new_mtrx = zeros(19*2*3*3,2); 
% this is the order: N170 latency, N170 peaks
% columns: 1, 

% famous, first presentation = 5  
% famous, immediate repeat = 6
% famous, delayed repeat = 7 
% 
% nonfamous, first presentation = 13 
% nonfamous, immediate repeat = 14  
% nonfamous, delayed repeat = 15 
% 
% scrambled, first presentation = 17  
% scrambled, immediate repeat = 18  
% scrambled, delayed repeat = 19 

counter = 0;
for i = 1:19
    
    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,1,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,1,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,2,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,2,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,3,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,3,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,4,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,4,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,5,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,5,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,6,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,6,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,7,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,7,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,8,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,8,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_left(i,9,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_left(i,9,:,2),3)); %N170 peaks
    
    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,1,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,1,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,2,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,2,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,3,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,3,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,4,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,4,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,5,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,5,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,6,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,6,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,7,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,7,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,8,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,8,:,2),3)); %N170 peaks

    counter = counter + 1;
    new_mtrx (counter,1) = squeeze(mean(locs_right(i,9,:,2),3)); %N170 locations
    new_mtrx (counter,2) = squeeze(mean(peaks_right(i,9,:,2),3)); %N170 peaks
    
end
table = array2table(new_mtrx);
table.Properties.VariableNames(1:2) = {'locs_n170','peaks_n170'}; % table of design matix is created
data = [T table];
clearvars -except data T locs peaks
data.('locs_n170') = data.(5)./275;
data.('locs_n170') = data.(5).*1000;

glme_ex = fitglme(data,'locs_n170 ~ 1 + lateralization + condition + presentation + (1|parts)', ...
    'Distribution','Normal','Link','identity','FitMethod','Laplace');
disp(glme_ex)
% post hoc test to compare immediate vs delayed repet for latency N170
fixedEffects = glme_ex.Coefficients;

% Find indices for 'immediate repeat' and 'delayed repeat'
immediateIdx = find(strcmp(fixedEffects.Name, 'presentation_Immediate'));
delayedIdx = find(strcmp(fixedEffects.Name, 'presentation_Delayed'));

% Construct a contrast vector
contrast = zeros(1, height(fixedEffects));
contrast(immediateIdx) = -1;
contrast(delayedIdx) = 1;

% Perform hypothesis test for immediate vs. delayed
[pValue, Fstat, df] = coefTest(glme_ex, contrast);

% Display results
fprintf('Immediate vs Delayed Repeat:\n');
fprintf('p-value: %.5f\nF-statistic: %.3f\nDegrees of freedom: %.2f\n', pValue, Fstat, df);

% peaks_p110 ********************
glme_ex = fitglme(data,'peaks_n170 ~ 1 + lateralization + condition + presentation +  (1|parts)', ...
    'Distribution','Normal','Link','identity','FitMethod','Laplace');
disp(glme_ex)
% post hoc test to compare immediate vs delayed repet for peak N170
fixedEffects = glme_ex.Coefficients;

% Find indices for 'immediate repeat' and 'delayed repeat'
immediateIdx = find(strcmp(fixedEffects.Name, 'presentation_Immediate'));
delayedIdx = find(strcmp(fixedEffects.Name, 'presentation_Delayed'));

% Construct a contrast vector
contrast = zeros(1, height(fixedEffects));
contrast(immediateIdx) = -1;
contrast(delayedIdx) = 1;

% Perform hypothesis test for immediate vs. delayed
[pValue, Fstat, df] = coefTest(glme_ex, contrast);

% Display results
fprintf('Immediate vs Delayed Repeat:\n');
fprintf('p-value: %.5f\nF-statistic: %.3f\nDegrees of freedom: %.2f\n', pValue, Fstat, df);
