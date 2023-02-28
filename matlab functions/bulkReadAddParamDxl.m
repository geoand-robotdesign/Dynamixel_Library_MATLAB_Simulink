% BULKREADADDPARAMDXL Adds parameters for bulk read function of Dynamixel motors
% 
%   BULKREADADDPARAMDXL(lib_name, group_num, ids, models, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in vector format
%   (models), and the string vector including the parameter for bulk read
%   function for the connected Dynamixel motors (select).
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function bulkReadAddParamDxl(lib_name, group_num, ids, models, select)

    [start_address, data_length] = lookupDxl(select{index}, models);
    
    for index = 1:length(ids)
        calllib(lib_name,'groupBulkReadAddParam', group_num, ...
            ids(index), start_address, data_length);
    end
    
end