% FINDDXL Finds connected dynamixels, returns their IDs and models
%
%   [motor_IDs, motor_models]= FINDDXL(lib_name, port_num, protocol_version) 
%   performs the following tasks:
%   - Searches for connected Dynamixels via the connected port number 
%   (port_num), for the protocol number (protocol_version) and using the C
%   library name lib_name
%   - Returns the connected motor IDs (motor_IDs) and models (motor_models)
%   in vector format
%
%   Make sure that all connected motor(s) have different IDs, otherwise
%   they will not all be recognized. Check ROBOTIS webpage on how to set
%   the motor IDs (e.g. via the Dynamixel Wizard 2.0).
%
%   For speed execution purposes, the maximum ID id_max in the motor search
%   has been set by default to 20. If higher IDs are used, the id_max needs
%   to be set accordingly to higher values (maximum of 253)
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function [motor_IDs, motor_models]= findDxl(lib_name, port_num, protocol_version)

    id_max = 20; %20 is used instead of 253 for speed
    motor_IDs = []; 
    motor_models = [];
    fprintf("Motors found:\n")
    for id = 0:id_max 
        motor_model_num = calllib(lib_name, 'pingGetModelNum', port_num,...
            protocol_version, id);
        if calllib(lib_name, 'getLastTxRxResult', port_num, protocol_version) == 0
            switch motor_model_num
                case 1020
                    motor_model = "XM430-W350";
                case 1030
                    motor_model = "XM430-W210";
                case 1120
                    motor_model = "XM540-W270";
                case 1130
                    motor_model = "XM540-W150";
                case 1070
                    motor_model = "XC430-W150";
                case 1080
                    motor_model = "XC430-W240";
                case 1220
                    motor_model = "XC330-T288";
                case 1210
                    motor_model = "XC330-T181";
                case 1230
                    motor_model = "XC330-M181";
                case 1240
                    motor_model = "XC330-M288";
                case 1060
                    motor_model = "XL430-W250";
                case 1190
                    motor_model = "XL330-M077";
                case 1200
                    motor_model = "XL330-M288";
                case 350
                    motor_model = "XL320";
                case 300
                    motor_model = "AX-12W";
                case 12
                    motor_model = "AX-12A";
                case 18
                    motor_model = "AX-18A";
                otherwise
                    motor_model = "Unknown model - not supported";
            end
            fprintf("%s, ID %.2d\n", motor_model, id);
            motor_IDs = [motor_IDs; id];
            motor_models = [motor_models; motor_model];
        end
    end
    fprintf("\n")
    
end