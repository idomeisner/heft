function [procs_names] = processorsNames(num_of_procs)
% Returns a cell array of the processors names

procs_names = strcat('Processor',{' '},num2str((1:num_of_procs)'));

end
