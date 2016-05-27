function [] = epoch_data(experiment, participant, alignment)
    cfg = initialize_participant_cfg(experiment, participant);
    
    for condition = {'gram', 'lex'}
        icondition = condition{1};
        cfg.condition = icondition;

        cfg.trialdef.eventcodes.det.gram = 65301;
        cfg.trialdef.eventcodes.det.lex = 65311;
        cfg.trialdef.eventcodes.verb.gram = [65421 65431 65422 65432];
        cfg.trialdef.eventcodes.verb.lex = [65521 65531 65522 65532];

        cfg.trialdef.eventtype  = 'STATUS';
       
        cfg.trialfun = 'my_trialfun'; 
        
        
        switch cfg.experiment
            case 'det' 
                switch icondition
                    case 'gram'
                        cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.det.gram;
                    case 'lex'
                        cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.det.lex;
                end

            case 'verb'
                switch icondition
                    case 'gram'
                        cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.verb.gram;
                    case 'lex'
                        cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.verb.lex;
                end
        end
        
        cfg.dataset = [cfg.subjectdir cfg.subjectstr '.bdf'];
        cfg.alignment = alignment;
        cfg_cond    = ft_definetrial(cfg);
        cfg_cond.inputfile   = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered.mat'];
        cfg_cond.outputfile   = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered_' icondition '_' alignment '.mat'];

        data   = ft_redefinetrial(cfg_cond);
    end
end