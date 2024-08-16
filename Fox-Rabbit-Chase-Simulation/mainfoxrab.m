question=1;
% Set mue value depending on question being answered.
if question==1
    mue_r=0;
    mue_f=0;
elseif question==2
    mue_r=0.0008;
    mue_f=0.0002;
end
% Initialise values
sr=12;                      % Rabbit (initial) speed
sf=17;                      % Fox (initial) speed
radius=800;                 % Radius of rabbit path
z0=[0 0 0 radius 0 0 0];    % Initial conditions for ode45
ts=[0 800*0.5*pi/sr];       % Time span to carry out ode45
mindist=0.1;                % Distance allowable for fox to catch rabbit
xburrow=-800*sin(pi/3);     % Burrow x coordinate
A=[-350 620];               % Point A on fence
E=[-500 350];               % Point E on fence

% Create event checker to check if rabbit is caught or reaches burrow.
options=odeset('RelTol',1e-6,'AbsTol',1e-6,'Events',@(t,z)foxrab(t,z,mindist,xburrow));
% Calculate ode, pass in necessary parameters.
[t,z,te,ze,zi]=ode45(@(t,z)foxode(t,z,sr,sf,A,E,mue_r,mue_f,radius),ts,z0,options);
% Output end time (for fox catching rabbit or rabbit reaching burrow),fox endpoint coordinates, fox distance travelled and event option that is triggered.
te,[ze(1) ze(2)],ze(5),zi

% Plot graph of path taken by rabbit and fox.
plot(z(:,1),z(:,2),z(:,3),z(:,4)), hold on
% Draw line of fence on plot
line([-350 -500],[620 350]), hold on
% Plot burrow point on plot
plot(-radius*sin(pi/3),radius*cos(pi/3),'.','MarkerFaceColor','Magenta'),hold on
%Show fox's endpoint
plot(z(end,1),z(end,2),'*'), hold on

axis equal, axis([-750 100 -100 900])
legend('Fox','Rabbit','Fence','Burrow','Fox Endpoint'), hold off
xlabel('x')
ylabel('y')