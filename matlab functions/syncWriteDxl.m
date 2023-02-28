% SYNCWRITEDXL Executes sync write for Dynamixel motors and returns the 
%   acquired data
% 
%   SYNCWRITEDXL(lib_name, group_num, ids, models, data_write, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the data to write in vector format (data_write) and the string 
%   vector including the parameter for sync write function (select)
%
%   For more information on sync write, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function syncWriteDxl(lib_name, group_num, ids, models, data_write, select)

    [~, data_length] = lookupDxl(select, models);
    for index = 1:length(ids)
        calllib(lib_name, 'groupSyncWriteAddParam', group_num, ...
            ids(index), data_write(index), data_length(index)); %fix
    end
    calllib(lib_name, 'groupSyncWriteTxPacket', group_num);
    calllib(lib_name, 'groupSyncWriteClearParam', group_num);

end
