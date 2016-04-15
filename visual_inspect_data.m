function [] = visual_inspect_data(experiment, participant)
   
    cfg     = initialize_participant_cfg(experiment, participant);
 
    
    cfg.channel             = [1:128];
    cfg.continuous          = 'yes';
    cfg.blocksize           = 20; %seconds
    cfg.ylim                = [-17 17];
    
    cfg.viewmode            = 'vertical';
    cfg.preproc.lpfilter    = 'yes';
    cfg.preproc.lpfreq      = 30;
    cfg.preproc.hpfilter    = 'yes';
    cfg.preproc.hpfreq      = 1;
    
   
    ft_databrowser(cfg);
    

end