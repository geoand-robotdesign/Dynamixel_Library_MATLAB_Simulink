% TORQUEDXL Enables or disables the torque to Dynamixel motors
% 
%   TORQUEDXL(lib_name, port_num, protocol_version, ids, models, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   port number (port_num), the protocol number of the connected Dynamixel 
%   motors (protocol_version), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the string vector including the torque enable/disable data (select)
%
%   For more information on torque enable, please refer to the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm


function torqueDxl(lib_name, port_num, protocol_version, ids, models, select)

    [start_address, ~] = lookupDxl('Torque Enable', models);

    fprintf("Torque %sd for motor IDs: ", select)
    for index = 1:length(ids)
        switch select
            case 'Enable'
                data = 1;
            case 'Disable'
                data = 0;
            otherwise
                fprintf("Wrong selection")
                data = [];
        end
        calllib(lib_name, 'write1ByteTxRx', port_num, protocol_version, ...
            ids(index), start_address(index), data)
        fprintf("%d ",ids(index))
    end
    fprintf("\n\n")
end