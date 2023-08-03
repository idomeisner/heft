function plotScheduleBar(nodes_schedule, processors)
% Print the processors' schedule in a bar graph

% Get a unique color for each processor
cmap = getColors(processors);

% Get bar names for the bar plot
bars_names = categorical(processorsNames(processors));

for i=1:processors
    bar_name = bars_names(i);
    [cycles,nodes_names] = getNodesData(nodes_schedule(nodes_schedule.Processor == i,:));

	b = bar(bar_name,cycles,'stacked');
    hold on;

    bar_color = cmap(i,:);

    % Paint the tasks
    for j=1:length(cycles)
        if strcmp(nodes_names{j},'')
            b(j).FaceAlpha = 0;
            b(j).EdgeAlpha = 0;
        else
            b(j).FaceColor = bar_color;
        end
    end
    
    % Add name to each task in the bar graph
    bars_base = cumsum([0 cycles(1:end-1)]);
    jobs_pos = cycles/2 + bars_base;
    text(i*ones(size(cycles)), jobs_pos, nodes_names, 'HorizontalAlignment','center','Interpreter','none');
end

set(gca, 'YGrid', 'on','GridLineStyle','--');

if processors ~= 1, plural = 's'; else, plural = ''; end
title(['Processor',plural,' Scheduling'])

ylabel('Cycle'); % y-axis label
hold off;

end

function [cycles,names] = getNodesData(proc_sched)
% Return the number of cycles required for each node and the node name

proc_sched = sortrows(proc_sched, 'EST');
end_time = 0;
cycles = [];
names = cell(0);
EST = proc_sched.EST;
EFT = proc_sched.EFT;

for i=1:size(proc_sched,1)
    if proc_sched.EST(i) - end_time > 1
        cycles(end+1) = EST(i) - end_time - 1;
        names(end+1) = {''};
    end

    cycles(end+1) = EFT(i) - EST(i) + 1;
    names(end+1) = {proc_sched.NodeName(i)};
    end_time = EFT(i);
end

end
