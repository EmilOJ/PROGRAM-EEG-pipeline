function [] = add_filedtrip_path()
     [my_root, my_fieldtrip_path] = my_config();;
     addpath(my_fieldtrip_path);
end