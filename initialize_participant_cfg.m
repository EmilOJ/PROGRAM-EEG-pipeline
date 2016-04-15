function [cfg] = initialize_participant_cfg(experiment, participant)
    eval('my_config')
    cfg                         = [];
    cfg.rootdir                 = [my_root filesep];
    cfg.subjectnr               = num2str(participant);
    cfg.subjectstr              = ['part' cfg.subjectnr];
    cfg.datadir                 = [cfg.rootdir 'EEG-' experiment filesep];
    cfg.subjectdir              = [cfg.datadir cfg.subjectstr filesep];
    cfg.ERPdir                  = [cfg.datadir 'ERP' filesep];
  
    cfg.RTdir                   = [cfg.rootdir 'Behavioural-' experiment filesep 'all' filesep];
    cfg.experiment              = experiment;
    cfg.ICAcomp_path            = [cfg.subjectdir cfg.subjectstr 'ICAcomp.mat'];
    
end