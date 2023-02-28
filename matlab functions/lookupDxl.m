% LOOKUPDXL Searches the control table RAM data of Dynamixel motors
%   
%   [start_address, data_length] = LOOKUPDXL(select, models) searches the
%   control RAM data of multiple Dynamixel models (model) and returns the 
%   start addresses (start_address) and data lengths (data_length) in 
%   vector formats of the dynamixel property (select) fof the connected 
%   Dynamixel models
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function [start_address, data_length] = lookupDxl(select, models)
    
    start_address = ones(1,length(models));
    data_length = ones(1,length(models));

    for index = 1:length(models)
        switch models(index)
            case {'XM540-W270','XM540-W150'}
                [start_address(index), data_length(index)] = lookupX540(select);
            case {'XM430-W350', 'XM430-W210', 'XC430-W240', 'XC430-W150', 'XL430-W250'}
                [start_address(index), data_length(index)] = lookupX430(select);             
            case {'XC330-T288', 'XC330-T181', 'XC330-M181', 'XC330-M288', ...
                    'XL330-M288', 'XL330-M077'}
                [start_address(index), data_length(index)] = lookupX330(select);
            case 'XL320'
                [start_address(index), data_length(index)] = lookupXL320(select);
            case {'AX-12W','AX-12A','AX-18A'}
                [start_address(index), data_length(index)] = lookupAX(select);    
            otherwise
                fprintf('Invalid or not supported motor model\n')
                start_address = [];
                data_length = [];
        end
    end

end

