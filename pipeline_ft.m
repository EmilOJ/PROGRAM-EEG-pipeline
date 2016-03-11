function [cfg, data] = pipeline_ft()
    % 1. read the data
    % 2. hp filter (1 Hz) & maybe lp filter (aprpox. 40 Hz)
    % 3. epoch into dummy consecutive epochs (length approx. 1sec)
    % 4. get rid of non-stereotypical artifacts (use probability and kurtosis functions in eeglab, start with SD=3, for noisy data go down to 2, for good data go up to 4)
    % 5. train extended infomax ica (no dimensionality reduction)
    % 6. save the unmixing weights (EEG.icaweights & EEG.icasphere), discard the rest
    % 7. read in the raw data again 
    % 8. apply the ica weights to the unprocessed raw data
    % 9. filter and re-reference the raw data, tailored towards the features of interest
    % 10. get rid of artifacts by back-projection of all but the artifact ICs (I suggest using CORRMAP for the classification process, it is near objective and very robust, we get plenty positive feedback from other labs)


    clear all;
    tic
    % Read data config
    data_file                   = 'part10.bdf';
    cfg                         = [];
    cfg.dataset                 = data_file;
    
    % Seperate into 1 second epochs config
    cfg.trialfun                = 'ft_trialfun_general';
    cfg.trialdef.triallength    = 1; % duration in seconds
    cfg.trialdef.ntrials        = inf;                    % number of trials, inf results in as many as possible
    cfg                         = ft_definetrial(cfg);

    % Filter config
    cfg.hpfilter                = 'yes';
    cfg.hpfreq                  = 1; %Hz    
    cfg.lpfilter                = 'yes';
    cfg.lpfreq                  = 40; %Hz

    % Preprocess (with above configs)
    data                        = ft_preprocessing(cfg);
    
    toc

 
    
%     %% Extract events
%     cfg.trialdef.eventcodes.gram = 65301;
%     cfg.trialdef.eventcodes.lex = 65311;
% 
%     [cfg_lex, data_lex, cfg_gram, data_gram] = epoch_data(cfg);
% 
%     %% Artifacts
% 
%     data_test = ft_rejectvisual(cfg_gram, data_gram);
%     
%     
%     

end





    
    
    
    