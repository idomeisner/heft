%% Scheduling using HEFT Algorithm
close all hidden
clear
clc

addpath(genpath(pwd));

% Get the graph and cost table the HEFT algorithm is executed on
input_file = 'example1.mat';
[Graph, cost_table] = getHeftInput(input_file);

% Print the input graph and cost table for the HEFT algorithm
printHeftInput(Graph,cost_table);

% Run HEFT scheduling algorithm
[ScheduleDB]  = heft(Graph,cost_table);

% Prints the schedule result
% set 'separate_figures' to true to separate result figures
separate_figures = false;
plotSchedule(ScheduleDB, separate_figures);

rmpath(genpath(pwd));
