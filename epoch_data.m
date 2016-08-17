function [] = epoch_data(experiment, participant, ICA)
    cfg = initialize_participant_cfg(experiment, participant, ICA);
    cfg_data = cfg;
    cfg_data.inputfile = cfg.files.ICA_pruned;
    data_org = ft_preprocessing(cfg_data);
    for alignment = {'stim','response'}
        for condition = {'gram', 'lex'}


            icondition = condition{1};
            cfg.condition = icondition;

            cfg.trialdef.eventcodes.det.gram = 65301;
            cfg.trialdef.eventcodes.det.lex = 65311;
            cfg.trialdef.eventcodes.verb.gram = [65421 65431 65422 65432];
            cfg.trialdef.eventcodes.verb.lex = [65521 65531 65522 65532];

            cfg.trialdef.eventtype  = 'STATUS';

            cfg.trialfun = 'my_trialfun'; 


            switch cfg.experiment
                case 'det' 
                    switch icondition
                        case 'gram'
                            cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.det.gram;
                        case 'lex'
                            cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.det.lex;
                    end

                case 'verber'
                    switch icondition
                        case 'gram'
                            cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.verb.gram;
                        case 'lex'
                            cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.verb.lex;
                    end
            end

            cfg.dataset = [cfg.subjectdir cfg.subjectstr '.bdf'];
            cfg.alignment = alignment{1};
            cfg.original_samples = data_org.trial{1}(129,:);

            %cfg.baselinewindow = [-2 -0.25]; % Set here for baseline correction

            cfg_cond    = ft_definetrial(cfg);
            
%             trl         = cfg_cond.trl;
%             cfg_art     = [];
%             cfg_art.trl = trl;
%             cfg_art.dataset = [cfg.subjectdir cfg.subjectstr '.bdf'];
%             cfg_art =       reject_artifacts(cfg_art);
%             
%             
%             cfg_cond.trl = cfg_art.trl;
            
            
            if ICA
                cfg_cond.inputfile = cfg.files.ICA_pruned_filtered;
                cfg_cond.outputfile   = [cfg_cond.subjectdir cfg_cond.subjectstr '_ICApruned_filtered_' icondition '_' alignment{1} '.mat'];
            else
                cfg_cond.inputfile = cfg.files.raw_filtered;
                cfg_cond.outputfile   = [cfg.files.raw_filtered_ icondition '_' alignment{1} '.mat'];
            end
                
            ft_redefinetrial(cfg_cond);

            % Baseline correction
%             cfg_b    = [];
%             if strcmp(alignment,'stim')
%                 cfg_b.demean = 'yes';
%                 cfg_b.baselinewindow = cfg_cond.baselinewindow + (-cfg_cond.baselinewindow(1));
%             end
%             cfg_b       = [];
%             cfg_b.reref = 'yes';
%             cfg_b.refchannel = 1:128;
%             cfg_b.channel = 1:128;
% 
%             
%             cfg_b.outputfile   = [cfg_cond.subjectdir cfg_cond.subjectstr '_ICApruned_filtered_' icondition '_' alignment{1} '.mat'];
%             data   = ft_preprocessing(cfg_b, data);
%             subplot(2,1,2); plot(data.trial{1}(1,:));
            


        end
    end
end