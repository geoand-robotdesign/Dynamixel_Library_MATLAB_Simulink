% READWRITE Example file executing read and write functions for 1 or more 
% Dynamixel motors under Protocol 2.0 communication.
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

% Enable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, ...
    motor_models, 'Enable');

% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

%% Example
clc 

% Data to write
data = 2000; % Example goal position for one motor
% data = [2000 1000]; % Example goal position for two motors

% Write function
tic
writeDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    data, 'Goal Position')
toc

% Read functions
tic
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Position')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Velocity')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Current/Load')
readDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Present Temperature')
toc
%% End Session
clc 

% Disable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Disable');

% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

% Close port 
closePortDxl(lib_name,port_num);