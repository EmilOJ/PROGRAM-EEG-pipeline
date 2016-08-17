clear all; 

experiment = 'verber';
participant = 2;

cfg = initialize_participant_cfg(experiment, participant);

%%
cfg.dataset = [cfg.subjectdir cfg.subjectstr '.bdf'];
cfg.hpfilter    = 'yes';
cfg.hpfreq      = 1;
cfg.hpfilttype  = 'firws';
cfg.hpfiltwintype = 'kaiser';

cfg.lpfilter    = 'yes';
cfg.lpfreq      = 60;
cfg.lpfilttype  = 'firws'; 
cfg.lpfiltwintype = 'kaiser';

cfg.dftfilter   = 'yes';


cfg.plotfiltresp = 'no';

cfg.outputfile = cfg.files.raw_filtered;
  
data = ft_preprocessing(cfg);


%% Viewing
cfg = [];
cfg.continuous = 'yes';
cfg.blocksize           = 2; %seconds
cfg.viewmode            = 'vertical'
ft_databrowser(cfg, data);

%% Epoching
% epoch_data(experiment, participant, 0);

