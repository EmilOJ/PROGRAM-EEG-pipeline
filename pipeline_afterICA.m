function [cfg data] = pipeline_afterICA(experiment, participant)
 %% Load data
    add_filedtrip_path();
    cfg = initialize_participant_cfg(experiment, participant);
    cfg.dataset = [cfg.subjectdir cfg.subjectstr '.bdf'];
    
    
    cfg.component = cfg.proc_data.(cfg.subjectstr).eye_blink_comp;
    load(cfg.ICAcomp_path);
    
    
 
 %% 10. get rid of EOG-artifacts by back-projection of all but the artifact
 %  ICs (I suggest using CORRMAP for the classification process, it is near 
 %  objective and very robust, we get plenty positive feedback from other labs)
    cfg.channel = 1:128;
    data = ft_preprocessing(cfg);
    data = ft_rejectcomponent(cfg, comp, data);
    
    
    % Add new channel containing mapping from old sample indecies
    % to new after resampling
    data.label{end+1} = 'sample';
    for i=1:size(data.sampleinfo,1)
      % this works for one or more trials
      data.trial{i}(end+1,:) = data.sampleinfo(i,1):data.sampleinfo(i,2);
    end

    cfg_downsample = [];
    cfg_downsample.resamplefs = 256;
    
%     while ~(license('checkout','Signal_Toolbox') && license('checkout','Statistics_Toolbox'))
%         %Wait for licenses to become available 
%     end
    data = ft_resampledata(cfg_downsample, data);
    
    clear comp;

    
    save([cfg.subjectdir cfg.subjectstr '_ICApruned.mat'] ...
        ,'data', '-v7.3');
   

   
end