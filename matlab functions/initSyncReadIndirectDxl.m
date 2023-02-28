% INITSYNCREADINDIRECTDXL Initializes the sync read function using indirect
%    addresses of Dynamixel motors and returns the group numbers
% 
%   group_num_read = INITSYNCREADINDIRECTDXL(lib_name, port_num, protocol_version, models, indirect_data_start, indirect_data_length)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   port number (port_num), the protocol version of the connected 
%   Dynamixel motors (protocol_version), the models of the connected 
%   dynamixels in vector format (models), the indirect data start address 
%   (indirect_data_start) and the indirect data length
%   (indirect_data_length).
%   INITSYNCREADINDIRECTDXL returns the group read numbers (group_num_read)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function group_num_read = initSyncReadIndirectDxl(lib_name, port_num, ...
    protocol_version, models, indirect_data_start, indirect_data_length)

    [start_address, ~] = lookupDxl(indirect_data_start, models);
    
    group_num_read = calllib(lib_name, 'groupSyncRead', port_num, ...
        protocol_version, start_address(1), indirect_data_length(1)); %fix

end