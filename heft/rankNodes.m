function [ranks] = rankNodes(Graph,cost)
% Find the rank of each node

ranks = zeros(1,height(Graph.Nodes));
start_nodes = find(indegree(Graph) == 0);

for i = 1:length(start_nodes)
    [ranks] = calcRank(Graph, ranks, cost, start_nodes(i));
end

end

function [ranks] = calcRank(Graph,ranks,cost,curr_node)
% Calculate recursively the rank of each node

if ranks(curr_node)
    return
end

succ = successors(Graph,curr_node);
if isempty(succ)
    ranks(curr_node) = cost(curr_node);
    return
end

for i=1:length(succ)
    ranks = calcRank(Graph,ranks,cost,succ(i));
end

ranks(curr_node) = cost(curr_node) + max( distances(Graph,curr_node,succ) + ranks(succ) );

end
