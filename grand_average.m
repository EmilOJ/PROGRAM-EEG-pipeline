function [] = grand_average(experiment, subjects)
   
   add_filedtrip_path();
   cfg = initialize_participant_cfg(experiment, 2);
    
   counter = 1;
   for subject = subjects
       try
           avg_gram{counter} = compute_ERP_avg(experiment, subject, 'gram');
           avg_lex{counter} = compute_ERP_avg(experiment, subject, 'lex');
           counter = counter +1 ;
       catch
           disp('fail');
       end
   end
   
   cfg.outputfile = [cfg.ERPdir 'gram_GA.mat'];
   avg_gram = ft_timelockgrandaverage(cfg, avg_gram{:});
   
   cfg.outputfile = [cfg.ERPdir 'lex_GA.mat'];
   avg_lex = ft_timelockgrandaverage(cfg, avg_lex{:});
   
end
