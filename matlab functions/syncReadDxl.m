% SYNCREADDXL Executes sync read for Dynamixel motors and returns the 
%   acquired data
% 
%   read_data = SYNCREADDXL(lib_name, group_num, ids, models, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the string vector including the parameter for sync read
%   function (select)
%   SYNCREADDXL returns the selected read data (read_data)
%
%   For more information on sync read, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function read_data = syncReadDxl(lib_name, group_num, ids, models, select)

    read_data = zeros(size(ids));
    [start_address, data_length] = lookupDxl(select, models);

    %TxRxPacket
    calllib(lib_name, 'groupSyncReadTxRxPacket', group_num);

    %IsAvailable
    for index = 1:length(ids)
        calllib(lib_name, 'groupSyncReadIsAvailable', group_num, ...
            ids(index), start_address(index), data_length(index)); %fix
    end
    
    %GetData
    for index = 1:length(ids)
        data = calllib(lib_name, 'groupSyncReadGetData', group_num, ...
            ids(index), start_address(index), data_length(index)); %fix
        read_data(index) = data;
    end

end
