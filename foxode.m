function dzdt = foxode (t,z,sr,sf,A,E,mue_r,mue_f,radius)

% Make sure the output is a column vector.
dzdt = zeros(7,1) ;
% Calculate angular velocity of rabbit
theta = (sr/radius)*exp(-mue_r*z(7));

dzdt(3) = -radius*theta*cos(z(6));   % Rabbit (decreasing) horizontal velocity.
dzdt(4) = -radius*theta*sin(z(6));   % Rabbit (decreasing) vertical velocity.
dzdt(5) = sf*exp(-mue_f*z(5));       % Fox (decreasing) speed.
dzdt(6) = theta;
dzdt(7) = sqrt(dzdt(3)^2+dzdt(4)^2); % Distance travelled by rabbit


% Check if fox's line of sight is blocked by AE fence.
% Use line-line intersection from Euclidean Geometry to calculate.
RF1=[z(3) z(4)];    % x1,y1
RF2=[z(1) z(2)];    % x2,y2
% A is x3,y3
% E is x4,y4

% x coordinate of intersection point.
pointx= ((RF1(1)*RF2(2)-RF1(2)*RF2(1))*(A(1)-E(1)) - (RF1(1)-RF2(1))*(A(1)*E(2)-A(2)*E(1))) ...
    / ((RF1(1)-RF2(1))*(A(2)-E(2)) - (RF1(2)-RF2(2))*(A(1)-E(1)));
% y coordinate of intersection point.
pointy= ((RF1(1)*RF2(2)-RF1(2)*RF2(1))*(A(2)-E(2)) - (RF1(2)-RF2(2))*(A(1)*E(2)-A(2)*E(1))) ...
    / ((RF1(1)-RF2(1))*(A(2)-E(2)) - (RF1(2)-RF2(2))*(A(1)-E(1)));

% If the fox has not reached point G, fox runs towards point G
if z(2)<=300
    dzdt(1)=0;
    dzdt(2)=dzdt(5);

%If there is an intersection, fox runs towards point A on fence.
elseif pointx>E(1) && pointx<A(1) && pointy>E(2) && pointy<A(2)
    newDist = sqrt((A(1)-z(1))^2 + (A(2)-z(2))^2) ; % Distance between fox and point A
    dzdt (1) = dzdt(5) *( A (1) -z (1) )/ newDist ; % Fox horizontal velocity
    dzdt (2) = dzdt(5) *( A (2) -z (2) )/ newDist ; % Fox vertical velocity

%Otherwise fox runs towards rabbit
else
    dist = sqrt((z(3)-z(1))^2 + (z(4)-z(2))^2) ; % Distance between fox and rabbit
    dzdt (1) = dzdt(5) *( z (3) -z (1) )/ dist ;
    dzdt (2) = dzdt(5) *( z (4) -z (2) )/ dist ; 

end
end
