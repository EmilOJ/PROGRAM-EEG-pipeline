function [] = grand_average(experiment, subjects, alignment)
   
   add_filedtrip_path();
   cfg = initialize_participant_cfg(experiment, 2);
    
   counter = 1;
   for subject = subjects
       
           avg_gram{counter} = compute_ERP_avg(experiment, subject, 'gram', alignment);
           avg_lex{counter} = compute_ERP_avg(experiment, subject, 'lex', alignment);
           counter = counter +1 ;
      
   end
   
   save([cfg.ERPdir 'gram_averages_' alignment '.mat'], 'avg_gram');
   save([cfg.ERPdir 'lex_averages_' alignment '.mat'], 'avg_lex');
   
 
   
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


   
   cfg.outputfile = [cfg.ERPdir 'gram_GA_' alignment '.mat'];
   avg_gram = ft_timelockgrandaverage(cfg, avg_gram{:});
   
   cfg.outputfile = [cfg.ERPdir 'lex_GA_' alignment ];
   avg_lex = ft_timelockgrandaverage(cfg, avg_lex{:});
   
end
