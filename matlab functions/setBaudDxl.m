% SETBAUDDXL Sets the baudrate of Dynamixel motor communication
% 
%   SETBAUDDXL(lib_name, port_num, baud_rate) uses the name of the C 
%   library for Dynamixels (lib_name), the port number (port_num), and the
%   baud rate for Dynamixel motor communication (baud_rate)
%
%   It is important that you set the baudrate at the same value as your
%   Dynamixel motor(s), otherwise communication will not be established. 
%   All connected motor(s) have to be set to the same baudrate.
%
%   For more information on supported baud rates please refer to the
%   ROBOTIS page of the utilized Dynamixel motors.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function setBaudDxl(lib_name, port_num, baud_rate)
    
    % Set port baudrate
    switch (calllib(lib_name, 'setBaudRate', port_num, baud_rate))
        case 1
        fprintf('Baudrate set to %d.\n\n', baud_rate); 
        case 0
        fprintf('Failed to set the baudrate\n\n');
    end
    
end