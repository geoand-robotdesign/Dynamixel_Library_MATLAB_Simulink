% SYNCREADSYNCWRITE Example file initializing the execution of sync read 
%   and write for 1 or more Dynamixel motors in Simulink
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

clear
close all
clc

% Set sampling time for Simulink pace execution
Ts = 0.005;

% Set COM port
com_port = 'COM5';

% Set baudrate
baud_rate = 4000000;

% Set protocol Version
protocol_version = 2;

% Initialize library and port number
[lib_name, port_num] = initDxl(com_port);

% Open port
openPortDxl(lib_name, port_num);

% Set Baudrate
setBaudDxl(lib_name, port_num, baud_rate);

% Find dynamixels
[motor_IDs, motor_models] = findDxl(lib_name, port_num, protocol_version);

% Operating modes
operatingModeDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, 'Extended Position Control');

% Drive modes
driveModeDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, 'Velocity-based Profile');

% Enable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, 'Enable');

% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

% Initialize sync write
group_num_write = initSyncWriteDxl(lib_name, port_num, protocol_version,...
    motor_models, ["Goal Position"; "Goal Velocity"]);

% Initialize sync read
group_num_read = initSyncReadDxl(lib_name, port_num, protocol_version,...
    motor_models, ["Present Position"; "Present Velocity"; ...
    "Present Current/Load"; "Present Temperature"]);

% Read add parameters
syncReadAddParamDxl(lib_name, group_num_read, motor_IDs);

fprintf("Initializing Simulink file...\n\n");  
% open("SyncReadSyncWrite_1Motor.slx");
% open("SyncReadSyncWrite_2Motors.slx");
fprintf("No Simulink file selected. Please uncomment the file " + ...
    "you want to open. \nDisregard this message if you plan to open " + ...
    "the Simulink file manually. \n\n");

%% End Session
clc 

% Read clear parameters
syncReadClearParamDxl(lib_name, group_num_read);

% Disable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, 'Disable');

% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

% Close port 
closePortDxl(lib_name,port_num);

clear