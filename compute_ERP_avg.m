function [avg] = compute_ERP_avg(experiment, participant, condition, alignment)
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);
    
    
    cfg1.inputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_interpolated_ condition '_' alignment];
    avg = ft_timelockanalysis(cfg1);
%     
%     cfg = [];
%     cfg.baseline = [-300 -50];
%     
%     avg = ft_timelockbaseline(cfg, avg);
end
