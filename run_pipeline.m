clear all; close all;
% TODO: Load bad channels

% pipeline_ICA('det', 10);
% check_ICA_components('verber', 30);
% visual_inspect_data('verber',30);

% go = [7 8 9 10 11 12 13 14 16 17 18 19 20 21 22 23 25 26 28 29 30];
% fail = [];
% for i = go
%     i
%     try
%         pipeline_afterICA('det', i);
%     catch
%        disp([i ' failed']); 
%        fail = [fail i];
%     end
% 
% end

pipeline_afterICA('det', 8);