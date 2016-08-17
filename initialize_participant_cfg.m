function [cfg] = initialize_participant_cfg(experiment, participant, ICA)
    if nargin < 3
        ICA = 1;
    end
    
    [my_root, my_fieldtrip_path] = my_config();
    cfg                         = [];
    cfg.rootdir                 = [my_root filesep];
    cfg.subjectnr               = num2str(participant);
    cfg.subjectstr              = ['part' cfg.subjectnr];
    cfg.datadir                 = [cfg.rootdir 'EEG-' experiment filesep];
    cfg.subjectdir              = [cfg.datadir cfg.subjectstr filesep];
    cfg.ERPdir                  = [cfg.datadir 'ERP' filesep];
    cfg.proc_data               = read_proc_notes(experiment, ICA);
  
    cfg.RTdir                   = [cfg.rootdir 'Behavioural-' experiment filesep 'all' filesep];
    cfg.experiment              = experiment;
    cfg.ICAcomp_path            = [cfg.subjectdir cfg.subjectstr 'ICAcomp.mat'];
    
    cfg.files.raw               = [cfg.subjectdir cfg.subjectstr '.bdf'];
    cfg.files.raw_filtered      = [cfg.subjectdir cfg.subjectstr '_raw_filtered.mat'];
    cfg.files.raw_filtered_      = [cfg.subjectdir cfg.subjectstr '_raw_filtered_'];
    cfg.files.ICA_pruned        = [cfg.subjectdir cfg.subjectstr '_ICApruned.mat'];
    cfg.files.ICA_pruned_filtered = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered.mat'];
    cfg.files.ICA_pruned_filtered_artifacts_rejected_ = [cfg.subjectdir cfg.subjectstr '_ICA_pruned_filtered_artifacts_rejected_'];
    cfg.files.ICA_pruned_filtered_artifacts_rejected_interpolated_ = [cfg.subjectdir cfg.subjectstr '_ICA_pruned_filtered_artifacts_rejected_interpolated_'];
    cfg.files.ICA_pruned_filtered_ = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered_'];
  
    cfg.files.gram              = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered_gram.mat'];
    cfg.files.lex              = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered_lex.mat'];
    
end