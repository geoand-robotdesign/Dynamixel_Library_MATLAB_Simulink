% READDXL Executes read for Dynamixel motors and returns the acquired 
%   data
% 
%   READDXL is a Level-2 MATLAB file S-Function for execution in
%   Simulink. It contains 7 dialog parameters including the name of the C 
%   library for Dynamixels (lib_name), the port number (port_num), the 
%   protocol number for the connected Dynamixel motors (protocol_version) 
%   the IDs of the connected dynamixels in vector format (ids), the models 
%   of the connected dynamixels in vector format
%   (models), the string vector including the read parameter for
%   the connected Dynamixel motors (select) and the sampling time for 
%   execution in Simulink (Ts).
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function readDxlSim(block)
% Level-2 MATLAB file S-Function

setup(block);

% ---------------------------------------------------------
    function setup(block)
        % Register the number of ports.
        block.NumInputPorts  = 0;
        block.NumOutputPorts = 1;

        ids = block.DialogPrm(4).Data;       
        block.SetPreCompOutPortInfoToDynamic;
        block.OutputPort(1).Dimensions  = length(ids);
        block.OutputPort(1).SamplingMode = 'sample';
        
        % Set up the states
        block.NumContStates = 0;
        block.NumDworks = 0;
        
        % Register the parameters.
        block.NumDialogPrms     = 7; % lib_name, port_num, protocol_version, ids, models, select, Ts
        block.DialogPrmsTunable = {'Nontunable', 'Nontunable', ...
            'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable'};
        
        % Set the sample time
        Ts = block.DialogPrm(7).Data;        
        block.SampleTimes = [Ts 0];

        block.SetAccelRunOnTLC(false); % run block in interpreted mode even w/ Acceleration
        block.SimStateCompliance = 'DefaultSimState';
       
        % Register methods
        block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
        % block.RegBlockMethod('InitializeConditions', @InitializeConditions);
        % block.RegBlockMethod('Start', @Start);
        block.RegBlockMethod('Outputs', @Outputs);
        % block.RegBlockMethod('Update', @Update);
        % block.RegBlockMethod('Derivatives', @Derivatives);
        % block.RegBlockMethod('Terminate', @Terminate);
    end

% ---------------------------------------------------------
    function DoPostPropSetup(block)
        st = block.SampleTimes;
        if st(1) == 0
            error('The library blocks can only handle discrete sample times');
        end        
    end

% ---------------------------------------------------------
    function InitializeConditions(block)

    end

% ---------------------------------------------------------
    function Outputs(block)

        lib_name = block.DialogPrm(1).Data;
        port_num = block.DialogPrm(2).Data;
        protocol_version = block.DialogPrm(3).Data;
        ids = block.DialogPrm(4).Data;
        models = block.DialogPrm(5).Data;
        select = block.DialogPrm(6).Data;
        [start_address, data_length] = lookupDxl(select, models);
        
        read_data = zeros(size(ids));

        switch data_length(1) %fix
            case 1
                func = 'read1ByteTxRx';
            case 2
                func = 'read2ByteTxRx';
            case 4
                func = 'read4ByteTxRx';
        end
        
        for index = 1:length(ids)
            data = calllib(lib_name, func, port_num, protocol_version, ...
                ids(index), start_address(index)); %fix
            read_data(index) = data;
        end

        block.OutputPort(1).Data = read_data;

    end
   
end
