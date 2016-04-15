function [] = GA_inspect()
   add_filedtrip_path();
   cfg = initialize_participant_cfg('det', 2);
   
   gram = load([cfg.ERPdir 'gram_GA.mat']);
   lex = load([cfg.ERPdir 'lex_GA.mat']);
   
    %% Plotting
   
   cfg.showlabels  = 'yes';
   cfg.layout      = 'biosemi128.lay';
   cfg.channel = 'B1';
   %figure; ft_multiplotER(cfg, gram.grandavg, lex.grandavg);
   figure; ft_singleplotER(cfg, gram.grandavg, lex.grandavg);
end