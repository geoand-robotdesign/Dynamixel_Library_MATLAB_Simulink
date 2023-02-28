% FASTSYNCWRITEDXL Executes fast sync write for Dynamixel motors
% 
%   FASTSYNCWRITEDXL(lib_name, group_num_write, ids, models, data_write, select_sync_write)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group write number (group_num_write), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the vector including the data to write (data_write), and
%   the string vector containing the selector for the write parameters
%   (select_sync_write).
%
%   For more information on fast sync read, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function fastSyncWriteDxl(lib_name, group_num_write, ids, models, ...
    data_write, select_sync_write)

    for idx = 1 : length(select_sync_write)
        [~, data_length] = lookupDxl(select_sync_write(idx), models);
        for index = 1:length(ids)
            calllib(lib_name, 'groupSyncWriteAddParam', group_num_write,...
                ids(index), data_write(idx,index), data_length(index));
        end
    end
    calllib(lib_name, 'groupSyncWriteTxPacket', group_num_write);
    calllib(lib_name, 'groupSyncWriteClearParam', group_num_write);
   
end