function plotGraph(Graph)
% Plots the Graph as weighted digraph

nodes_names = Graph.Nodes.Name;
figure('Name','Input DAG','NumberTitle','off');
h = plot(Graph,'Layout','layered','NodeLabel', [],'LineWidth',1,'NodeColor','#1E90FF','EdgeColor','k','MarkerSize',14,'EdgeLabel',Graph.Edges.Weight);
text(h.XData,h.YData,nodes_names,'fontsize',8, 'FontWeight','bold', 'HorizontalAlignment','center', 'VerticalAlignment','middle','Interpreter','none','Rotation',0);

end
