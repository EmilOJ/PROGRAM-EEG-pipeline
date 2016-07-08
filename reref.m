function [] = reref(experiment, participant)
    for condition = {'gram', 'lex'}
        icondition = condition{1};
        for alignment = {'stim','response'}
            ialignment = alignment{1};
            
            cfg = [];
            cfg = initialize_participant_cfg(experiment, participant);
            cfg.inputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_interpolated_ icondition '_' ialignment]
            cfg.outputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_interpolated_ icondition '_' ialignment]

            cfg.reref = 'yes';
            cfg.refchannel = 1:128;
            cfg.channel = 1:128;

            ft_preprocessing(cfg);
        end
    end
end