function [start_address, data_length] = lookupX540(select)
    %Lookup table for XM540 (no other X-540 have been tested yet)
    switch select
        case 'Drive Mode'
            start_address = 10;
            data_length = 1;
        case 'Operating Mode'
            start_address = 11;
            data_length = 1;
        case 'Homing Offset'
            start_address = 20;
            data_length = 4;
        case 'Torque Enable'
            start_address = 64;
            data_length = 1;
        case 'LED'
            start_address = 65;
            data_length = 1;
        case 'Hardware Error Status'
            start_address = 70;
            data_length = 1;            
        case 'Goal Current'
            start_address = 102;
            data_length = 2;
        case 'Goal Velocity' % To avoid errors due to naming
            start_address = 104;
            data_length = 4;
        case 'Moving Speed' % To avoid errors due to naming
            start_address = 104;
            data_length = 4;
        case 'Profile Acceleration'
            start_address = 108;
            data_length = 4;
        case 'Profile Velocity'
            start_address = 112;
            data_length = 4;
        case 'Goal Position'
            start_address = 116;
            data_length = 4;
        case 'Present Position'
            start_address = 132;
            data_length = 4;
        case 'Present Velocity'
            start_address = 128;
            data_length = 4;
        case 'Present Current/Load' % To avoid errors due to naming
            start_address = 126;
            data_length = 2;
        case 'Present Current' % To avoid errors due to naming
            start_address = 126;
            data_length = 2;
        case 'Present Temperature'
            start_address = 146;
            data_length = 1;
        case 'Indirect Address 1'
            start_address = 168;
            data_length = 2;
        case 'Indirect Address 2'
            start_address = 170;
            data_length = 2;
        case 'Indirect Address 3'
            start_address = 172;
            data_length = 2;
        case 'Indirect Address 4'
            start_address = 174;
            data_length = 2;
        case 'Indirect Address 5'
            start_address = 176;
            data_length = 2;
        case 'Indirect Address 6'
            start_address = 178;
            data_length = 2;
        case 'Indirect Address 7'
            start_address = 180;
            data_length = 2;
        case 'Indirect Address 8'
            start_address = 182;
            data_length = 2;
        case 'Indirect Address 9'
            start_address = 184;
            data_length = 2;
        case 'Indirect Address 10'
            start_address = 186;
            data_length = 2;
        case 'Indirect Address 11'
            start_address = 188;
            data_length = 2;
        case 'Indirect Address 12'
            start_address = 190;
            data_length = 2;
        case 'Indirect Address 13'
            start_address = 192;
            data_length = 2;
        case 'Indirect Address 14'
            start_address = 194;
            data_length = 2;
        case 'Indirect Address 15'
            start_address = 196;
            data_length = 2;
        case 'Indirect Address 16'
            start_address = 198;
            data_length = 2;
        case 'Indirect Address 17'
            start_address = 200;
            data_length = 2;
        case 'Indirect Address 18'
            start_address = 202;
            data_length = 2;
        case 'Indirect Address 19'
            start_address = 204;
            data_length = 2;
        case 'Indirect Address 20'
            start_address = 206;
            data_length = 2;
        case 'Indirect Address 21'
            start_address = 208;
            data_length = 2;
        case 'Indirect Address 22'
            start_address = 210;
            data_length = 2;
        case 'Indirect Address 23'
            start_address = 212;
            data_length = 2;
        case 'Indirect Address 24'
            start_address = 214;
            data_length = 2;
        case 'Indirect Address 25'
            start_address = 216;
            data_length = 2;
        case 'Indirect Address 26'
            start_address = 218;
            data_length = 2;
        case 'Indirect Address 27'
            start_address = 220;
            data_length = 2;
        case 'Indirect Address 28'
            start_address = 222;
            data_length = 2;
        case 'Indirect Address 29'
            start_address = 578;
            data_length = 2;
        case 'Indirect Address 30'
            start_address = 580;
            data_length = 2;
        case 'Indirect Address 31'
            start_address = 582;
            data_length = 2;
        case 'Indirect Address 32'
            start_address = 584;
            data_length = 2;
        case 'Indirect Address 33'
            start_address = 586;
            data_length = 2;
        case 'Indirect Address 34'
            start_address = 588;
            data_length = 2;
        case 'Indirect Address 35'
            start_address = 590;
            data_length = 2;
        case 'Indirect Address 36'
            start_address = 592;
            data_length = 2;
        case 'Indirect Address 37'
            start_address = 594;
            data_length = 2;
        case 'Indirect Address 38'
            start_address = 596;
            data_length = 2;
        case 'Indirect Address 39'
            start_address = 598;
            data_length = 2;
        case 'Indirect Data 1'
            start_address = 224;
            data_length = 1;
        case 'Indirect Data 2'
            start_address = 225;
            data_length = 1;
        case 'Indirect Data 3'
            start_address = 226;
            data_length = 1;
        case 'Indirect Data 4'
            start_address = 227;
            data_length = 1;
        case 'Indirect Data 5'
            start_address = 228;
            data_length = 1;
        case 'Indirect Data 6'
            start_address = 229;
            data_length = 1;
        case 'Indirect Data 7'
            start_address = 230;
            data_length = 1;
        case 'Indirect Data 8'
            start_address = 231;
            data_length = 1;
        case 'Indirect Data 9'
            start_address = 232;
            data_length = 1;
        case 'Indirect Data 10'
            start_address = 233;
            data_length = 1;
        case 'Indirect Data 11'
            start_address = 234;
            data_length = 1;
        case 'Indirect Data 12'
            start_address = 235;
            data_length = 1;
        case 'Indirect Data 13'
            start_address = 236;
            data_length = 1;
        case 'Indirect Data 14'
            start_address = 237;
            data_length = 1;
        case 'Indirect Data 15'
            start_address = 238;
            data_length = 1;
        case 'Indirect Data 16'
            start_address = 239;
            data_length = 1;
        case 'Indirect Data 17'
            start_address = 240;
            data_length = 1;
        case 'Indirect Data 18'
            start_address = 241;
            data_length = 1;
        case 'Indirect Data 19'
            start_address = 242;
            data_length = 1;
        case 'Indirect Data 20'
            start_address = 243;
            data_length = 1;
        case 'Indirect Data 21'
            start_address = 244;
            data_length = 1;
        case 'Indirect Data 22'
            start_address = 245;
            data_length = 1;
        case 'Indirect Data 23'
            start_address = 246;
            data_length = 1;
        case 'Indirect Data 24'
            start_address = 247;
            data_length = 1;
        case 'Indirect Data 25'
            start_address = 248;
            data_length = 1;
        case 'Indirect Data 26'
            start_address = 249;
            data_length = 1;
        case 'Indirect Data 27'
            start_address = 250;
            data_length = 1;
        case 'Indirect Data 28'
            start_address = 251;
            data_length = 1;
        case 'Indirect Data 29'
            start_address = 634;
            data_length = 1;
        case 'Indirect Data 30'
            start_address = 635;
            data_length = 1;
        case 'Indirect Data 31'
            start_address = 636;
            data_length = 1;
        case 'Indirect Data 32'
            start_address = 637;
            data_length = 1;
        case 'Indirect Data 33'
            start_address = 638;
            data_length = 1;
        case 'Indirect Data 34'
            start_address = 639;
            data_length = 1;
        case 'Indirect Data 35'
            start_address = 640;
            data_length = 1;
        case 'Indirect Data 36'
            start_address = 641;
            data_length = 1;
        case 'Indirect Data 37'
            start_address = 642;
            data_length = 1;
        case 'Indirect Data 38'
            start_address = 643;
            data_length = 1;
        case 'Indirect Data 39'
            start_address = 644;
            data_length = 1;
        otherwise
            fprintf('Invalid or missing table selection\n')
            start_address = [];
            data_length = [];
    end
