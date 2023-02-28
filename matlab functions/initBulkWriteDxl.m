% INITBULKWRITEDXL Initializes the bulk write function for Dynamixel motors 
%   and returns the group write number
% 
%   group_num_write = INITBULKWRITEDXL(lib_name, port_num, protocol_version)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   port number (port_num), and the protocol version of the connected 
%   Dynamixel motors (protocol_version).
%   INITBULKWRITEDXL returns the group write numbers (group_num_write)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function group_num_write = initBulkWriteDxl(lib_name, port_num, ...
    protocol_version)

    group_num_write = calllib(lib_name, 'groupBulkWrite', port_num, ...
        protocol_version);

end