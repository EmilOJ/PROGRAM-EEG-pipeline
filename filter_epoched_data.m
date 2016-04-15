function [data] = filter_epoched_data(filter_cfg, data)
    cfg.hpfilter    = 'yes';
    cfg.hpfreq      = filter_cfg.hpfreq;
    cfg.hpfilttype  = filter_cfg.hpfilttype;

    cfg.lpfilter    = 'yes';
    cfg.lpfreq      = filter_cfg.lpfreq;
    cfg.lpfilttype  = filter_cfg.lpfilttype;

    data = ft_preprocessing(cfg, data);
end