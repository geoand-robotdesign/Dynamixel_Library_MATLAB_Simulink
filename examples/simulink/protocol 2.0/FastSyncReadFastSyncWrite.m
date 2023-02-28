% FASTSYNCREADFASTSYNCWRITE Example file initializing the execution of sync read 
%   and write for 2 Dynamixel motors in Simulink
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

% Indirect addresses are accessible only when the torque is disabled
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, 'Disable');

% Define the read and write quantities
select_sync_write = ["Goal Position", "LED"];
select_sync_read = ["Present Position", "Present Velocity", ... 
    "Present Current/Load", "Present Temperature"];

% Set indirect addresses for fast sync write
[start_address_write_indirect, data_length_write_indirect] = ...
    setIndirectWriteDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, select_sync_write);

% Set indirect addresses for fast sync read
start_address_read_indirect = start_address_write_indirect + ...
    data_length_write_indirect;
[start_address_read_indirect, data_length_read_indirect] = ...
    setIndirectReadDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, start_address_read_indirect, select_sync_read);

% Enable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Enable');
% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

% Initialize sync write
group_num_write = initSyncWriteIndirectDxl(lib_name, port_num, protocol_version,...
    motor_models, start_address_write_indirect, data_length_write_indirect);

% Initialize sync read
group_num_read = initSyncReadIndirectDxl(lib_name, port_num, protocol_version,...
    motor_models, start_address_read_indirect, data_length_read_indirect);

% Add parameters for the sync read
syncReadAddParamDxl(lib_name, group_num_read, motor_IDs);

fprintf("Initializing Simulink file...\n\n");  
% open("FastSyncReadFastSyncWrite_2Motors.slx");
fprintf("No Simulink file selected. Please uncomment the file " + ...
    "you want to open. \nDisregard this message if you plan to open " + ...
    "the Simulink file manually. \n\n");

%% End Session
clc 

% Read clear parameters
syncReadClearParamDxl(lib_name, group_num_read);

% Disable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Disable');

% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

% Close port 
closePortDxl(lib_name,port_num);

clear