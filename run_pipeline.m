clc; close all;

% pipeline_ICA('det', 3);
% check_ICA_components('det', 14);
% visual_inspect_data('det',2, 'raw', 1, 1);
% pipeline_afterICA('det', ii);
% reref_and_filter('det',2);
% 
% 
%   subjects = [22:23,25,29,30]; %18 subjects
%   for i = subjects
% %     try
% %         epoch_data('det',i);    
% %     catch
% %         disp('fail');
% %     end
%          %reject_artifacts('det', i);
%   end


% 
 subjects = [2,3,5,7,8,10,12:14,17,19,20,23,25,29,30]; %18 subjects
   for i = subjects
%     try
         epoch_data('det',i, 'response');    
%     catch
%         disp('fail');
%     end
%          reject_artifacts('det', i);
%       repair_bad_channels('det',i);
   end
% 
grand_average('det', subjects);
GA_inspect('C8');

% 
% % 