end

function [start_address, data_length] = lookupX430(select)
    %Lookup table for XM, XC, XL series (except XL320)
    switch select
        case 'Drive Mode'
            start_address = 10;
            data_length = 1;
        case 'Operating Mode'
            start_address = 11;
            data_length = 1;
        case 'Homing Offset'
            start_address = 20;
            data_length = 4;
        case 'Torque Enable'
            start_address = 64;
            data_length = 1;
        case 'LED'
            start_address = 65;
            data_length = 1;
        case 'Hardware Error Status'
            start_address = 70;
            data_length = 1;            
        case 'Goal Current'
            start_address = 102;
            data_length = 2;
        case 'Goal Velocity' % To avoid errors due to naming
            start_address = 104;
            data_length = 4;
        case 'Moving Speed' % To avoid errors due to naming
            start_address = 104;
            data_length = 4;
        case 'Profile Acceleration'
            start_address = 108;
            data_length = 4;
        case 'Profile Velocity'
            start_address = 112;
            data_length = 4;
        case 'Goal Position'
            start_address = 116;
            data_length = 4;
        case 'Present Position'
            start_address = 132;
            data_length = 4;
        case 'Present Velocity'
            start_address = 128;
            data_length = 4;
        case 'Present Current/Load' % To avoid errors due to naming
            start_address = 126;
            data_length = 2;
        case 'Present Current' % To avoid errors due to naming
            start_address = 126;
            data_length = 2;
        case 'Present Load' % To avoid errors due to naming
            start_address = 126;
            data_length = 2;
        case 'Present Temperature'
            start_address = 146;
            data_length = 1;
        case 'Indirect Address 1'
            start_address = 168;
            data_length = 2;
        case 'Indirect Address 2'
            start_address = 170;
            data_length = 2;
        case 'Indirect Address 3'
            start_address = 172;
            data_length = 2;
        case 'Indirect Address 4'
            start_address = 174;
            data_length = 2;
        case 'Indirect Address 5'
            start_address = 176;
            data_length = 2;
        case 'Indirect Address 6'
            start_address = 178;
            data_length = 2;
        case 'Indirect Address 7'
            start_address = 180;
            data_length = 2;
        case 'Indirect Address 8'
            start_address = 182;
            data_length = 2;
        case 'Indirect Address 9'
            start_address = 184;
            data_length = 2;
        case 'Indirect Address 10'
            start_address = 186;
            data_length = 2;
        case 'Indirect Address 11'
            start_address = 188;
            data_length = 2;
        case 'Indirect Address 12'
            start_address = 190;
            data_length = 2;
        case 'Indirect Address 13'
            start_address = 192;
            data_length = 2;
        case 'Indirect Address 14'
            start_address = 194;
            data_length = 2;
        case 'Indirect Address 15'
            start_address = 196;
            data_length = 2;
        case 'Indirect Address 16'
            start_address = 198;
            data_length = 2;
        case 'Indirect Address 17'
            start_address = 200;
            data_length = 2;
        case 'Indirect Address 18'
            start_address = 202;
            data_length = 2;
        case 'Indirect Address 19'
            start_address = 204;
            data_length = 2;
        case 'Indirect Address 20'
            start_address = 206;
            data_length = 2;
        case 'Indirect Address 21'
            start_address = 208;
            data_length = 2;
        case 'Indirect Address 22'
            start_address = 210;
            data_length = 2;
        case 'Indirect Address 23'
            start_address = 212;
            data_length = 2;
        case 'Indirect Address 24'
            start_address = 214;
            data_length = 2;
        case 'Indirect Address 25'
            start_address = 216;
            data_length = 2;
        case 'Indirect Address 26'
            start_address = 218;
            data_length = 2;
        case 'Indirect Address 27'
            start_address = 220;
            data_length = 2;
        case 'Indirect Address 28'
            start_address = 222;
            data_length = 2;
        case 'Indirect Address 29'
            start_address = 578;
            data_length = 2;
        case 'Indirect Address 30'
            start_address = 580;
            data_length = 2;
        case 'Indirect Address 31'
            start_address = 582;
            data_length = 2;
        case 'Indirect Address 32'
            start_address = 584;
            data_length = 2;
        case 'Indirect Address 33'
            start_address = 586;
            data_length = 2;
        case 'Indirect Address 34'
            start_address = 588;
            data_length = 2;
        case 'Indirect Address 35'
            start_address = 590;
            data_length = 2;
        case 'Indirect Address 36'
            start_address = 592;
            data_length = 2;
        case 'Indirect Address 37'
            start_address = 594;
            data_length = 2;
        case 'Indirect Address 38'
            start_address = 596;
            data_length = 2;
        case 'Indirect Address 39'
            start_address = 598;
            data_length = 2;
        case 'Indirect Data 1'
            start_address = 224;
            data_length = 1;
        case 'Indirect Data 2'
            start_address = 225;
            data_length = 1;
        case 'Indirect Data 3'
            start_address = 226;
            data_length = 1;
        case 'Indirect Data 4'
            start_address = 227;
            data_length = 1;
        case 'Indirect Data 5'
            start_address = 228;
            data_length = 1;
        case 'Indirect Data 6'
            start_address = 229;
            data_length = 1;
        case 'Indirect Data 7'
            start_address = 230;
            data_length = 1;
        case 'Indirect Data 8'
            start_address = 231;
            data_length = 1;
        case 'Indirect Data 9'
            start_address = 232;
            data_length = 1;
        case 'Indirect Data 10'
            start_address = 233;
            data_length = 1;
        case 'Indirect Data 11'
            start_address = 234;
            data_length = 1;
        case 'Indirect Data 12'
            start_address = 235;
            data_length = 1;
        case 'Indirect Data 13'
            start_address = 236;
            data_length = 1;
        case 'Indirect Data 14'
            start_address = 237;
            data_length = 1;
        case 'Indirect Data 15'
            start_address = 238;
            data_length = 1;
        case 'Indirect Data 16'
            start_address = 239;
            data_length = 1;
        case 'Indirect Data 17'
            start_address = 240;
            data_length = 1;
        case 'Indirect Data 18'
            start_address = 241;
            data_length = 1;
        case 'Indirect Data 19'
            start_address = 242;
            data_length = 1;
        case 'Indirect Data 20'
            start_address = 243;
            data_length = 1;
        case 'Indirect Data 21'
            start_address = 244;
            data_length = 1;
        case 'Indirect Data 22'
            start_address = 245;
            data_length = 1;
        case 'Indirect Data 23'
            start_address = 246;
            data_length = 1;
        case 'Indirect Data 24'
            start_address = 247;
            data_length = 1;
        case 'Indirect Data 25'
            start_address = 248;
            data_length = 1;
        case 'Indirect Data 26'
            start_address = 249;
            data_length = 1;
        case 'Indirect Data 27'
            start_address = 250;
            data_length = 1;
        case 'Indirect Data 28'
            start_address = 251;
            data_length = 1;
        case 'Indirect Data 29'
            start_address = 634;
            data_length = 1;
        case 'Indirect Data 30'
            start_address = 635;
            data_length = 1;
        case 'Indirect Data 31'
            start_address = 636;
            data_length = 1;
        case 'Indirect Data 32'
            start_address = 637;
            data_length = 1;
        case 'Indirect Data 33'
            start_address = 638;
            data_length = 1;
        case 'Indirect Data 34'
            start_address = 639;
            data_length = 1;
        case 'Indirect Data 35'
            start_address = 640;
            data_length = 1;
        case 'Indirect Data 36'
            start_address = 641;
            data_length = 1;
        case 'Indirect Data 37'
            start_address = 642;
            data_length = 1;
        case 'Indirect Data 38'
            start_address = 643;
            data_length = 1;
        case 'Indirect Data 39'
            start_address = 644;
            data_length = 1;
        otherwise
            fprintf('Invalid or missing table selection\n')
            start_address = [];
            data_length = [];
    end
