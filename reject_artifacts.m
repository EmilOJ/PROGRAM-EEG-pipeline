function [] = reject_artifacts(experiment, participant)
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);
    
    load([cfg.subjectdir cfg.subjectstr '_ICApruned_epoched_filtered.mat']);
    
    cfg          = [];
    cfg.method   = 'summary';
    cfg.layout   = 'biosemi128.lay';
    cfg.channel  = [1:128];    
    data_clean   = ft_rejectvisual(cfg, data_gram);
    

end

