% DRIVEMODEDXL Changes the drive mode of connected Dynamixel motors
% 
%   DRIVEMODEDXL(lib_name, port_num, protocol_version, ids, models, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   connection port number (port_num), the procotol version
%   (protocol_version), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in vector format
%   (models), and the string vector including the drive mode for each
%   connected Dynamixel motor (select).
%   
%   Two drive modes are supported for each element of (select):
%       'Velocity-based Profile', and 
%       'Time-based Profile'
%   For more information on Dynamixel drive modes, please refer to the
%   ROBOTIS page of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function driveModeDxl(lib_name, port_num, protocol_version, ids, models, select)

    [start_address, ~] = lookupDxl('Drive Mode', models);

    fprintf("Drive mode changed to '%s' for motor IDs: ", select)

    for index = 1:length(ids)  
        switch select
            case 'Velocity-based Profile'
                data = 0;
            case 'Time-based Profile'
                data = 4;
            otherwise
                fprintf("Unknown drive mode\n")
        end
        calllib(lib_name,'write1ByteTxRx',port_num, protocol_version, ...
            ids(index), start_address(index), data)
        fprintf("%d ",ids(index))
    end
    fprintf("\n\n")
    
end