% BULKWRITEADDPARAMDXL Executes bulk write for Dynamixel motors
% 
%   BULKWRITEDXL(lib_name, group_num)
%   uses the name of the C library for Dynamixels (lib_name) and the 
%   group read number (group_num)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function bulkWriteDxl(lib_name, group_num)

    calllib(lib_name, 'groupBulkWriteTxPacket', group_num);
    calllib(lib_name, 'groupBulkWriteClearParam', group_num);

end
