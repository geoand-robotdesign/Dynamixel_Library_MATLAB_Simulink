% READDXL Executes read for Dynamixel motors and returns the acquired 
%   data
% 
%   read_data = READDXL(lib_name, port_num, protocol_version, ids, models, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), the IDs of the connected dynamixels in 
%   vector format (ids), the models of the connected dynamixels in vector format
%   (models), and the string vector including the read parameter for
%   the connected Dynamixel motors (select)
%   READDXL returns the acquired data (read_data)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function read_data = readDxl(lib_name, port_num, protocol_version, ids, ...
    models, select)

    read_data = zeros(size(ids));
    [start_address, data_length] = lookupDxl(select, models);
    
    switch data_length(1) %fix
        case 1
            func = 'read1ByteTxRx';
        case 2
            func = 'read2ByteTxRx';
        case 4
            func = 'read4ByteTxRx';
    end

    for index = 1:length(ids)
        data = calllib(lib_name, func, port_num, protocol_version, ...
            ids(index), start_address(index)); %fix
        read_data(index) = data;
    end

end
