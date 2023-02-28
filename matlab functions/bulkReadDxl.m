% BULKREADDXL Returns the acquired data from bulk read function for the
%   connected Dynamixel motors
% 
%   read_data = BULKREADDXL(lib_name, group_num, ids, models, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), the IDs of the connected dynamixels in 
%   vector format (ids), the models of the connected dynamixels in vector format
%   (models), and the string vector including the bulk read parameter for
%   the connected Dynamixel motors (select)
%   BULKREADDXL returns the acquired data (read_data)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm


function read_data = bulkReadDxl(lib_name, group_num, ids, models, select)

    read_data = zeros(size(ids));
    [start_address, data_length] = lookupDxl(select, models);

    %IsAvailable
    for index = 1:length(ids)
        calllib(lib_name, 'groupBulkReadIsAvailable', group_num, ...
            ids(index), start_address, data_length);
    end

    %GetData
    for index = 1:length(ids)
        data = calllib(lib_name, 'groupBulkReadGetData', group_num, ...
            ids(index), start_address, data_length);
        read_data(index) = data;
    end

end
