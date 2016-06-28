function [] = visual_inspect_data(experiment, participant, file, filter_boolean, continuous, channels)
   
    cfg     = initialize_participant_cfg(experiment, participant);
    if strcmp(file, 'raw')
        cfg.dataset                 = [cfg.subjectdir cfg.subjectstr '.bdf'];
        
        data = ft_preprocessing(cfg);
        cfg = rmfield(cfg, 'dataset'); 
    else
        cfg.inputfile = cfg.files.(file);
        
        data = ft_preprocessing(cfg);
        cfg = rmfield(cfg, 'inputfile'); 
    end
    
    if filter_boolean == 1
        cfg.preproc.lpfilter    = 'yes';
        cfg.preproc.lpfreq      = 30;
        cfg.preproc.hpfilter    = 'yes';
        cfg.preproc.hpfreq      = 1;
    end
 
    
    cfg.channel             = channels;
    if (continuous)
        cfg.continuous          = 'yes';
        cfg.blocksize           = 20; %seconds
    else
        cfg.continuous          = 'no';
    end
    
    cfg.ylim                = [-17 17];
    
    cfg.viewmode            = 'vertical';
    
    
   
    ft_databrowser(cfg,data);
    

end