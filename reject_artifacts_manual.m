function [] = reject_artifacts_manual(experiment, participant)
    add_filedtrip_path();
    
    
    for condition = {'gram', 'lex'}
        icondition = condition{1};
        cfg = initialize_participant_cfg(experiment, participant);
        cfg.inputfile = [cfg.files.ICA_pruned_filtered_ icondition '_stim'];


        cfg.method   = 'summary';
%         cfg.outputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_ icondition];
        data_clean   = ft_rejectvisual(cfg);
    end
    

end

