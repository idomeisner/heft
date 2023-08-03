function plotScheduleGraph(ScheduleDB,add_legend)
% Print the scheduled DAG graph

Graph = ScheduleDB.Graph;
nodes_names = ScheduleDB.Graph.Nodes.Name; % nodes names
assigned_proc = ScheduleDB.NodeSchedule.Processor; % which processor each node received
processors = ScheduleDB.Processors; % number of processors
cycles = ScheduleDB.Cycles;    % number of cycles
cmap = getColors(processors);  % colors for the nodes

% Get bar names
[proc_names] = processorsNames(processors);

% Plot the graph
h = plot(Graph,'Layout','layered','NodeLabel', [],'LineWidth',1,'EdgeColor','k','MarkerSize',14);


% Add names to the nodes
text(h.XData,h.YData,nodes_names,'fontsize',8, 'FontWeight','bold', 'HorizontalAlignment','center', 'VerticalAlignment','middle','Interpreter','none','Rotation',0);

% Color the nodes with the match processor color
for i=1:processors
    nodes_in_proc = find(assigned_proc == i);
    highlight(h,nodes_in_proc,'NodeColor',cmap(i,:));
end
hold on;

% Add legend to the graph
if add_legend
    ax = plot(NaN,NaN,'r','Linestyle','none','Marker','none','Color','none','DisplayName',['cycles = ',num2str(cycles)]);
    for i=1:processors
        ax(i+1) = plot(NaN,NaN,'Linestyle','none','marker','o','MarkerEdgeColor',cmap(i,:),'MarkerFaceColor',cmap(i,:),'MarkerSize',5,'DisplayName',proc_names{i});
    end

    lgnd = legend(ax);
    set(lgnd,'FontSize',10);
end

% Add title to the graph
title('DAG Partition Graph');
hold off;
    
end
