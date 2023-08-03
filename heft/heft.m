function [ScheduleDB] = heft(Graph,cost_table)
% HEFT Algorithm main function

[nodes, processors] = size(cost_table);

% Average computation cost
avg_cost = mean(cost_table,2);

% Find the rank of each node
ranks = rankNodes(Graph,avg_cost);

% Find node's execution order
[~, order] = sort(ranks, 'descend');

% Find the EST, EFT of each node and to which processor the node is assigned
[nodes_schedule] = scheduleNodes(Graph,order,cost_table);

% Create scheduleDB structure
ScheduleDB.Processors   = processors;
ScheduleDB.Nodes        = nodes;
ScheduleDB.Cycles       = max(nodes_schedule.EFT);
ScheduleDB.Graph        = Graph;
ScheduleDB.NodeSchedule = nodes_schedule;
ScheduleDB.CostTable    = cost_table;

end
