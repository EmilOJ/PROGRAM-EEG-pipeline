function [] = visual_inspect_data2(experiment, participant, filter_boolean, continuous, channels)
   
     
    cfg     = initialize_participant_cfg(experiment, participant);
    cfg.inputfile = [cfg.files.raw_filtered_ 'lex' '_' 'stim'];

    data = ft_preprocessing(cfg);
    cfg = rmfield(cfg, 'inputfile'); 
    
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