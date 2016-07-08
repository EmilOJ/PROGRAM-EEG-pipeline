function [cfg] = reject_artifacts(experiment, participant, alignment)
%     cfg.continuous = 'yes';
%     cfg.artfctdef.clip.channel = 1:128;    
%     cfg = ft_artifact_clip(cfg);
%     
%     cfg.artfctdef.jump.interactive = 'yes';
%     cfg.artfctdef.zvalue.interactive = 'yes';
    
%     cfg.artfctdef.jump.channel = 1:128;    
%     cfg = ft_artifact_jump(cfg);
%     
%     cfg.artfctdef.muscle.channel = 1:128;    
%     cfg = ft_artifact_muscle(cfg);
%     
%     cfg = ft_rejectartifact(cfg);
%     
    for condition = {'gram', 'lex'}
        icondition = condition{1};
        cfg = initialize_participant_cfg(experiment, participant);
        cfg.inputfile = [cfg.files.ICA_pruned_filtered_ icondition '_' alignment];


        cfg.method   = 'summary';
        cfg.outputfile = [cfg.files.ICA_pruned_filtered_ icondition '_' alignment];
        data_clean   = ft_rejectvisual(cfg);
    end

   
end

