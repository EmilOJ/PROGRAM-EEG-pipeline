function [] = pipeline()
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

    %% Read data
    data_file       = 'part10.bdf';
    [cfg, data]  = read_data(data_file);

    %% Epoch into 1s pieces
    [cfg, data] = epoch_data_1s(cfg, data);


    %% Extract events
    cfg.trialdef.eventcodes.gram = 65301;
    cfg.trialdef.eventcodes.lex = 65311;

    [cfg_lex, data_lex, cfg_gram, data_gram] = epoch_data(cfg, data_all);

    %% Artifacts

    data_test = ft_rejectvisual(cfg_gram, data_gram);
    
    
    
    %% Functions
    
    function [cfg data] = read_data(data_file)
        cfg         = [];
        cfg.dataset = data_file;
        data        = ft_preprocessing(cfg);
    end
    
    function [cfg_lex, data_lex, cfg_gram, data_gram] = epoch_data_events(cfg_, data_all)
        cfg_.trialdef.eventtype     = 'STATUS';

        cfg_.trialdef.eventvalue    = {cfg_.trialdef.eventcodes.lex};
        cfg_lex                     = ft_definetrial(cfg_);
        data_lex                    = ft_redefinetrial(cfg_lex, data_all);

        cfg_.trialdef.eventvalue    = {cfg_.trialdef.eventcodes.gram};
        cfg_gram                    = ft_definetrial(cfg_);
        data_gram                   = ft_redefinetrial(cfg_gram, data_all);
    end

    function [cfg_, data_epoched1s] = epoch_data_1s(cfg_, data_all)
        cfg_.length               = 1;
        data_epoched1s            = ft_redefinetrial(cfg, data_org);
    end

end





    
    
    
    