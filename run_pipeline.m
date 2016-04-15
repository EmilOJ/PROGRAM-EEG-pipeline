clear all; 
% TODO: Load bad channels

% pipeline_ICA('det', 3);
% check_ICA_components('det', 30);
% visual_inspect_data('det',2);
% pipeline_afterICA('det', ii);
% reref_and_filter('det',2);
% parfor i = 7:30
%     try
%         epoch_data('det',i);    
%     catch
%         disp('fail');
%     end
% end


% reject_artifacts('det', 2);
% 
% subjects = [2,3,7,8,10,12,13,14,16:23,25,28,29,30];
% 
% 
% grand_average('det', subjects);
GA_inspect();

% 
% 
