clc; close all; clear all;
experiment = 'verber';
ICA = 0;
% for ii = [8,13,16,9,25,24]
for ii = 8
%     try
%% 1. ICA
% pipeline_ICA(experiment, 4);


%% 2. Identify ICA componenets
% check_ICA_components(experiment,4);

%% 3. Remove ICA eye blink comps. and resample to 256 Hz
% failed_3 = [];
% %   for ii = [3:30]
%     try
%         pipeline_afterICA(experiment, ii);
%         disp(['***!!!*** Part number:' num2str(ii)]);
%     catch
%         failed_3 = [failed_3 ii];
%     end
%   end
  
%% 4. Filter  
% failed_4 = [];
% % for ii = [2:30]
%     try
%         my_filter(experiment, ii, ICA);
%         disp(['***!!!*** Part number:' num2str(ii)]);
%     catch
%         failed_4 = [failed_4 ii];
%     end
% % end
% %   
% 
% 
%% 5. Epoch
% failed_5 = [];
% % for ii = [25]
%     
% %     try
%         epoch_data(experiment, ii, ICA);
% %         disp(['***!!!*** Part number:' num2str(ii)]);
% 
% %     catch
% %         disp(['something went wrong at part' num2str(ii)]);
% %         failed_5 = [failed_5 ii];
% %     end
% 

% end
%% 6. Reject artifacts / Interpolate
reject_artifacts_manual(experiment, ii, ICA);
% repair_bad_channels(experiment,ii);
% 

%% 7. Re-reference
% reref(experiment, ii);

end

%% 8. Grand average
% subjects = [2,5,7:15];
% subjects = [14,13,5,16,15,17,21,12,8,25]% slowest
% subjects = [23,25]

% grand_average(experiment, subjects, 'response');
% grand_average(experiment, subjects, 'stim');

% GA_inspect(experiment, {'C21', 'A1', 'A23', 'D31'}, 'stim');
% GA_inspect(experiment, {'C21', 'A1', 'A23', 'D31'}, 'stim');

%% 9. Statistics
% statistics_ERP(experiment, subjects, 'stim', 'new', 0.05);
% statistics_ERP(experiment, subjects, 'response', 'new', 0.05);


%% Misc.
% t_write_data([cfg.subjectdir 'part3_ICApruned_filtered.edf'], data_org.trial{1}, 'header', ft_fetch_header(data_org),'data_format','edf');
%visual_inspect_data(experiment,4, 'raw', 1, 1, 1:10);
% visual_inspect_data(experiment,9, 'ICA_pruned_filtered', 0, 1, 1:10);