end

function [start_address, data_length] = lookupX330(select)
    %Lookup table for XM, XC, XL series (except XL320)
    switch select
        case 'Drive Mode'
            start_address = 10;
            data_length = 1;
        case 'Operating Mode'
            start_address = 11;
            data_length = 1;
        case 'Homing Offset'
            start_address = 20;
            data_length = 4;
        case 'Torque Enable'
            start_address = 64;
            data_length = 1;
        case 'LED'
            start_address = 65;
            data_length = 1;
        case 'Hardware Error Status'
            start_address = 70;
            data_length = 1; 
        case 'Goal Current'
            start_address = 102;
            data_length = 2;
        case 'Goal Velocity' % To avoid errors due to naming
            start_address = 104;
            data_length = 4;
        case 'Moving Speed' % To avoid errors due to naming
            start_address = 104;
            data_length = 4;
        case 'Profile Acceleration'
            start_address = 108;
            data_length = 4;
        case 'Profile Velocity'
            start_address = 112;
            data_length = 4;
        case 'Goal Position'
            start_address = 116;
            data_length = 4;
        case 'Present Position'
            start_address = 132;
            data_length = 4;
        case 'Present Velocity'
            start_address = 128;
            data_length = 4;
        case 'Present Current/Load' % To avoid errors due to naming
            start_address = 126;
            data_length = 2;
        case 'Present Current' % To avoid errors due to naming
            start_address = 126;
            data_length = 2;
        case 'Present Load' % To avoid errors due to naming
            start_address = 126;
            data_length = 2;
        case 'Present Temperature'
            start_address = 146;
            data_length = 1;
        case 'Indirect Address 1'
            start_address = 168;
            data_length = 2;
        case 'Indirect Address 2'
            start_address = 170;
            data_length = 2;
        case 'Indirect Address 3'
            start_address = 172;
            data_length = 2;
        case 'Indirect Address 4'
            start_address = 174;
            data_length = 2;
        case 'Indirect Address 5'
            start_address = 176;
            data_length = 2;
        case 'Indirect Address 6'
            start_address = 178;
            data_length = 2;
        case 'Indirect Address 7'
            start_address = 180;
            data_length = 2;
        case 'Indirect Address 8'
            start_address = 182;
            data_length = 2;
        case 'Indirect Address 9'
            start_address = 184;
            data_length = 2;
        case 'Indirect Address 10'
            start_address = 186;
            data_length = 2;
        case 'Indirect Address 11'
            start_address = 188;
            data_length = 2;
        case 'Indirect Address 12'
            start_address = 190;
            data_length = 2;
        case 'Indirect Address 13'
            start_address = 192;
            data_length = 2;
        case 'Indirect Address 14'
            start_address = 194;
            data_length = 2;
        case 'Indirect Address 15'
            start_address = 196;
            data_length = 2;
        case 'Indirect Address 16'
            start_address = 198;
            data_length = 2;
        case 'Indirect Address 17'
            start_address = 200;
            data_length = 2;
        case 'Indirect Address 18'
            start_address = 202;
            data_length = 2;
        case 'Indirect Address 19'
            start_address = 204;
            data_length = 2;
        case 'Indirect Address 20'
            start_address = 206;
            data_length = 2;
        case 'Indirect Data 1'
            start_address = 208;
            data_length = 1;
        case 'Indirect Data 2'
            start_address = 209;
            data_length = 1;
        case 'Indirect Data 3'
            start_address = 210;
            data_length = 1;
        case 'Indirect Data 4'
            start_address = 211;
            data_length = 1;
        case 'Indirect Data 5'
            start_address = 212;
            data_length = 1;
        case 'Indirect Data 6'
            start_address = 213;
            data_length = 1;
        case 'Indirect Data 7'
            start_address = 214;
            data_length = 1;
        case 'Indirect Data 8'
            start_address = 215;
            data_length = 1;
        case 'Indirect Data 9'
            start_address = 216;
            data_length = 1;
        case 'Indirect Data 10'
            start_address = 217;
            data_length = 1;
        case 'Indirect Data 11'
            start_address = 218;
            data_length = 1;
        case 'Indirect Data 12'
            start_address = 219;
            data_length = 1;
        case 'Indirect Data 13'
            start_address = 220;
            data_length = 1;
        case 'Indirect Data 14'
            start_address = 221;
            data_length = 1;
        case 'Indirect Data 15'
            start_address = 222;
            data_length = 1;
        case 'Indirect Data 16'
            start_address = 223;
            data_length = 1;
        case 'Indirect Data 17'
            start_address = 224;
            data_length = 1;
        case 'Indirect Data 18'
            start_address = 225;
            data_length = 1;
        case 'Indirect Data 19'
            start_address = 226;
            data_length = 1;
        case 'Indirect Data 20'
            start_address = 227;
            data_length = 1;
        otherwise
            fprintf('Invalid or missing table selection\n')
            start_address = [];
            data_length = [];
    end
