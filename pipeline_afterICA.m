function [cfg data] = pipeline_afterICA(experiment, participant)    
    %% Extract events
    cfg.trialdef.eventcodes.det.gram = 65301;
    cfg.trialdef.eventcodes.det.lex = 65311;
    cfg.trialdef.eventcodes.verb.gram = [65421 65431 65422 65432];
    cfg.trialdef.eventcodes.verb.lex = [65521 65531 65522 65532];
    


    [cfg_gram, data_gram]       = epoch_data('gram');
    [cfg_lex, data_lex]         = epoch_data('lex');

    %% Artifacts

    data_test = ft_rejectvisual(cfg_gram, data_gram);




    function [cfg_cond data_cond] = epoch_data(condition)
            cfg.trialdef.eventtype = 'STATUS';
            switch experiment
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
            data_cond   = ft_redefinetrial(cfg_cond, data_proc);           
    end
end