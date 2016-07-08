function [] = my_filter(experiment, participant)    
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);

    cfg.inputfile   = [cfg.subjectdir cfg.subjectstr '_ICApruned.mat']; 
    cfg.outputfile  = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered.mat'];
    
    cfg.channel     = 1:128;
    
    %% Filter
    % Lange (2015): 0.2-30 Hz bandpass
    cfg.hpfilter    = 'yes';
    cfg.hpfreq      = 0.1;
    cfg.hpfilttype  = 'firws';
    cfg.hpfiltwintype = 'kaiser';

    cfg.lpfilter    = 'yes';
    cfg.lpfreq      = 30;
    cfg.lpfilttype  = 'firws'; 
    cfg.lpfiltwintype = 'kaiser';

    cfg.plotfiltresp = 'no';
    

    
    data = ft_preprocessing(cfg);
    

end