end

function [start_address, data_length] = lookupXL320(select)
    
    % Lookup table for XL330
    switch select
        case 'ID'
            start_address = 3;
            data_length = 1;
        case 'Baud Rate'
            start_address = 4;
            data_length = 1;
        case 'CW Angle Limit'
            start_address = 6;
            data_length = 2;
        case 'CCW Angle Limit'
            start_address = 8;
            data_length = 2;
        case 'Operating Mode' % Control Mode
            start_address = 11;
            data_length = 1;
        case 'Temperature Limit'
            start_address = 12;
            data_length = 1;
        case 'Min Voltage Limit'
            start_address = 13;
            data_length = 1;
        case 'Max Voltage Limit'
            start_address = 14;
            data_length = 1;
        case 'Max Torque'
            start_address = 15;
            data_length = 2;
        case 'Status Return Level'
            start_address = 17;
            data_length = 1;
        case 'Shutdown'
            start_address = 18;
            data_length = 1;
        case 'Torque Enable'
            start_address = 24;
            data_length = 1;
        case 'LED'
            start_address = 25;
            data_length = 1;
        case 'D Gain'
            start_address = 27;
            data_length = 1;
        case 'I Gain'
            start_address = 28;
            data_length = 1;
        case 'P Gain'
            start_address = 29;
            data_length = 1;
        case 'Goal Position'
            start_address = 30;
            data_length = 2;
        case 'Moving Speed'
            start_address = 32;
            data_length = 2;
        case 'Torque Limit'
            start_address = 35;
            data_length = 2;
        case 'Present Position'
            start_address = 37;
            data_length = 2;
        case 'Present Velocity' % Present Speed
            start_address = 39;
            data_length = 2;
        case 'Present Load'
            start_address = 41;
            data_length = 2;
        case 'Present Voltage'
            start_address = 45;
            data_length = 1;
        case 'Present Temperature'
            start_address = 46;
            data_length = 1;
        case 'Registered Instruction'
            start_address = 47;
            data_length = 1;
        case 'Moving'
            start_address = 49;
            data_length = 1;
        case 'Hardware Error Status'
            start_address = 50;
            data_length = 1;
        case 'Punch'
            start_address = 51;
            data_length = 2;
        otherwise
            fprintf('Invalid or missing table selection\n')
            start_address = [];
            data_length = [];
    end

