function [Graph, cost_table] = getHeftInput(input_file)
% Get the input graph and cost table to the HEFT function
% if input_file exists the function read the input from that file
% otherwise it generates and random graph and cost table
%
% The variables in the file need to be:
% 1 - cost_table
% 2 - Graph or adjacency_matrix

% Parameters for creating random Graph
processors = 3;    %number of processors
nodes      = 15;   %number of executable nodes
min_cost   = 7;    %minimum execution cost value
max_cost   = 20;   %maximum execution cost value
min_weight = 5;    %minimum edge weight
max_weight = 20;   %maximum edge weight

if exist('input_file','var')
    load(input_file);

    if exist('adjacency_matrix','var')
        Graph = digraph(adjacency_matrix);
    end

else
    cost_table = randi([min_cost max_cost], nodes ,processors);
    Graph = gnrtRandomDAG(nodes,min_weight,max_weight);
end

% Add names to the graph nodes it doesn't have already
if ~ismember('Name',Graph.Nodes.Properties.VariableNames)
    Graph.Nodes = cell2table(regexp(sprintf('%i ',1:height(Graph.Nodes)),'(\d+)','match')','VariableNames',{'Name'});
end

end