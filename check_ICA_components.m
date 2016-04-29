function [] = check_ICA_components(experiment, participant)
    cfg = initialize_participant_cfg(experiment, participant);
    
    % Load ICA decomposition
    load([cfg.subjectdir cfg.subjectstr 'ICAcomp']);
    
    
    cfg.component = [1:20]; % Components to show
    
    cfg.layout      = 'biosemi128.lay';
    cfg.comment     = 'no';
    ft_topoplotIC(cfg, comp); % Plot components
    
    cfg.channel     = [1:5];
    cfg.viewmode    = 'component';
    cfg.continuous  = 'yes';
    cfg.blocksize   = 10; %seconds
    ft_databrowser(cfg, comp);

end