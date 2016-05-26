function [] = repair_bad_channels(experiment, participant) 
    add_filedtrip_path();
    
    cfg = initialize_participant_cfg(experiment, participant);
    load(cfg.proc_data);
    for condition = {'gram', 'lex'}
        icondition = condition{1};
     
        cfg = [];
        cfg = initialize_participant_cfg(experiment, participant);
        cfg.method = 'triangulation';
        cfg.layout = 'biosemi128.lay';
        cfg.channel = 'all';
        load([cfg.files.ICA_pruned_filtered_ icondition]);
        neighbours = ft_prepare_neighbours(cfg, data);
        
        cfg = [];
        cfg = initialize_participant_cfg(experiment, participant);
        cfg.neighbours = neighbours;
        cfg.method = 'spline';
        cfg.layout = 'biosemi128.lay';
        cfg.inputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_ icondition];
        cfg.outputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_interpolated_ icondition];
        load([cfg.rootdir 'elecpos.mat']);
        cfg.elec = elec;
        
        
        cfg.badchannel = proc_data.(cfg.subjectstr).missingchan.(icondition);
        interp = ft_channelrepair(cfg);
        

        
    end



end
