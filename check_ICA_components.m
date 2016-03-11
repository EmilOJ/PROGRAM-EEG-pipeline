function [] = check_ICA_components(experiment, participant)
    cfg = initialize_participant_cfg(experiment, participant);
    
    % Load ICA decomposition
    load([cfg.datadir cfg.subjectstr 'ICAcomp']);
    
    cfg.component = [1:20];
    cfg.layout = 'biosemi128.lay';
    cfg.comment = 'no';
    ft_topoplotIC(cfg, comp);
    
    cfg.channel = [1:5];
    cfg.viewmode = 'component';
    cfg.continous = 'yes';
    ft_databrowser(cfg, comp);

end