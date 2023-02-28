% INITBULKREADDXL Initializes the bulk read function for Dynamixel motors 
%   and returns the group numbers
% 
%   group_num_read = INITBULKREADDXL(lib_name, port_num, protocol_version)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   port number (port_num), and the protocol version of the connected 
%   Dynamixel motors (protocol_version).
%   INITBULKREADDXL returns the group read numbers (group_num_read)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function group_num_read = initBulkReadDxl(lib_name, port_num, ...
    protocol_version)

    group_num_read = calllib(lib_name, 'groupBulkRead', port_num, ...
        protocol_version);

end