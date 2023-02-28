% INITSYNCREADDXL Initializes the sync read function for Dynamixel motors
%   and returns the group numbers
% 
%   group_num_read = INITSYNCREADDXL(lib_name, port_num, protocol_version, models, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   port number (port_num), the protocol version of the connected 
%   Dynamixel motors (protocol_version), the models of the connected 
%   dynamixels in vector format (models), and the string vector including 
%   the parameter for bulk read function for the connected Dynamixel motors (select).
%   INITSYNCREADDXL returns the group read numbers (group_num_read)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function group_num_read = initSyncReadDxl(lib_name, port_num, ...
    protocol_version, models, select)

    group_num_read = zeros(size(select));
    for index = 1:length(select)
        [start_address, data_length] = lookupDxl(select{index}, models);
        group_num = calllib(lib_name, 'groupSyncRead', port_num, ...
            protocol_version, start_address(1), data_length(1)); %fix
        group_num_read(index) = group_num;
    end
end