end

function [start_address, data_length] = lookupAX(select)
    % Lookup table for AX Series
    switch select
        case 'ID'
            start_address = 3;
            data_length = 1;
        case 'Baud Rate'
            start_address = 4;
            data_length = 1;
        case 'CW Angle Limit'
            start_address = 6;
            data_length = 2;
        case 'CCW Angle Limit'
            start_address = 8;
            data_length = 2;
        case 'Temperature Limit'
            start_address = 11;
            data_length = 1;
        case 'Min Voltage Limit'
            start_address = 12;
            data_length = 1;
        case 'Max Voltage Limit'
            start_address = 13;
            data_length = 1;
        case 'Max Torque'
            start_address = 14;
            data_length = 2;
        case 'Status Return Level'
            start_address = 16;
            data_length = 1;
        case 'Alarm LED'
            start_address = 17;
            data_length = 1;           
        case 'Shutdown'
            start_address = 18;
            data_length = 1;
        case 'Torque Enable'
            start_address = 24;
            data_length = 1;
        case 'LED'
            start_address = 25;
            data_length = 1;
        case 'CW Compliance Margin'
            start_address = 26;
            data_length = 1;
        case 'CCW Compliance Margin'
            start_address = 27;
            data_length = 1;
        case 'CW Compliance Slope'
            start_address = 28;
            data_length = 1;
        case 'CCW Compliance Slope'
            start_address = 29;
            data_length = 1;
        case 'Goal Position'
            start_address = 30;
            data_length = 2;
        case 'Moving Speed' % To avoid errors due to naming
            start_address = 32;
            data_length = 2;
        case 'Goal Velocity' % To avoid errors due to naming
            start_address = 32;
            data_length = 2;
        case 'Torque Limit'
            start_address = 34;
            data_length = 2;
        case 'Present Position'
            start_address = 36;
            data_length = 2;
        case 'Present Speed' % To avoid errors due to naming
            start_address = 38;
            data_length = 2;
        case 'Present Velocity' % To avoid errors due to naming
            start_address = 38;
            data_length = 2;            
        case 'Present Load'
            start_address = 40;
            data_length = 2;
        case 'Present Voltage'
            start_address = 42;
            data_length = 1;
        case 'Present Temperature'
            start_address = 43;
            data_length = 1;
        case 'Registered'
            start_address = 44;
            data_length = 1;
        case 'Moving'
            start_address = 46;
            data_length = 1;
        case 'Lock'
            start_address = 47;
            data_length = 1;
        case 'Punch'
            start_address = 48;
            data_length = 2;
        otherwise
            fprintf('Invalid or missing table selection\n')
            start_address = [];
            data_length = [];
    end

end