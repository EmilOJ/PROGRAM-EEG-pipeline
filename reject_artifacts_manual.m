function [] = reject_artifacts_manual(experiment, participant, ICA)
    add_filedtrip_path();
    
    
    for condition = {'gram', 'lex'}
        icondition = condition{1};
        cfg = initialize_participant_cfg(experiment, participant);
        if ICA
            cfg.inputfile = [cfg.files.ICA_pruned_filtered_ icondition '_stim'];
        else
            cfg.inputfile = [cfg.files.raw_filtered_ icondition '_' 'stim'];
        end


        cfg.method   = 'summary';
%         cfg.outputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_ icondition];
        data_clean   = ft_rejectvisual(cfg);
    end
    

end

