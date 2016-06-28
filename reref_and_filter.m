function [] = reref_and_filter(experiment, participant)    
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);

    cfg.inputfile   = [cfg.subjectdir cfg.subjectstr '_ICApruned.mat']; 
    cfg.outputfile  = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered.mat'];

    %% 9. re-reference 
    cfg.channel     = [20:21];
    cfg.reref       = 'yes';
    cfg.refchannel  = 'all';
    
    %% Filter
    % Lange (2015): 0.2-30 Hz bandpass
    cfg.hpfilter    = 'yes';
    cfg.hpfreq      = 0.2;
    cfg.hpfilttype  = 'firws';
    cfg.hpfiltwintype = 'kaiser';
   
    

    cfg.lpfilter    = 'yes';
    cfg.lpfreq      = 30;
    cfg.lpfilttype  = 'firws'; 
    cfg.hpfiltwintype = 'kaiser';

    cfg.plotfiltresp = 'yes';
    

    
    data = ft_preprocessing(cfg);
    

end