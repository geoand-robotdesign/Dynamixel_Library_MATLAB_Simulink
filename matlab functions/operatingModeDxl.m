% OPERATINGMODEDXL Changes the operating mode of Dynamixel motors
% 
%   OPERATINGMODEDXL(lib_name, port_num, protocol_version, ids, models, select)
%   uses the name of the C library for Dynamixels (lib_name), the 
%   port number (port_num), the protocol version of the connected 
%   Dynamixel motors (protocol_version), the IDs of the connected 
%   dynamixels in vector format (ids), the models of the connected 
%   dynamixels in vector format (models), and the string vector including 
%   the operating modes for the connected Dynamixel motors (select).
%   
%   Depending on the Dynamixel motor model, up to six operating modes are 
%   supported for each element of (select):
%       'Current Control', 
%       'Velocity Control',
%       'Position Control',
%       'Extended Position Control', 
%       'Current-based Position Control', and
%       'PWM Control'
%   For more information on Dynamixel operating modes, please refer to the
%   ROBOTIS page of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function operatingModeDxl(lib_name, port_num, protocol_version, ids, models, select)

    [start_address, ~] = lookupDxl('Operating Mode', models);
    fprintf("Operating mode changed to '%s' for motor IDs: ", select)
    
    for index = 1:length(ids)
        switch select
            case 'Current Control'
                data = 0;
            case 'Velocity Control'
                data = 1;
            case 'Position Control'
                data = 3;
            case 'Extended Position Control'
                data = 4;
            case 'Current-based Position Control'
                data = 5;
            case 'PWM Control'
                data = 16;
            otherwise
                fprintf("Unknown operating mode\n");
                data = [];
        end
        calllib(lib_name,'write1ByteTxRx',port_num, protocol_version, ...
            ids(index), start_address(index), data)
        fprintf("%d ",ids(index))
    end
    fprintf("\n\n")
end