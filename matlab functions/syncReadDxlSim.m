% SYNCREADDXLSIM Executes sync read for Dynamixel Motors in Simulink
%
%   SYNCREADDXLSIM is a Level-2 MATLAB file S-Function for execution in
%   Simulink. It contains 7 dialog parameters including the name of the C 
%   library for Dynamixels (lib_name), the group read number (group_num), 
%   the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the string vector including the parameter for sync read
%   function (select) and the sampling time for Simulink execution (Ts)
%   SYNCREADDXLSIM returns the selected read data (read_data)
%
%   For more information on sync read, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function syncReadDxlSim(block)
% Level-2 MATLAB file S-Function

setup(block);

% ---------------------------------------------------------
    function setup(block)
        % Register the number of ports.
        block.NumInputPorts  = 0;
        block.NumOutputPorts = 1;

        ids = block.DialogPrm(3).Data;       
        block.SetPreCompOutPortInfoToDynamic;
        block.OutputPort(1).Dimensions  = length(ids);
        block.OutputPort(1).SamplingMode = 'sample';
        
        % Set up the states
        block.NumContStates = 0;
        block.NumDworks = 0;
        
        % Register the parameters.
        block.NumDialogPrms     = 6; % lib_name, group_num, ids, models, select, Ts
        block.DialogPrmsTunable = {'Nontunable', 'Nontunable', ...
            'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable'};
        
        % Set the sample time
        Ts = block.DialogPrm(6).Data;        
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
        group_num = block.DialogPrm(2).Data;
        ids = block.DialogPrm(3).Data;
        models = block.DialogPrm(4).Data;
        select = block.DialogPrm(5).Data;
        [start_address, data_length] = lookupDxl(select, models);
        
        read_data = zeros(size(ids));

        %TxRxPacket
        calllib(lib_name, 'groupSyncReadTxRxPacket', group_num);
        
        %IsAvailable
        for index = 1:length(ids)
            calllib(lib_name, 'groupSyncReadIsAvailable', group_num, ...
                ids(index), start_address(1), data_length(1)); %fix
        end
        
        %GetData
        for index = 1:length(ids)
            data = calllib(lib_name, 'groupSyncReadGetData', group_num, ...
                ids(index), start_address(1), data_length(1)); %fix
            read_data(index) = data;
        end

        block.OutputPort(1).Data = read_data;

    end
   
end
