% WRITEDXL Executes write for Dynamixel motors
% 
%   WRITEDXL(lib_name, port_num, protocol_version, ids, models, data_write, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the data to write (data_write) and the parameter for write function (select)
%
%   For more information on the write function, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm


function writeDxl(lib_name, port_num, protocol_version, ids, models, data_write, select)
    
    [start_address, data_length] = lookupDxl(select, models);
    
    for index = 1:length(ids)

        switch data_length(index)
        case 1
            func = 'write1ByteTxRx';
        case 2
            func = 'write2ByteTxRx';
        case 4
            func = 'write4ByteTxRx';
        end

        calllib(lib_name, func, port_num, protocol_version, ids(index), ...
            start_address(index), data_write(index)); %fix
    end

end
