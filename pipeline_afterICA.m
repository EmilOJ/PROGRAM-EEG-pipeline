function [cfg data] = pipeline_afterICA(experiment, participant)
 %% Load data
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);
    
    % Load ICA decomposition
    load([cfg.datadir 'proc_data']);
    
    cfg.component = proc_data.(cfg.subjectstr).eye_blink_comp;
    load(cfg.ICAcomp_path);
    
    
 
 %% 10. get rid of artifacts by back-projection of all but the artifact ICs (I suggest using CORRMAP for the classification process, it is near objective and very robust, we get plenty positive feedback from other labs)

    data = ft_preprocessing(cfg);
    data = ft_rejectcomponent(cfg, comp, data);
    
 
 %% 9. re-reference the raw data
    % Lange (2015): 0.2-30 Hz bandpass

    cfg.channel     = [1:128, 137];
%     
    cfg.reref       = 'yes';
    cfg.refchannel  = 'all';
%     
    data = ft_preprocessing(cfg, data);
 


 %% 11. extract events   
    
    [cfg_gram, data_gram]       = epoch_data(cfg, 'gram', data);
    [cfg_lex, data_lex]         = epoch_data(cfg, 'lex', data);

    
 %% Filter
    
    filter_cfg.hpfreq      = 0.2;
    filter_cfg.hpfilttype  = 'fir';
    
    filter_cfg.lpfreq      = 30;
    filter_cfg.lpfilttype  = 'fir';
    
    data_gram = filter_epoched_data(filter_cfg, data_gram);
    data_gram = filter_epoched_data(filter_cfg, data_gram);
    
    save([cfg.subjectdir cfg.subjectstr '_ICApruned_epoched_filtered.mat'] ...
        ,'cfg_lex', 'cfg_gram', 'data_gram', 'data_lex', '-v7.3');
    

   
end