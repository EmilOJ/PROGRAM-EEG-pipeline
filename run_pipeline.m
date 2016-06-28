clc; close all; clear all;



% visual_inspect_data('verber',4, 'raw', 1, 1, 1:10);
%visual_inspect_data('verber',4, 'ICA_pruned_filtered', 0, 1, 1:10);

%pipeline_ICA('verber', 4);
%check_ICA_components('verber',4);
% 
%   for ii = [2,3,4,5,7,8,9,10, 12,14,15]
%       pipeline_afterICA('verber', ii);
%     reref_and_filter('verber', 2);
%  end


%  subjects = [4:4,5,7:20,23,25:30]
   for i = subjects
%     try
       
       epoch_data('det',i);
%     catch
%         disp(['fail: ' num2str(i)]);
%     end
%        reject_artifacts('det', 5);
       repair_bad_channels('det',i);
   end

% subjects = [2:3,5,7:20,23,25:30]
grand_average('det', subjects, 'response');
grand_average('det', subjects, 'stim');
GA_inspect('B12', 'stim');
  
statistics_ERP(subjects, 'stim', 'new', 0.05);
statistics_ERP(subjects, 'response', 'new', 0.05);

% t_write_data([cfg.subjectdir 'part3_ICApruned_filtered.edf'], data_org.trial{1}, 'header', ft_fetch_header(data_org),'data_format','edf');