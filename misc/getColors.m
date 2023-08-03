function [cmap] = getColors(n)
% Returns n different colors in RGB format

cmap = hsv(n+2);
cmap = cmap(2:n+1,:);

end
