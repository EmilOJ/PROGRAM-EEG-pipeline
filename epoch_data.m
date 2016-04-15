function [cfg_cond data_cond] = epoch_data(cfg, condition, data)
    cfg.trialdef.eventcodes.det.gram = 65301;
    cfg.trialdef.eventcodes.det.lex = 65311;
    cfg.trialdef.eventcodes.verb.gram = [65421 65431 65422 65432];
    cfg.trialdef.eventcodes.verb.lex = [65521 65531 65522 65532];

    cfg.trialdef.eventtype  = 'STATUS';
    cfg.trialfun            = 'my_trialfun'; 
    switch cfg.experiment
        case 'det' 
            switch condition
                case 'gram'
                    cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.det.gram;
                case 'lex'
                    cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.det.lex;
            end

        case 'verb'
            switch condition
                case 'gram'
                    cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.verb.gram;
                case 'lex'
                    cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.verb.lex;
            end
    end

    cfg_cond    = ft_definetrial(cfg);
    data_cond   = ft_redefinetrial(cfg_cond, data);
end