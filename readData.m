function [cfg data] = readData(data_file)
    cfg         = [];
    cfg.dataset = data_file;
    data        = ft_preprocessing(cfg);
end