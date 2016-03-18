function [] = pipeline_ft(experiment, participant)
    % 1. read the data
    % 2. hp filter (1 Hz) & maybe lp filter (aprpox. 40 Hz)
    % 3. epoch into dummy consecutive epochs (length approx. 1sec)
    % 4. Remove bad channels from visual inspection
    % (4. get rid of non-stereotypical artifacts (use probability and
    % kurtosis functions in eeglab, start with SD=3, for noisy data go down to 2, for good data go up to 4))
    % 5. train extended infomax ica (no dimensionality reduction)
    % 6. save the unmixing weights (EEG.icaweights & EEG.icasphere), discard the rest
    % 7. read in the raw data again
    % 8. apply the ica weights to the unprocessed raw data
    % 9. filter and re-reference the raw data, tailored towards the features of interest
    % 10. get rid of artifacts by back-projection of all but the artifact ICs (I suggest using CORRMAP for the classification process, it is near objective and very robust, we get plenty positive feedback from other labs)
    % 11. extract events      
    
    tic
    add_filedtrip_path();
    cfg_epoch_1s = initialize_participant_cfg(experiment, participant);

    % 2. Filter config
    cfg_epoch_1s.hpfilter                = 'yes';
    cfg_epoch_1s.hpfreq                  = 1; %Hz
    cfg_epoch_1s.lpfilter                = 'yes';
    cfg_epoch_1s.lpfreq                  = 40; %Hz

    % 3. Seperate into 1 second epochs config
    cfg_epoch_1s.trialfun                = 'ft_trialfun_general';
    cfg_epoch_1s.trialdef.triallength    = 1; % duration in seconds
    cfg_epoch_1s.trialdef.ntrials        = inf; 
    cfg_epoch_1s                         = ft_definetrial(cfg_epoch_1s);

    % 4. Remove bad channels
    cfg_epoch_1s.channel                 = get_channellist();

    % Preprocess (with above configs)
    data_epoch_1s                        = ft_preprocessing(cfg_epoch_1s);
    
    % Show elapsed time
    preproc_time = toc;
    disp(['Preprocessing time: '  num2str(preproc_time) ' seconds']);

    % 5. ICA
    cfg_epoch_1s.method                  = 'runica';
    try
        % ICA decomposition
        comp = ft_componentanalysis(cfg_epoch_1s, data_epoch_1s);
    catch
        disp('Could not run ICA');
    end
    
    % Save decomposition
    save([cfg_epoch_1s.datadir cfg_epoch_1s.subjectstr 'ICAcomp.mat'], 'comp', '-v7.3');

    % 8. apply the ica weights to the unprocessed raw data
    % 9. filter and re-reference the raw data, tailored towards the features of interest
    % 10. get rid of artifacts by back-projection of all but the artifact ICs (I suggest using CORRMAP for the classification process, it is near objective and very robust, we get plenty positive feedback from other labs)



    %% Helper functions
    function channels = get_channellist()
        load([cfg_epoch_1s.datadir 'bad_channels'], 'bad_channels');
        channels = 1:128;

        for i = 1:length(bad_channels.(cfg_epoch_1s.subjectstr))
            channels = channels(channels ~= bad_channels.(cfg_epoch_1s.subjectstr)(i));
        end
        disp(['Defining channels to remove:' mat2str(bad_channels.(cfg_epoch_1s.subjectstr))]);
    end

    clear all;
end







