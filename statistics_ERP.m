function [] = statistics_ERP(experiment, subjects, alignment, method, alpha)
   
    cfg = initialize_participant_cfg(experiment, 2);
    
    if (strcmp(method, 'new'))
        %% Statistics

        load([cfg.ERPdir 'gram_averages_' alignment '.mat']);
        load([cfg.ERPdir 'lex_averages_' alignment '.mat']);

       % Find neighbours
        cfg = [];
        cfg = initialize_participant_cfg('det', 2);
        cfg.method = 'triangulation';
        cfg.layout = 'biosemi128.lay';
        cfg.channel = 'all';
        load([cfg.files.ICA_pruned_filtered_ 'gram']); %dummy data, could be any other data
        neighbours = ft_prepare_neighbours(cfg, data);


        cfg = [];
        cfg.channel     = 'all';
        cfg.neighbours  = neighbours; % defined as above
% %         %Baseline correction
%         if strcmp(alignment, 'stim')
%             cfg.latency     = [2 3]
%         else
%             cfg.latency     = 'all';
%         end
%         
        cfg.avgovertime = 'no';
        cfg.parameter   = 'avg';
        cfg.method      = 'montecarlo';
        cfg.statistic   = 'ft_statfun_depsamplesT';
        cfg.alpha       = alpha;
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

        cfg = initialize_participant_cfg(experiment, 2);

        save([cfg.ERPdir 'statistics_' alignment '.mat'], 'stat');
        
    else
        load([cfg.ERPdir 'statistics_' alignment '.mat'], 'stat');
    end

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
   
    x = linspace(0,1200,size(stat.prob,1));
    y = 1:128;
    figure;
    imagesc(x,y,stat.prob>alpha);
    colormap('hot');
    caxis([0 1]);
    xlabel('Time [ms]');
    ylabel('128 channels');
    title([alignment '-aligned: p < ' num2str(alpha)]);

end