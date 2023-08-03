function plotSchedule(ScheduleDB, separate_figures)
% Prints the processors schedule graph and the DAG graph
%
% separate_figures - boolean - if true, plot the result in the same figure,
%                              if false, plot the result in separate figures

if nargin == 1
    separate_figures = 1;
end

processors = ScheduleDB.Processors;
cycles = ScheduleDB.Cycles;

% Print the processors schedule graph and the DAG graph in the same figure
if ~separate_figures
    
    f = figure('Name','Schedule','NumberTitle','off');
    p = uipanel('Parent',f,'BorderType','none');

    if processors ~= 1, plural = 's'; else, plural = ''; end
    p.Title = ['Scheduling for ',num2str(processors),' processor',plural, ', cycles=',num2str(cycles)];
    p.TitlePosition = 'centertop'; 
    p.FontSize = 12;
    p.FontWeight = 'bold';
    subplot(1,2,1,'Parent',p);
    plotScheduleBar(ScheduleDB.NodeSchedule, processors);    
    subplot(1,2,2,'Parent',p);
    plotScheduleGraph(ScheduleDB,separate_figures);
    
% Print the Bar graph and the DAG graph in separate figures
else
    figure('Name','Tasks Schedule','NumberTitle','off');
    plotScheduleBar(ScheduleDB.NodeSchedule, ScheduleDB.Processors);
    figure('Name','Scheduled DAG','NumberTitle','off');
    plotScheduleGraph(ScheduleDB,separate_figures);
end

end
