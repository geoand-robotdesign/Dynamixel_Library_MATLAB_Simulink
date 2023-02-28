% WRITEDXLSIM Executes write for Dynamixel motors in Simulink
% 
%   WRITEDXLSIM is a Level-2 MATLAB file S-Function for execution in
%   Simulink. It contains 7 dialog parameters including 
%   the name of the C library for Dynamixels (lib_name), the 
%   group read number (group_num), the IDs of the connected dynamixels in vector
%   format (ids), the models of the connected dynamixels in string vector format
%   (models), the parameter for write function (select) and the sampling
%   time for Simulink execution (Ts)
%
%   For more information on the write function, please check the ROBOTIS page
%   of the utilized Dynamixel motor.
%
%   Part of the Dynamixel library for Matlab and Simulink
%   Author: Georgios Andrikopoulos (geoand@kth.se), 2022
%   Mechatronics & Embedded Control Systems Unit, KTH, Stockholm

function writeDxlSim(block)
% Level-2 MATLAB file S-Function

setup(block);
  
% ---------------------------------------------------------
    function setup(block)
        % Register the number of ports.
        block.NumInputPorts  = 1;
        block.NumOutputPorts = 0;
        
        ids = block.DialogPrm(4).Data;
        block.SetPreCompOutPortInfoToDynamic;
        block.InputPort(1).Dimensions  = length(ids);
        block.InputPort(1).DirectFeedthrough = false;
        
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
        port_num = block.DialogPrm(2).Data;
        protocol_version = block.DialogPrm(3).Data;
        ids = block.DialogPrm(4).Data;
        models = block.DialogPrm(5).Data;
        select = block.DialogPrm(6).Data;
        [start_address, data_length] = lookupDxl(select, models);

        data_write = block.InputPort(1).Data;
        
        switch data_length(1) %fix
            case 1
                func = 'write1ByteTxRx';
            case 2
                func = 'write2ByteTxRx';
            case 4
                func = 'write4ByteTxRx';
        end
        
        for index = 1:length(ids)
            calllib(lib_name, func, port_num, protocol_version, ...
                ids(index), start_address(index), data_write(index)); %fix
        end
       
    end

end