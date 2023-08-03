function [Graph] = gnrtRandomDAG(num_of_nodes,min_weight,max_weight)
% Create random DAG

start_nodes = 1;  %number of nodes in the first level
end_nodes   = 1;  %number of nodes in the last level

nodes_left = num_of_nodes - start_nodes - end_nodes;
nodes = round(sqrt(num_of_nodes - start_nodes - end_nodes));
next_nodes = 1:start_nodes;

Graph = digraph;
Graph = addnode(Graph,start_nodes);

while nodes_left > 0
    curr_nodes = next_nodes;

    low = max(nodes - 2, 2);
    high = min(nodes + 2, nodes_left);

    if high <= low
        nodes = nodes_left;
    else
        nodes = randi([low high]);
    end

    nodes_left = nodes_left - nodes;

    if nodes_left == 1
        nodes = nodes + 1;
        nodes_left = 0;
    end

    Graph = addnode(Graph,nodes);


    next_nodes = (curr_nodes(end)+1):(curr_nodes(end)+nodes);

    % Connect nodes in the current level to nodes in the next level
    for i = 1:length(curr_nodes)
        while ~outdegree(Graph,curr_nodes(i))
            next = next_nodes .* randi([0 1],size(next_nodes));
            next(next == 0) = [];
            weight = randi([min_weight max_weight],size(next));
            Graph = addedge(Graph,curr_nodes(i),next,weight);
        end
    end

    % Make sure no nodes left unconnected
    for i = 1:length(next_nodes)
        while ~indegree(Graph,next_nodes(i))
            curr = curr_nodes .* randi([0 1],size(curr_nodes));
            curr(curr == 0) = [];
            weight = randi([min_weight max_weight],size(curr));
            Graph = addedge(Graph,curr,next_nodes(i),weight);
        end
    end

end

% Connect the nodes of the last level to the graph
curr_nodes = next_nodes;
next_nodes = (curr_nodes(end)+1):num_of_nodes;
Graph = addnode(Graph,end_nodes);

for i = 1:length(curr_nodes)
    weight = randi([min_weight max_weight],size(next_nodes));
    Graph = addedge(Graph,curr_nodes(i),next_nodes,weight);
end

end
