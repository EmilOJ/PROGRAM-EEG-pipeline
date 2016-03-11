function [cfg_lex, data_lex, cfg_gram, data_gram] = epoch_data_events(cfg_, data_all)
    cfg_.trialdef.eventtype     = 'STATUS';

    cfg_.trialdef.eventvalue    = {cfg_.trialdef.eventcodes.lex};
    cfg_lex                     = ft_definetrial(cfg_);
    data_lex                    = ft_redefinetrial(cfg_lex, data_all);

    cfg_.trialdef.eventvalue    = {cfg_.trialdef.eventcodes.gram};
    cfg_gram                    = ft_definetrial(cfg_);
    data_gram                   = ft_redefinetrial(cfg_gram, data_all);

end