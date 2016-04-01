clear all; clc; close all;

cfg = initialize_participant_cfg('det', 2);

fid = fopen([cfg.datadir 'proc_notes.csv'], 'r');
data = textscan(fid, repmat('%s', 1, 6), 'delimiter', ',', 'CollectOutput', true);


fclose(fid);
