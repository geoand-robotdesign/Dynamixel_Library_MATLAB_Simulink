% SYNCREADCLEARPARAMDXL Clears parameters for bulk read function of Dynamixel motors
% 
%   SYNCREADCLEARPARAMDXL(lib_name, group_num)
%   uses the name of the C library for Dynamixels (lib_name), and the 
%   group read number (group_num)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function syncReadClearParamDxl(lib_name, group_num)
    
    for indx = 1 : length(group_num)
        calllib(lib_name, 'groupSyncReadClearParam', group_num(indx));
    end

end