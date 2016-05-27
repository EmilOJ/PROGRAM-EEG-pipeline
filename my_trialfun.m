function [trl, event] = my_trialfun(cfg)
    hdr   = ft_read_header(cfg.dataset);
    event = ft_read_event(cfg.dataset);

    % search for "trigger" events
    value  = [event(find(strcmp('STATUS', {event.type}))).value]';
    sample = [event(find(strcmp('STATUS', {event.type}))).sample]';
    
    % Reject first trial (the actual first trial is trial 2)
    value   = value(2:end);
    sample  = sample(2:end);

    pretrig  = 0; %s
    posttrig = 1.2; %s
    
    pretrig = round(pretrig * hdr.Fs); %convert to samples
    posttrig = round(posttrig * hdr.Fs); %convert to samples

    trl = [];
    
    RT_file_path = [cfg.subjectdir cfg.subjectstr '.xlsx'];

    trigger_cor = 65280;
    
    RT_times = xlsread(RT_file_path);
    triggers = RT_times(:,1) + trigger_cor;
    RT = RT_times(:,2);
    
    % Check if triggers match
    if sum(~(value == triggers)) == 0
        disp('Triggers match')
    else
        error('Triggers do not match');
    end
    
    correct_triggers = cfg.trialdef.eventvalue;
    
    trials_to_keep = ~isnan(RT) & ismember(value, correct_triggers);
    
    
    value  = value(trials_to_keep);
    sample = sample(trials_to_keep);
    if (strcmp(cfg.alignment, 'stim'))
        trl_begin = sample + pretrig;
        trl_end = sample + posttrig;
    else if (strcmp(cfg.alignment, 'response'))
        RT = RT(trials_to_keep);  
        trl_end = sample + RT;
        trl_begin = trl_end - 450;
    end
    offset = repmat(pretrig, length(value),1);
    trl = [trl_begin trl_end offset]; 
    
    %% Remove previously rejected trials
    load(cfg.proc_data);
    
    trials_to_reject = proc_data.(cfg.subjectstr).rejecttrial.(cfg.condition);
    number_of_trials_to_reject = length(trials_to_reject);
    
    if number_of_trials_to_reject > 0
        trl(trials_to_reject,:) = [];
    end
        
    
    
    
   
end