% CLOSEPORTDXL Closes communication port with connected Dynamixel motors
% 
%   CLOSEPORTDXL(lib_name, port_num)
%   uses the name of the C library for Dynamixels (lib_name) and the 
%   connection port number (port_num)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function closePortDxl(lib_name, port_num)

    % Close port
    calllib(lib_name, 'closePort', port_num);
    fprintf("Port closed successfully.\n\n");
    
    % Unload library
    unloadlibrary(lib_name);
    fprintf("Library unloaded successfully.\n\n");

end