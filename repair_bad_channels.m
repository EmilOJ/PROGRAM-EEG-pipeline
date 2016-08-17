function [] = repair_bad_channels(experiment, participant) 
    add_filedtrip_path();
    
%     cfg = initialize_participant_cfg(experiment, participant);
    
    cfg = [];
    cfg = initialize_participant_cfg(experiment, participant);
    cfg.method = 'triangulation';
    cfg.layout = 'biosemi128.lay';
    cfg.channel = 'all';
    load([cfg.files.ICA_pruned_filtered]);
    neighbours = ft_prepare_neighbours(cfg, data);
    
    for alignment = {'stim','response'}
        ialignment = alignment{1};
        for condition = {'gram', 'lex'}
            icondition = condition{1};

            

            cfg = [];
            cfg = initialize_participant_cfg(experiment, participant);
            cfg.neighbours = neighbours;
            cfg.method = 'spline';
            cfg.layout = 'biosemi128.lay';
            cfg.inputfile = [cfg.files.ICA_pruned_filtered_ icondition '_' ialignment];
            cfg.outputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_interpolated_ icondition '_' ialignment];
            load([cfg.rootdir 'elecpos.mat']);
            cfg.elec = elec;

            load([cfg.files.ICA_pruned_filtered_ icondition '_' ialignment]);
            cfg.badchannel = cfg.proc_data.(cfg.subjectstr).missingchan.(icondition);
            if length(cfg.badchannel) ~= length(ft_channelselection(cfg.badchannel,data.label))
                error('Could not verify bad channels loaded from excel sheet');
            end
            interp = ft_channelrepair(cfg);

        end
    end



end
