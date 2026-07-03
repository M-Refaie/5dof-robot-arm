% Specify the Excel file name
[filename, pathname] = uigetfile('*.xlsx', 'Select the Excel file');
if isequal(filename, 0)
    error('No file selected. Operation cancelled.');
end
fullpath = fullfile(pathname, filename);

% Read the data into a table
try
    T = readtable(fullpath);  % Use fullpath instead of just filename
catch ME
    error('Failed to read file: %s', ME.message);
end

% Display available columns (for debugging)
disp('Available columns in the file:');
disp(T.Properties.VariableNames);

% Check if 'Time' column exists
if ~ismember('Time', T.Properties.VariableNames)
    error('Error: "Time" column not found. Available columns: %s', ...
          strjoin(T.Properties.VariableNames, ', '));
end

% Convert 'Time' column to datetime if it's stored as text
if iscell(T.Time)
    try
        T.Time = datetime(T.Time, 'InputFormat', 'HH:mm:ss');
    catch
        warning('Could not convert Time to datetime. Using raw values.');
    end
end

% Check if X, Y, Z columns exist
requiredColumns = {'X', 'Y', 'Z'};
missingColumns = setdiff(requiredColumns, T.Properties.VariableNames);
if ~isempty(missingColumns)
    error('Missing required columns: %s', strjoin(missingColumns, ', '));
end

% Extract variables
time = T.Time;
x = T.X;
y = T.Y;
z = T.Z;

% Combine into XYZ matrix
xyz = [x, y, z].';
time= time.';

[numRows,numCols] = size(time);

% Display first 5 rows (to avoid flooding the console)
disp('First 5 Time values:'); 
disp(time(1:5));
disp('First 5 XYZ Coordinates:');
disp(xyz(1:3, :));