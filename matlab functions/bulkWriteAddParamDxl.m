% BULKWRITEADDPARAMDXL Adds parameters for bulk write function of Dynamixel 
%   motors
% 
%   BULKWRITEADDPARAMDXL(lib_name, group_num, ids, models, data, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), the IDs of the connected dynamixels in 
%   vector format (ids), the models of the connected dynamixels in vector 
%   format (models), the data to be written in vector format (data) and the 
%   string vector including the parameter for bulk write function for the
%   connected Dynamixel motors (select).
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function bulkWriteAddParamDxl(lib_name, group_num, ids, models, data, select)

    [start_address, data_length] = lookupDxl(select, models);
    input_length = data_length;

    for index = 1:length(ids)
        calllib(lib_name,'groupBulkWriteAddParam', group_num, ids(index),...
            start_address, data_length, data, input_length);
    end
    
end