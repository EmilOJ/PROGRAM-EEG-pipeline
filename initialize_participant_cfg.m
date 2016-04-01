function [cfg] = initialize_participant_cfg(experiment, participant)
    eval('my_config')
    cfg                         = [];
    cfg.rootdir                 = [my_root filesep];
    cfg.subjectnr               = num2str(participant);
    cfg.subjectstr              = ['part' cfg.subjectnr];
    cfg.datadir                 = [cfg.rootdir 'EEG-' experiment filesep];
    cfg.dataset                 = [cfg.datadir cfg.subjectstr '.bdf'];
    
    
end