% FASTSYNCREADDXLSIM Executes fast sync read for Dynamixel Motors in
%   Simulink
% 
%   FASTSYNCREADDXLSIM is a Level-2 MATLAB file S-Function for execution in
%   Simulink. It contains 7 dialog parameters including the name of the 
%   C library for Dynamixels (lib_name), the group read number 
%   (group_num_read), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the string vector including the parameter for sync read
%   function, the start indirect address (start_address_read_indirect) and
%   the sampling time for execution in Simulink (Ts).
%
%   For more information on fast sync read, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function fastSyncReadDxlSim(block)
% Level-2 MATLAB file S-Function

setup(block);

% ---------------------------------------------------------
    function setup(block)

        % Registers the number of ports.
        block.NumInputPorts  = 0;
        block.NumOutputPorts = 1;
        block.SetPreCompOutPortInfoToDynamic;
        block.OutputPort(1).Dimensions  = [length(block.DialogPrm(5).Data), ...
            length(block.DialogPrm(3).Data)];
        block.OutputPort(1).SamplingMode = 'sample';
        
        % Sets up the states
        block.NumContStates = 0;
        block.NumDworks = 0;
        
        % Registers the parameters.
        block.NumDialogPrms     = 7; % lib_name, group_num_read, ids, models, select_sync_read, start_address_read_indirect, Ts
        block.DialogPrmsTunable = {'Nontunable', 'Nontunable', ...
            'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable'};
        
        % Sets the sample time
        Ts = block.DialogPrm(7).Data;        
        block.SampleTimes = [Ts 0];

        block.SetAccelRunOnTLC(false); % run block in interpreted mode even w/ Acceleration
        block.SimStateCompliance = 'DefaultSimState';
       
        % Registers methods
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
        group_num_read = block.DialogPrm(2).Data;
        ids = block.DialogPrm(3).Data;
        models = block.DialogPrm(4).Data;
        select_sync_read = block.DialogPrm(5).Data;
        start_address_read_indirect = block.DialogPrm(6).Data;

        read_data = zeros(length(select_sync_read), length(ids));
        [start_address, ~] = lookupDxl(start_address_read_indirect, models);
        data_length = 0;
        
        % Sync read packet from indirect data
        calllib(lib_name, 'groupSyncReadTxRxPacket', group_num_read);
        
        for idx = 1 : length(select_sync_read)
            start_address = start_address + data_length;
            [~, data_length] = lookupDxl(select_sync_read(idx), models);
            for index = 1:length(ids)
                %IsAvailable
                calllib(lib_name, 'groupSyncReadIsAvailable', ...
                    group_num_read, ids(index), start_address(index), data_length(index));
                %GetData
                data = calllib(lib_name, 'groupSyncReadGetData', ...
                    group_num_read, ids(index), start_address(index), data_length(index));
                read_data(idx,index) = data;
            end
%             block.OutputPort(idx).Data = read_data(idx,:);
        end
        block.OutputPort(1).Data = read_data;   
    end
   
end
