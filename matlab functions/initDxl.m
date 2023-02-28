% INITDXL Loads C library and initializes Dynamixel communication 
%
%   [lib_name, port_num] =  INITDXL(com_port) performs the following tasks:
%   - checks whether the selected COM port (com_port) is connected
%   - loads the Dynamixel C library (as found in %%insert link%%) 
%   and returns its name (lib_name)
%   - enables the handler and returns the port number (port_num) 
%   - enables the handler for the Dynamixel packet
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function [lib_name, port_num] = initDxl(com_port)

    % Checks whether the selected COM port is active
    com_ports = findserial();
    if ~any(strcmp(com_port,com_ports))
        fprintf("Invalid COM port, please check if the board is plugged \n")
        fprintf("or change the COM to one of the active ones: \n")
        fprintf("%s\n",com_ports{:})
        fprintf("\n")
    end

    % Finds computer type and returns the valid C library name
    switch computer
        case 'PCWIN'
            lib_name = 'dxl_x86_c';
        case 'PCWIN64'
            lib_name = 'dxl_x64_c';
        case 'GLNX86'
            lib_name = 'libdxl_x86_c';
        case 'GLNXA64'
            lib_name = 'libdxl_x64_c';
    end
    
    % Loads C library
    if ~libisloaded(lib_name)
        [notfound, warnings] = loadlibrary(lib_name, 'dynamixel_sdk.h','addheader',...
            'port_handler.h', 'addheader', 'packet_handler.h','addheader',...
            'group_sync_write.h', 'addheader', 'group_sync_read.h','addheader',...
            'group_bulk_write.h', 'addheader', 'group_bulk_read.h','addheader',...
            'protocol1_packet_handler.h', 'addheader', 'protocol2_packet_handler.h',...
            'addheader','robotis_def.h');
    end
    
    % Enabling the handler for the Dynamixel port
    port_num = calllib(lib_name, 'portHandler', com_port);
    
    % Enables the handler for the Dynamixel packet 
    calllib(lib_name, 'packetHandler');

end