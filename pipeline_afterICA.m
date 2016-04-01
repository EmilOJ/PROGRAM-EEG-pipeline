function [cfg data] = pipeline_afterICA(experiment, participant)    
 %% 8. apply the ica weights to the unprocessed raw data

 
 %% 9. filter and re-reference the raw data, tailored towards the features of interest
 
 
 %% 10. get rid of artifacts by back-projection of all but the artifact ICs (I suggest using CORRMAP for the classification process, it is near objective and very robust, we get plenty positive feedback from other labs)


 %% 11. extract events   
    cfg.trialdef.eventcodes.det.gram = 65301;
    cfg.trialdef.eventcodes.det.lex = 65311;
    cfg.trialdef.eventcodes.verb.gram = [65421 65431 65422 65432];
    cfg.trialdef.eventcodes.verb.lex = [65521 65531 65522 65532];
    


    [cfg_gram, data_gram]       = epoch_data('gram');
    [cfg_lex, data_lex]         = epoch_data('lex');


    
    

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