function [] = visual_inspect_data(experiment, participant, cfg, data)
    if cfg == []
        cfg     = initialize_participant_cfg(experiment, participant);
    end
    
    cfg.channel             = [1:20];
    cfg.continuous          = 'yes';
    cfg.blocksize           = 20; %seconds
    cfg.ylim                = [-17 17];
    
    cfg.viewmode            = 'vertical';
    cfg.preproc.lpfilter    = 'yes';
    cfg.preproc.lpfreq      = 30;
    cfg.preproc.hpfilter    = 'yes';
    cfg.preproc.hpfreq      = 1;
    
    if data == []
        ft_databrowser(cfg);
    else
        ft_databrowser(cfg, data);
    end

end