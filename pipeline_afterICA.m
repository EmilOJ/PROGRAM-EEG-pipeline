function [cfg data] = pipeline_afterICA(experiment, participant)
 %% Load data
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);
    cfg.dataset = [cfg.subjectdir cfg.subjectstr '.bdf'];
    
    % Load ICA decomposition
    load([cfg.datadir 'proc_data']);
    
    cfg.component = proc_data.(cfg.subjectstr).eye_blink_comp;
    load(cfg.ICAcomp_path);
    
    
 
 %% 10. get rid of artifacts by back-projection of all but the artifact ICs (I suggest using CORRMAP for the classification process, it is near objective and very robust, we get plenty positive feedback from other labs)

    data = ft_preprocessing(cfg);
    data = ft_rejectcomponent(cfg, comp, data);
    clear comp;

    
    save([cfg.subjectdir cfg.subjectstr '_ICApruned.mat'] ...
        ,'data', '-v7.3');
   

   
end