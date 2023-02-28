% SYNCREADADDPARAMDXL Add parameter for bulk read function of Dynamixel motors
% 
%   SYNCREADADDPARAMDXL(lib_name, group_num, ids)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), and the IDs of the connected dynamixels in vector
%   format (ids)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function syncReadAddParamDxl(lib_name, group_num, ids)

    for indx = 1 : length(group_num)
        for index = 1:length(ids)
            calllib(lib_name,'groupSyncReadAddParam', group_num(indx), ids(index));
        end
    end
    
end