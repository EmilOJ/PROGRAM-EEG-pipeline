function [] = GA_inspect(experiment, channels, alignment)
   add_filedtrip_path();
   cfg = initialize_participant_cfg(experiment, 2);
   
   gram = load([cfg.ERPdir 'gram_GA_' alignment '.mat']);
   lex = load([cfg.ERPdir 'lex_GA_' alignment '.mat']);
   
   
  
    %% GA butterfly
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
       %Baseline correction
%        if strcmp(alignment, 'stim')
%            xlim([2 3]);
%        end
%        ylim([-2 2])
       title(plot_title);
       hold off;
       set(gca,'Ydir','reverse');
   end

   
%    
   cfg.showlabels  = 'yes';
   cfg.layout      = 'biosemi128.lay';
   
   legend('gram','lex');
   cfg.showlabels  = 'yes';
   cfg.layout      = 'biosemi128.lay';
   %Baseline correction
%    if strcmp(alignment, 'stim')
%     cfg.xlim        = [2 3];
%    end
   figure; ft_multiplotER(cfg, gram.grandavg, lex.grandavg);
   legend('gram','lex');
   
   figure; counter = 1;
   for chan = channels
       subplot(length(channels),1,counter);
       cfg.channel = chan;
       ft_singleplotER(cfg, gram.grandavg, lex.grandavg);
       set(gca,'Ydir','reverse');
       legend('gram','lex');
       counter = counter + 1;
   end
   
   clear gram;
   clear lex;
   
 
    
   
   
end