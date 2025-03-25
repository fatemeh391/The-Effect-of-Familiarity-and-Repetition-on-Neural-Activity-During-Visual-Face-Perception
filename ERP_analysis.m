clear all
close all
clc 

main_path = pwd;
data_path = 'Pre-processed\erp_famou_nonfamous_scr';
save_path = 'Pre-processed\ERP_analysis';

%%
load('elec.mat')
cd (main_path)
cd(data_path)

list_data = dir('erp*');

for conditions = 1:size(list_data,1)
    load (list_data(conditions).name)
end

n_conditions = size(list_data,1);
n_participants = size(erp_5,1);
size_data = 412;
n_chans = 70;

ERP = zeros(n_participants,n_conditions,n_chans,size_data);
for P = 1 : n_participants
    for ch = 1:n_chans
        ERP(P,1,ch,:) = squeeze(erp_5(P,ch,:));
        ERP(P,2,ch,:) = squeeze(erp_6(P,ch,:));
        ERP(P,3,ch,:) = squeeze(erp_7(P,ch,:));
        ERP(P,4,ch,:) = squeeze(erp_13(P,ch,:));
        ERP(P,5,ch,:) = squeeze(erp_14(P,ch,:));
        ERP(P,6,ch,:) = squeeze(erp_15(P,ch,:));
        ERP(P,7,ch,:) = squeeze(erp_17(P,ch,:));
        ERP(P,8,ch,:) = squeeze(erp_18(P,ch,:));
        ERP(P,9,ch,:) = squeeze(erp_19(P,ch,:));
    end
end

peaks = zeros(n_participants,n_conditions,n_chans,5);
locs = zeros(n_participants,n_conditions,n_chans,5);
for P = 1:n_participants
   
    for conds = 1:n_conditions
        for ch = 1:n_chans
            % P110, it is in column 1
            [pks,loc] = findpeaks(squeeze(ERP(P,conds,ch,1:42)));
            indices = find(loc<25);
            loc(indices) = [];
            pks (indices) = [];
            if ~isempty(pks)
                [M,I] = max(pks);
                peaks (P,conds,ch,1) = M;
                locs (P,conds,ch,1) = loc(I,1);
            elseif isempty(pks)
                peaks (P,conds,ch,1) = nan;
                locs (P,conds,ch,1) = nan;
            end
            
            % N170, it is in column 2
            [pks,loc] = findpeaks(squeeze(-ERP(P,conds,ch,1:62)));
            indices = find(loc<40);
            loc(indices) = [];
            pks (indices) = [];
            if ~isempty(pks)
                [M,I] = max(pks);
                peaks (P,conds,ch,2) = -M;
                locs (P,conds,ch,2) = loc(I,1);
            elseif isempty(pks)
                peaks (P,conds,ch,2) = nan;
                locs (P,conds,ch,2) = nan;
            end

            % N250, it is in column 3
            [pks,loc] = findpeaks(squeeze(-ERP(P,conds,ch,1:95)));
            indices = find(loc<65);
            loc(indices) = [];
            pks (indices) = [];
            if ~isempty(pks)
                [M,I] = max(pks);
                peaks (P,conds,ch,3) = -M;
                locs (P,conds,ch,3) = loc(I,1);
            elseif isempty(pks)
                peaks (P,conds,ch,3) = nan;
                locs (P,conds,ch,3) = nan;
            end


        end
    end
end

cd (main_path)
cd(save_path)

save('peaks.mat','peaks')
save('locs.mat','locs')
save('ERP.mat','ERP')


%% Plot


P = 6;
ch = 50;
conds = 1;

figure()
plot(squeeze(ERP(P,conds,ch,:)))
esm = elec(ch);
title (esm(1,1))
disp(['p110: ',num2str(locs(P,conds,ch,1))])
disp(['n170: ',num2str(locs(P,conds,ch,2))])
disp(['n250: ',num2str(locs(P,conds,ch,3))])
