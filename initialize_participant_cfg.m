function [cfg] = initialize_participant_cfg(experiment, participant)
    cfg                         = [];
    cfg.rootdir                 = ['/Users/emil/Desktop/Experiment1/data' filesep];
    cfg.subjectnr               = num2str(participant);
    cfg.subjectstr              = ['part' cfg.subjectnr];
    cfg.dataset                 = [cfg.subjectstr '.bdf'];
    cfg.datadir                 = [cfg.rootdir 'EEG-' experiment filesep];
end