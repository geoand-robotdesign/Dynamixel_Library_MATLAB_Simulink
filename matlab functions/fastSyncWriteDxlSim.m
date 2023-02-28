% FASTSYNCWRITEDXLSIM Executes fast sync write for Dynamixel Motors in
%   Simulink
% 
%   FASTSYNCWRITEDXLSIM is a Level-2 MATLAB file S-Function for execution in
%   Simulink. It contains 6 dialog parameters including the name of the 
%   C library for Dynamixels (lib_name), the group write number 
%   (group_num_write), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the string vector including the parameter for sync read
%   function, and the sampling time for execution in Simulink (Ts).
%
%   For more information on fast sync write, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function fastSyncWriteDxlSim(block)
% Level-2 MATLAB file S-Function

setup(block);
  
% ---------------------------------------------------------
    function setup(block)

        % Registers the number of ports
        block.NumInputPorts  = 1;
        block.NumOutputPorts = 0;
        block.SetPreCompOutPortInfoToDynamic;
        block.InputPort(1).Dimensions  = length(block.DialogPrm(3).Data)...
            * length(block.DialogPrm(5).Data);
        block.InputPort(1).DirectFeedthrough = false;
        
        % Sets up the states
        block.NumContStates = 0;
        block.NumDworks = 0;
        
        % Registers the parameters
        block.NumDialogPrms     = 6; % lib_name, group_num_write, ids, models, select_sync_write, Ts
        block.DialogPrmsTunable = {'Nontunable', 'Nontunable', ...
            'Nontunable', 'Nontunable', 'Nontunable', 'Nontunable'};
        
        % Sets the sample time
        Ts = block.DialogPrm(6).Data;        
        block.SampleTimes = [Ts 0];

        block.SetAccelRunOnTLC(false); % run block in interpreted mode even w/ Acceleration
        block.SimStateCompliance = 'DefaultSimState';
       
        % Registers methods
        block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
        % block.RegBlockMethod('InitializeConditions', @InitializeConditions);
        % block.RegBlockMethod('Start', @Start);
        % block.RegBlockMethod('Outputs', @Outputs);
        block.RegBlockMethod('Update', @Update);
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
    function Update(block)

        lib_name = block.DialogPrm(1).Data;
        group_num_write = block.DialogPrm(2).Data;
        ids = block.DialogPrm(3).Data;
        models = block.DialogPrm(4).Data;
        select_sync_write = block.DialogPrm(5).Data;

        data_write = block.InputPort(1).Data; 
        for idx = 1:length(select_sync_write)
            for index = 1:length(ids)
                [~, data_length] = lookupDxl(select_sync_write(idx), models);
                calllib(lib_name, 'groupSyncWriteAddParam', ...
                    group_num_write, ids(index),...
                    data_write(index + (idx-1)*length(ids)),...
                    data_length(index));

            end
        end

        calllib(lib_name, 'groupSyncWriteTxPacket', group_num_write);
        calllib(lib_name, 'groupSyncWriteClearParam', group_num_write);

       
    end

end