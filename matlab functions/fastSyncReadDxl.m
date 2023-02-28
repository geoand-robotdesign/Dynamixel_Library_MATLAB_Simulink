% FASTSYNCREADDXL Executes fast sync read for Dynamixel motors and returns
%   the selected read parameter
% 
%   read_data = FASTSYNCREADDXL(lib_name, group_num_read, ids, models, select_sync_read, start_address_read_indirect)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num_read), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the string vector including the parameter for sync read
%   function (select_sync_read) and the start indirect address (start_address_read_indirect)
%   FASTSYNCREADDXL returns the selected read data (read_data)
%
%   For more information on fast sync read, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function read_data = fastSyncReadDxl(lib_name, group_num_read, ids, ...
    models, select_sync_read, start_address_read_indirect)

    read_data = zeros(length(select_sync_read), length(ids));
    [start_address, ~] = lookupDxl(start_address_read_indirect, models);
    data_length = 0;
    
    % Sync read packet from indirect data
    calllib(lib_name, 'groupSyncReadTxRxPacket', group_num_read);
    
    for idx = 1 : length(select_sync_read)
        start_address = start_address + data_length;
        [~, data_length] = lookupDxl(select_sync_read(idx), models);
        for index = 1:length(ids)
            %IsAvailable
            calllib(lib_name, 'groupSyncReadIsAvailable', group_num_read,...
                ids(index), start_address(index), data_length(index));
            %GetData
            data = calllib(lib_name, 'groupSyncReadGetData', group_num_read,...
                ids(index), start_address(index), data_length(index));
            read_data(idx,index) = data;
        end
    end

end