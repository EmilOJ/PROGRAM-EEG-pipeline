function [] = grand_average(experiment, subjects)
   
   add_filedtrip_path();
   cfg = initialize_participant_cfg(experiment, 2);
    
   counter = 1;
   for subject = subjects
       
           avg_gram{counter} = compute_ERP_avg(experiment, subject, 'gram');
           avg_lex{counter} = compute_ERP_avg(experiment, subject, 'lex');
           counter = counter +1 ;
      
   end
   
   %% Statistics
   
   % Find neighbours
    cfg = [];
    cfg = initialize_participant_cfg(experiment, 2);
    cfg.method = 'triangulation';
    cfg.layout = 'biosemi128.lay';
    cfg.channel = 'all';
    load([cfg.files.ICA_pruned_filtered_ 'gram']); %dummy data, could be any other data
    neighbours = ft_prepare_neighbours(cfg, data);
   
   
    cfg = [];
    cfg.channel     = 'all';
    cfg.neighbours  = neighbours; % defined as above
    cfg.latency     = [0 1];
    cfg.avgovertime = 'no';
    cfg.parameter   = 'avg';
    cfg.method      = 'montecarlo';
    cfg.statistic   = 'ft_statfun_depsamplesT';
    cfg.alpha       = 0.05;
    cfg.correctm    = 'cluster';
    cfg.correcttail = 'prob';
    cfg.numrandomization = 1000;
    cfg.minnbchan   = 2;

    Nsub = length(subjects);
    cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
    cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
    cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
    cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

    stat = ft_timelockstatistics(cfg,avg_gram{:},avg_lex{:});

    % make a plot
%     cfg = [];
%     cfg.highlightsymbolseries = ['*', '*', '.', '.', '.'];
%     cfg.layout    = 'biosemi128.lay';
%     cfg.contournum = 0;
%     cfg.markersymbol = '.';
%     cfg.alpha = 0.05;
%     cfg.parameter = 'stat';
%     cfg.zlim = [-5 5];
%     figure; ft_clusterplot(cfg, stat);
    
    
    close all;
    figure;
    imagesc(prob>0.05);
    colormap('hot');
    caxis([0 1]);
    xlabel('Time [ms]');
    ylabel('128 channels');
    title('Stimulus-aligned: p < 0.05');
   
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
