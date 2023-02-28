% OPENPORTDXL Opens port for communication with Dynamixel motors
% 
%   OPENPORTDXL(lib_name, port_num)
%   uses the name of the C library for Dynamixels (lib_name) and the 
%   port number (port_num).
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function openPortDxl(lib_name, port_num)
    
    % Open port
    switch (calllib(lib_name, 'openPort', port_num))
        case 1
            fprintf('Port opened successfully. \n\n');
        case 0
            fprintf('Error opening the port. \n\n');
    end
    
end