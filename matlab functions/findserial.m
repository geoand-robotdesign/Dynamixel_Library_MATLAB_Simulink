% FINDSERIAL Finds and returns connected serial (COM) ports
%   com_ports = FINDSERIAL() returns cell array of found serial ports under
%   Windows
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function com_ports = findserial()
    [~,res] = system('mode');
    com_ports = regexp(res,'COM\d+','match')';
end