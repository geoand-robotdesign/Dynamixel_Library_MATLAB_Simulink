% CHECKERRORDXL Checks for communication errors and returns the
%               communication status of connected Dynamixel motors
%
%   CHECKERRORDXL(lib_name, port_num, protocol_version)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   connection port number (port_num) and the protocol version
%   (protocol_version) of the connected Dynamixel motors
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function checkErrorDxl(lib_name, port_num, protocol_version)

    % Check the communication status of connected Dynamixel motors
    comm_status = calllib(lib_name, 'getLastTxRxResult', port_num, protocol_version);
    comm_status = calllib(lib_name, 'getTxRxResult', protocol_version, comm_status);
    fprintf('%s\n', comm_status)
    
    % Check for communication errors
    error = calllib(lib_name,'getLastRxPacketError', port_num, protocol_version);
    error = calllib(lib_name,'getRxPacketError', protocol_version, error);
    
    switch isempty(error)
        case 1
            fprintf("No error found.\n\n")
        case 0
            fprintf(error)
    end

end