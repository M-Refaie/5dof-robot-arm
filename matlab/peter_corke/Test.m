% Clear workspace and command window
clc;
clear;
close all;

% Define the DH parameters
theta = [0, 0, 0, 0, 0]; % Initial joint angles (in radians)

% Create the links using the standard DH convention
 L(1) = Link([theta(1),   65,   277,  deg2rad(90)], 'standard'); % Joint 1
 L(2) = Link([theta(2), -37.5,  192,   deg2rad(0)], 'standard'); % Joint 2
 L(3) = Link([theta(3),  17.5,  172, deg2rad(-90)], 'standard'); % Joint 3
 L(4) = Link([theta(4),     0, 62.5,  deg2rad(90)], 'standard'); % Joint 4
 L(5) = Link([theta(5),     0,   45,   deg2rad(0)], 'standard'); % Joint 5
% Create the robot using the SerialLink class
robot = SerialLink(L, 'name', 'MMS');

% Display the robot configuration (optional)
robot.plot([0, 0, 0, 0, 0]);

% Desired end-effector pose (example)
T_desired = transl(0.5, 0.5, 0.2) * rpy2tr(pi/2, pi/4, 0);

% Mask matrix (only solving for position - x, y, z)
mask = [1, 1, 1, 0, 0, 0];  % Solve for x, y, z position only

% Solve inverse kinematics to get joint angles for the target pose
q_target = robot.ikine(T_desired, 'mask', mask);

% Display calculated joint angles
disp('Calculated joint angles (radians):');
disp(q_target);

% Calculate the Forward Kinematics (FK) for the calculated joint angles
T_fk = robot.fkine(q_target);

% Display Forward Kinematics result
disp('Forward Kinematics result (end-effector transformation):');
disp(T_fk);

% Number of steps for the motion
n_steps = 50;

% Initial joint angles (starting position)
q_start = [0, 0, 0, 0, 0];

% Create an array to store the joint angle trajectory
q_trajectory = zeros(n_steps, 5);

% Interpolate joint angles for smooth motion (using linear interpolation)
for i = 1:n_steps
    q_trajectory(i, :) = q_start + (q_target - q_start) * (i - 1) / (n_steps - 1);
    
    % Visualize the robot in the current configuration
    robot.plot(q_trajectory(i, :));
    pause(0.1); % Pause for smooth animation
end

% Final visualization of the robot in the target configuration
robot.plot(q_target);
