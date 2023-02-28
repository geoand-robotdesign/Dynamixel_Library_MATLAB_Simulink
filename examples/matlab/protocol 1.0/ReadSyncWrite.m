% READSYNCWRITE Example file executing read and sync write functions for 1 
% or more Dynamixel motors under Protocol 1.0 communication
%
% Depending on the example code, the motor(s) need to be pre-set to joint 
% or wheel mode via the Dynamixel Wizard or equivalent software
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
baud_rate = 1000000;

% Set protocol Version
protocol_version = 1;

% Initialize library and port number
[lib_name, port_num] = initDxl(com_port);

% Open port
openPortDxl(lib_name, port_num);

% Set Baudrate
setBaudDxl(lib_name, port_num, baud_rate);

% Find dynamixels
[motor_IDs, motor_models] = findDxl(lib_name, port_num, protocol_version);

% Enable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, 'Enable');

% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

% Initialize sync write
group_num_write = initSyncWriteDxl(lib_name, port_num, protocol_version,...
    motor_models, ["Goal Position"; "Moving Speed"]);

%% Joint Mode Example
clc
% Data to write
data = 500; % Example goal position for one motor
% data = [1000 2000]; % Example goal position for two motors

% Sync write function
tic
syncWriteDxl(lib_name, group_num_write(1), motor_IDs, motor_models, ...
    data, 'Goal Position')
toc

% Read functions
tic
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Position')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Speed')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Load')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Temperature')
toc

%% Wheel Mode Example
clc
% Data to write
data = 500; % Example moving speed for one motor
% data = [400 300]; % Example moving speeds for two motors

% Sync write function
tic
syncWriteDxl(lib_name, group_num_write(2), motor_IDs, motor_models, ...
    data, 'Moving Speed')
toc

% Read functions
tic
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Position')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Speed')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Load')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Temperature')
toc
%% End Session
clc 

% Disable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, 'Disable');

% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

% Close port 
closePortDxl(lib_name,port_num);