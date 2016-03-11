function [cfg data] = read_data(data_file)
    cfg         = [];
    cfg.dataset = data_file;
    data        = ft_preprocessing(cfg);
end