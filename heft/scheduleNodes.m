function [nodes_schedule] = scheduleNodes(Graph,order,cost_table)
% Find the EST and EFT of each node and to which processor each node is assigned

nodes_names = Graph.Nodes.Name;
processors = size(cost_table,2);

% EFT - earliest finish time of each node
% EST - earliest start time of each node
% assigned_proc - to which processor each node is assigned
EFT = zeros(length(order),1);
EST = zeros(length(order),1);
assigned_proc = zeros(length(order),1);

% procs_eft is the time each processor will become available (processor earliest finish time)
procs_eft = zeros(1,processors);

% Run on all nodes by the execution order
for i=1:length(order)
    curr_node = order(i);
    % Find all the predecessors of the current node
    pred_nodes = predecessors(Graph,curr_node);
    temp_eft = zeros(processors,1);

    if ~isempty(pred_nodes)
        % Check the EFT of the current node on each processor
        for k = 1:processors
            % the EFT of curr_node on processor k counting from the node's predecessors
            pred_eft = max(EFT(pred_nodes) + distances(Graph,pred_nodes,curr_node) .* (k ~= assigned_proc(pred_nodes)));

            % Find the maximum time between the predecessors EFT and the time 
            % the processor become available
            temp_eft(k) = max(procs_eft(k) , pred_eft) + cost_table(curr_node,k);
        end
    else
        temp_eft = procs_eft + cost_table(curr_node,:);
    end
    
    % Save the EFT of curr_node and to which processor the node is assigned
    [EFT(curr_node) , assigned_proc(curr_node)] = min(temp_eft);
    % Save the EST of curr_node
    EST(curr_node) = EFT(curr_node) - cost_table(curr_node,assigned_proc(curr_node)) + 1;
    % Save the EFT of the assigned processor
    procs_eft(assigned_proc(curr_node)) = EFT(curr_node);

end

% Arrange the nodes schedule in a table
nodes_schedule = table((1:length(order))', nodes_names, assigned_proc, EST, EFT, ...
    'VariableNames',{'NodeID','NodeName','Processor','EST','EFT'});
end
