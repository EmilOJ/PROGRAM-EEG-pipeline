function [] = grand_average(experiment, subjects)
   
   add_filedtrip_path();
   cfg = initialize_participant_cfg(experiment, 2);
    
   counter = 1;
   for subject = subjects
       
           avg_gram{counter} = compute_ERP_avg(experiment, subject, 'gram');
           avg_lex{counter} = compute_ERP_avg(experiment, subject, 'lex');
           counter = counter +1 ;
      
   end
   
%    % ANOVA
%     disp('calculating anova table');
%     anovas = zeros(128, length(EEG(1).times));
%     tic
%     for channel_i = 1:128
%         for sample_i = 1:EEG.pnts
%             test_groups = [[squeeze(epochs_gram(channel_i, sample_i,:)); NaN;], ...
%                 squeeze(epochs_lex(channel_i, sample_i,:))];
%             [anovas(channel_i, sample_i), tbl, stats] = anova1(test_groups, {'grammatical', 'lexical'}, 'off');
%         end
%     end
%     toc
%     %
%     anovas(anovas > 0.05) = 1;


   
   cfg.outputfile = [cfg.ERPdir 'gram_GA.mat'];
   avg_gram = ft_timelockgrandaverage(cfg, avg_gram{:});
   
   cfg.outputfile = [cfg.ERPdir 'lex_GA.mat'];
   avg_lex = ft_timelockgrandaverage(cfg, avg_lex{:});
   
end
