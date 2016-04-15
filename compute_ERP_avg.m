function [avg] = compute_ERP_avg(experiment, participant, condition)
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);
    
    
    cfg1.inputfile = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered_' condition '.mat'];
    avg = ft_timelockanalysis(cfg1);
end
