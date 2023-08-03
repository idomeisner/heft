function printCostTable(cost)
% Prints the computation cost table

cost_table = array2table(cost,'VariableNames',processorsNames(size(cost,2)));
tasks_table = table((1:size(cost_table, 1))','VariableNames',{'Task'});

fig = uifigure('Name','Cost Table','NumberTitle','off');
uitable(fig, 'Data', [tasks_table cost_table], 'units', 'Normalized', 'Position', [0.02 0.04 0.96 0.92]);

end
