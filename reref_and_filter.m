function [] = reref_and_filter(experiment, participant)    
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);

    cfg.inputfile   = [cfg.subjectdir cfg.subjectstr '_ICApruned.mat'];    

    %% 9. re-reference 
    cfg.channel     = [1:128, 137];
    cfg.reref       = 'yes';
    cfg.refchannel  = 'all';
    
    %% Filter
    % Lange (2015): 0.2-30 Hz bandpass
    cfg.hpfreq      = 0.2;
    cfg.hpfilttype  = 'fir';

    cfg.lpfreq      = 30;
    cfg.lpfilttype  = 'fir';

    
    data = ft_preprocessing(cfg);
    
    save([cfg.subjectdir cfg.subjectstr '_ICApruned_filtered.mat'] ...
        ,'data', '-v7.3');

    

end