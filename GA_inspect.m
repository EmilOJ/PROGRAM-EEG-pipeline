function [] = GA_inspect(channel, alignment)
   add_filedtrip_path();
   cfg = initialize_participant_cfg('det', 2);
   
   gram = load([cfg.ERPdir 'gram_GA_' alignment '.mat']);
   lex = load([cfg.ERPdir 'lex_GA_' alignment '.mat']);
   
   
  
    %% Plotting
   figure;
   for j = 1:2
       if j == 1
           plot_title = 'Grammatical condition';
           y = gram.grandavg.avg;
           time = gram.grandavg.time;
       else
           plot_title = 'Lexical condition';
           y = lex.grandavg.avg;
           time = lex.grandavg.time;
       end
       subplot(2,1,j);
       
       for i=1:size(y,1)
           plot(time, y(i,:));%-mean(y(i,:),2));
           hold on;
       end
       axis tight;
       %xlim([0 .3])
       %ylim([-2 2])
       title(plot_title);
       hold off;
   end

   
   
   cfg.showlabels  = 'yes';
   cfg.layout      = 'biosemi128.lay';
   figure; ft_multiplotER(cfg, gram.grandavg, lex.grandavg);
   
   cfg.channel = channel;
   figure; ft_singleplotER(cfg, gram.grandavg, lex.grandavg);
   
   
   
   
end