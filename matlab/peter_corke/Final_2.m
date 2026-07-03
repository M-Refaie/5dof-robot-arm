% Clear workspace and command window
clc;
clear;
close all;

% Define the DH parameters
theta = [0, 0, 0, 0, 0]; % Initial joint angles (in radians)

% Create the links using the standard DH convention
L(1) = Link([theta(1), 65, 277, deg2rad(90)], 'standard'); % Joint 1
L(2) = Link([theta(2), -37.5, 192, deg2rad(0)], 'standard'); % Joint 2
L(3) = Link([theta(3), 17.5, 172, deg2rad(-90)], 'standard'); % Joint 3
L(4) = Link([theta(4), 0, 62.5, deg2rad(90)], 'standard'); % Joint 4
L(5) = Link([theta(5), 0, 45, deg2rad(0)], 'standard'); % Joint 5

% Create the robot using the SerialLink class
robot = SerialLink(L, 'name', 'MyRobot');

% Display the robot configuration (optional)
robot.plot([0, 0, 0, 0, 0]);

% Desired end-effector poses (example) - include both position and orientation
R = rpy2tr(1, 1, 1);  % Desired rotation (adjust roll, pitch, yaw as needed)
T_desired_all = { ...
    transl(3, 2, 180) * R, ...  % Target position with desired rotation
    transl(15, 2, 40) * R, ...
    transl(30, 20, 90) * R, ...
    transl(4, 100, 20) * R};  % Target position with desired rotation

% Mask matrix (solve for position and orientation)
mask = [1, 1, 1, 0, 0, 1];  % Solve for x, y, z position and roll/pitch/yaw orientation

% Provide a better initial guess for joint angles (optional)
q_start = [0, 0, 0, 0, 0];  % Adjust if needed, or use robot.getpos()

% Visualize the target poses (mark them with different colors)
robot.plot(q_start);
hold on;
colors = ['r', 'b', 'g', 'k'];  % Colors for each target
for i = 1:length(T_desired_all)
    plot3(T_desired_all{i}(1, 4), T_desired_all{i}(2, 4), T_desired_all{i}(3, 4), [colors(i), 'o']);  % Mark the target positions with different colors
end

% Iterate through all desired poses and solve inverse kinematics for each
n_steps = 50;  % Number of steps for the motion
for i = 1:length(T_desired_all)
    T_current_desired = T_desired_all{i};

    % Solve inverse kinematics to get joint angles for the target pose
    options = struct('maxiter', 2000, 'tol', 1e-4);  % Increase iterations and adjust tolerance
    q_target = robot.ikine(T_current_desired, 'mask', mask, options);

    % Check if the IK solver found a valid solution
    if isempty(q_target)
        disp(['IK solver failed to find a solution for target ', num2str(i), '.']);
        continue;  % Skip this iteration if no solution is found
    end

    disp(['Calculated joint angles (radians) for target ', num2str(i), ':']);
    disp(q_target);

    % Calculate the Forward Kinematics (FK) for the calculated joint angles
    T_fk = robot.fkine(q_target);

    % Check if T_fk and T_desired are 4x4 matrices
    if size(T_fk, 1) == 4 && size(T_fk, 2) == 4 && size(T_current_desired, 1) == 4 && size(T_current_desired, 2) == 4
        % Display Forward Kinematics result
        disp('Forward Kinematics result (end-effector transformation):');
        disp(T_fk);

        % Calculate the error between the target and actual position
        error_position = norm(T_fk(1:3, 4) - T_current_desired(1:3, 4));  % Position error (x, y, z)
        error_orientation = norm(T_fk(1:3, 1:3) - T_current_desired(1:3, 1:3), 'fro');  % Orientation error (rotation matrix)

        disp(['Error in position for target ', num2str(i), ': ', num2str(error_position)]);
        disp(['Error in orientation for target ', num2str(i), ': ', num2str(error_orientation)]);
    else
        disp(['Error: T_fk or T_desired for target ', num2str(i), ' is not a 4x4 matrix.']);
        disp('T_fk:');
        disp(T_fk);
        disp('T_desired:');
        disp(T_current_desired);
    end

    % Interpolate joint angles for smooth motion (using linear interpolation)
    q_trajectory = zeros(n_steps, 5);
    end_effector_trajectory = zeros(n_steps, 3);
    for j = 1:n_steps
        q_trajectory(j, :) = q_start + (q_target - q_start) * (j - 1) / (n_steps - 1);

        % Calculate the end-effector position for the current joint angles
        T_current = robot.fkine(q_trajectory(j, :));  % Current transformation matrix

        % Check if T_current is a SE3 object (and extract position)
        if isa(T_current, 'SE3')
            end_effector_trajectory(j, :) = T_current.t';  % Extract position (x, y, z)
        else
            end_effector_trajectory(j, :) = T_current(1:3, 4)';  % Extract position (x, y, z)
        end

        % Visualize the robot in the current configuration
        robot.plot(q_trajectory(j, :));
        pause(0.1); % Pause for smooth animation
    end

    % Final visualization of the robot in the target configuration
    robot.plot(q_target);

    % Plot the end-effector trajectory
    figure;
    plot3(end_effector_trajectory(:, 1), end_effector_trajectory(:, 2), end_effector_trajectory(:, 3), '-o', 'LineWidth', 2);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title(['End-Effector Trajectory for Target ', num2str(i)]);
    grid on;
    axis equal;
end
