% INITSYNCWRITEINDIRECTDXL Initializes the sync write function using indirect
%    addresses of Dynamixel motors and returns the group numbers
% 
%   group_num_read = INITSYNCWRITEINDIRECTDXL(lib_name, port_num, protocol_version, models, indirect_data_start, indirect_data_length)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   port number (port_num), the protocol version of the connected 
%   Dynamixel motors (protocol_version), the models of the connected 
%   dynamixels in vector format (models), the indirect data start address 
%   (indirect_data_start) and the indirect data length
%   (indirect_data_length).
%   INITSYNCWRITEINDIRECTDXL returns the group write numbers (group_num_write)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function group_num_write = initSyncWriteIndirectDxl(lib_name, port_num, ...
    protocol_version, models, indirect_data_start, indirect_data_length)

    indirect_data_start = "Indirect Data "...
        + num2str(indirect_data_start);
    indirect_data_start = char(indirect_data_start);
    [start_address, ~] = lookupDxl(indirect_data_start, models);
    
    group_num_write = calllib(lib_name, 'groupSyncWrite', port_num, ...
        protocol_version, start_address(1), indirect_data_length); %fix

end