function [ value , isterminal , direction ] = ...
    foxrab (t,z, mindist , xburrow)

% Get rabbit coordinates
rab=[z(3) z(4)];

% Event function

% Stop when distance between the rabbit and the fox is less than 'mindist'.
% Stop solver when 'value' equals zero.
value (1) = sqrt((rab(1)-z(1))^2+(rab(2)-z(2))^2)-mindist;
% Stop when the minimal distance is reached.
isterminal (1) = 1;
% Event is triggered when 'value' changes from positive to negative.
direction (1) = -1;

% Stop solver when distance between the x coordinate of rabbit and
% x coordinate of burrow equals zero
value (2) = rab (1) - xburrow;
isterminal (2) = 1;
direction (2) = -1;
end
