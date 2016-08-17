function proc_data = read_proc_notes(experiment, ICA)
    [my_root, my_fieldtrip_path] = my_config();
    cfg                         = [];
    cfg.rootdir                 = [my_root filesep];
    cfg.datadir                 = [cfg.rootdir 'EEG-' experiment filesep];
    
    if ICA
        [num, txt, raw] = xlsread([cfg.datadir 'proc_notes_article.xlsx']);
    else
        [num, txt, raw] = xlsread([cfg.datadir 'proc_notes_article2.xlsx']);
    end
    
    for i = 2:31
        subjstr = raw{i,1};
        assign_data(3,'bad_channel');
        assign_data(4,'eye_blink_comp');
        assign_data(5,'eye_mov_comp');
        assign_data(12,{'missingchan', 'gram'}, 'c');
        assign_data(13,{'missingchan', 'lex'}, 'c');
        assign_data(10,{'rejecttrial', 'gram'});
        assign_data(11,{'rejecttrial', 'lex'});
    end
    
    
    function [] = assign_data(row, name, type)
        if nargin < 3
            type = 'num';
        end
        
        value = raw{i,row};
        
        if strcmp(type, 'num')   
            if isnumeric(value) & ~isnan(value)
                if iscell(name)
                    proc_data.(subjstr).(name{1}).(name{2}) = value;
                else
                    proc_data.(subjstr).(name) = value;
                end
                
            elseif ischar(value)
                if iscell(name)
                    proc_data.(subjstr).(name{1}).(name{2}) = str2num(value);
                else
                    proc_data.(subjstr).(name) = str2num(value);
                end
            else
                if iscell(name)
                    proc_data.(subjstr).(name{1}).(name{2}) = [];
                else
                    proc_data.(subjstr).(name) = [];
                end
            end
        elseif strcmp(type, 'c')
            if ~isnan(value)
                proc_data.(subjstr).(name{1}).(name{2}) = strsplit(value,',');
            else
                proc_data.(subjstr).(name{1}).(name{2}) = {};
            end
        end
            
    end
end