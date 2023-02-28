% SETINDIRECTREADDXL Sets indirect addresses for enabling fast sync read 
%   for multiple Dynamixel motors
% 
%   [start_address_read_indirect, data_length_read_indirect] = ...
%     SETINDIRECTREADDXL(lib_name, port_num, protocol_version, ids, models, ...
%     start_address, select) 
%   uses the name of the C library for Dynamixels (lib_name), the 
%   port number (port_num), the protocol version of the connected 
%   Dynamixel motors (protocol_version), the IDs of the connected 
%   dynamixels in vector format (ids), the models of the connected 
%   dynamixels in vector format (models), the indirect data start address 
%   (start_address) and the string vector parameters for indirect read
%   SETINDIRECTREADDXL returns the indirect data start address 
%   (start_address_read_indirect) and the indirect data length
%   (data_length_read_indirect)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function [start_address_read_indirect, data_length_read_indirect] = ...
    setIndirectReadDxl(lib_name, port_num, protocol_version, ids, models, ...
    start_address, select)   

    data_length_read_indirect = 0;
    data_length_previous = start_address;
    start_address_read_indirect = "Indirect Data " + num2str(start_address);
    start_address_read_indirect = char(start_address_read_indirect);
    
    for idx = 1:length(select)
        [start_address, data_length] = lookupDxl(select(idx), models);      
        for index = 0 : (data_length-1)
            indirect_address = "Indirect Address " + num2str(index + ...
                data_length_previous);
            data_write = ones(size(ids)) * (start_address + index);
            writeDxl(lib_name, port_num, protocol_version, ids, models, ...
                data_write, indirect_address);
        end
        data_length_previous = index + data_length_previous + 1;
        data_length_read_indirect = data_length_read_indirect + data_length;
    end
    fprintf("Successfully assigned indirect data addresses for fast sync read\n\n");
end