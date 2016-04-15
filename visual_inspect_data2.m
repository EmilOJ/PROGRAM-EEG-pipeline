function [] = visual_inspect_data2(cfg, data)
   
    cfg.channel             = [1:20];
    cfg.continuous          = 'no';
    
    cfg.ylim                = [-17 17];
    
    cfg.viewmode            = 'butterfly';
    cfg.preproc.lpfilter    = 'yes';
    cfg.preproc.lpfreq      = 30;
    cfg.preproc.hpfilter    = 'yes';
    cfg.preproc.hpfreq      = 1;
    
    
    ft_databrowser(cfg, data);
    

end