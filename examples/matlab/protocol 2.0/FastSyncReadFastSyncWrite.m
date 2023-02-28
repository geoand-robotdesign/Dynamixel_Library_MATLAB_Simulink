% FASTSYNCREADFASTSYNCWRITE Example file executing fast sync read and fast 
% sync write functions for 2 Dynamixel motors under Protocol 2.0 
% communication and using indirect addresses.
%
% During the initialization phase, the motor(s) are set to 'Extended
% Position Control' operating mode, while their drive mode is set to
% 'Velocity-based Profile'.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

clear
close all
clc

% Set COM port
com_port = 'COM8';

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

% Set indirect addresses for sync write
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

%% Example
clc

% Goal positions for 2 motors
goal_positions = [1000 1000];

% LED state for 2 motors
LED = [0 0];

% Set write properties
data_write = [goal_positions; LED];

% Fast sync write to indirect data
tic
fastSyncWriteDxl(lib_name, group_num_write, motor_IDs, motor_models, ...
    data_write, select_sync_write)
toc

% Fast sync read from indirect data
tic
read_data = fastSyncReadDxl(lib_name, group_num_read, motor_IDs, ...
    motor_models, select_sync_read, start_address_read_indirect);
toc

present_positions = read_data(1,:)
present_velocities = read_data(2,:)
present_currents = read_data(3,:)
present_temperatures = read_data(4,:)


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