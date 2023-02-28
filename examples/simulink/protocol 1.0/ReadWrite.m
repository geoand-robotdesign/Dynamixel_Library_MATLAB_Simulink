% READWRITE Example file executing read and write functions for 1 or more 
% Dynamixel motors under Protocol 1.0 communication
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

% Set sampling time for Simulink pace execution
Ts = 0.01;

% Set COM port
com_port = 'COM5';

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

fprintf("Initializing Simulink file...\n\n");
% open("ReadWrite_1Motor.slx");
% open("ReadWrite_2Motors.slx");
fprintf("No Simulink file selected. Please uncomment the file " + ...
    "you want to open. \nDisregard this message if you plan to open " + ...
    "the Simulink file manually. \n\n");

%% End Session
clc 

% Disable torque
torqueDxl(lib_name, port_num, protocol_version, motor_IDs, motor_models, ...
    'Disable');

% Check error
checkErrorDxl(lib_name, port_num, protocol_version)

% Close port 
closePortDxl(lib_name,port_num);