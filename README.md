# Dynamixel Library for MATLAB and Simulink

This repository contains a [ROBOTIS Dynamixel](https://emanual.robotis.com/docs/en/dxl/) library for [MATLAB](https://www.mathworks.com/products/matlab.html) and [Simulink](https://www.mathworks.com/products/simulink.html). The purpose of the library is to provide higher level functions for easier control of multiple Dynamixel smart actuators from within MATLAB and Simulink environments.

The *Dynamixel library for MATLAB and Simulink* is based on the dynamic library using C language included in the [Dynamixel SDK](https://github.com/ROBOTIS-GIT/DynamixelSDK) (see Requirements), and was inspired by the MATLAB library included in the same SDK, as well as the [Dynamixel Simulink Library](https://se.mathworks.com/matlabcentral/fileexchange/61944-dynamixel-simulink-library) developed by Jeihun Lee.

This library expands on the capabilities of the aforementioned references, by providing high-level functions for easier communication handling and control of multiple Dynamixel motors supporting both ROBOTIS protocols ([1.0](https://emanual.robotis.com/docs/en/dxl/protocol1/) and [2.0](https://emanual.robotis.com/docs/en/dxl/protocol2/)). The Simulink implementation makes it easier to execute near real-time Dynamixel motor control using its integrated [Simulation Pacing](https://se.mathworks.com/help/simulink/ug/simulation-pacing.html) functionality, while enabling the design and testing of higher-level robot controllers using Simulink's and MATLAB's toolboxes. Finally, the library comes with a number of examples written for MATLAB and Simulink providing help on how to use its functionalities.

Author: Georgios Andrikopoulos (geoand@kth.se). Written in [MATLAB 2022b](https://www.mathworks.com/products/new_products/latest_features.html).

## Current Support

- Protocols [1](https://emanual.robotis.com/docs/en/dxl/protocol1/) and [2](https://emanual.robotis.com/docs/en/dxl/protocol2/)
- Dynamixel Motors:
  - [X Series](https://emanual.robotis.com/docs/en/dxl/x/)
    - [XL320](https://emanual.robotis.com/docs/en/dxl/x/xl320/)
    - [XL330-M288](https://emanual.robotis.com/docs/en/dxl/x/xl330-m288/)
    - [XL330-M077](https://emanual.robotis.com/docs/en/dxl/x/xl330-m077/)
    - [XC330-M288](https://emanual.robotis.com/docs/en/dxl/x/xc330-m288/)
    - [XC330-M181](https://emanual.robotis.com/docs/en/dxl/x/xc330-m181/)
    - [XC330-T181](https://emanual.robotis.com/docs/en/dxl/x/xc330-t181/)
    - [XC330-T288](https://emanual.robotis.com/docs/en/dxl/x/xc330-t288/)
    - [XC430-W240](https://emanual.robotis.com/docs/en/dxl/x/xc430-w240/)
    - [XC430-W150](https://emanual.robotis.com/docs/en/dxl/x/xc430-w150/)
    - [XL430-W250](https://emanual.robotis.com/docs/en/dxl/x/xl430-w250/)
    - [XM430-W350](https://emanual.robotis.com/docs/en/dxl/x/xm430-w350/)
    - [XM430-W210](https://emanual.robotis.com/docs/en/dxl/x/xm430-w210/)
    - [XM540-W150](https://emanual.robotis.com/docs/en/dxl/x/xm540-w150/)
    - [XM540-W270](https://emanual.robotis.com/docs/en/dxl/x/xm540-w270/)
  - AX Series
    - [AX-12A](https://emanual.robotis.com/docs/en/dxl/ax/ax-12a/)
    - [AX-12W](https://emanual.robotis.com/docs/en/dxl/ax/ax-12w/)
    - [AX-18A](https://emanual.robotis.com/docs/en/dxl/ax/ax-18a/)
- Controllers:
  - [U2D2](https://emanual.robotis.com/docs/en/parts/interface/u2d2/)
  - [OpenRB-150](https://emanual.robotis.com/docs/en/parts/controller/openrb-150/)
- MATLAB 2022b on Windows

This library has been successfully tested on various combinations of the above entries, while more tests are currently being performed to identify bugs and incompatibilities. The addition of support for Ubuntu and macOS systems, additional Dynamixel motor series, motor models, other high-level features (e.g. bulk read) and more examples is part of current work.

## Requirements

- Dynamixel C Library as included in the [Dynamixel SDK](https://github.com/ROBOTIS-GIT/DynamixelSDK)
- MATLAB 2022b with Simulink
  > While the MATLAB functions will run normally in versions prior to 2022b, the included Simulink files will require Simulink 2022b to run. Simulink files compatible with previous versions will be made available soon.

## Getting Started

To get started with the *Dynamixel library for MATLAB and Simulink*, follow these steps:

1. Download the C library folder from the [Dynamixel SDK](https://github.com/ROBOTIS-GIT/DynamixelSDK).

2. Open MATLAB, navigate to the downloaded `c` folder and select `Add to Path` with `Selected Folders and Subfolders`.

![Dynamixel_Simulink_Library_addtopath](https://user-images.githubusercontent.com/105386581/221014753-049ab95b-c9a8-47a0-b277-acb4b5bdaf0a.png)

  > Make sure that you do *not* also add the C# folder from the Dynamixel SDK, as it has been reported to cause conflicts when `initDXL.m` (see MATLAB functions below) tries to load the .dll file of the C library.

3. Clone or download the [Dynamixel Library for MATLAB and Simulink](https://github.com/geoand-robotdesign/Dynamixel-Library-Matlab-Simulink).

  > If you choose to download the library, make sure that you unzip the included folders.

4. From MATLAB, add the *Dynamixel library for MATLAB and Simulink* folders (and subfolders) to the MATLAB path.

5. Connect your Dynamixel smart motor(s) to your computer via a compatible controller ([OpenRB-150](https://emanual.robotis.com/docs/en/parts/controller/openrb-150/)) or interface ([U2D2](https://emanual.robotis.com/docs/en/parts/interface/u2d2/)). See the ROBOTIS page for more information on how to use these boards.

  > Make sure that your motor(s) are connected to an external power supply that matches the permissible input voltage. Do not connect motors with different input voltage ranges, see the ROBOTIS page of your respective motor(s) for more information.

  > Do not connect or disconnect DYNAMIXEL motors when power is being supplied.

  > When using the U2D2 interface, it is recommended to use the [U2D2 Power Hub](https://emanual.robotis.com/docs/en/parts/interface/u2d2_power_hub/).

  > When using the OpenRB-150 controller, make sure that you first upload the [usb_to_dynamixel.ino](https://github.com/ROBOTIS-GIT/OpenRB-150/tree/master/libraries/OpenRB-150/examples/usb_to_dynamixel) sketch. Please note that the OpenRB-150 with that sketch currently supports baud rates up to 1,000,000. If the Dynamixel motor(s) baud rate is set to a value higher than 1,000,000, the motor(s) will not be recognized by the controller.

6. Identify the COM port of the connected controller.

  > On Windows: You can identify the COM port via the device manager, the [Dynamixel Wizard 2.0](https://emanual.robotis.com/docs/en/software/dynamixel/dynamixel_wizard2/), or the [Arduino IDE](https://www.arduino.cc/en/software/).

7. Set all motors' baudrate to the same value.

  > Changing the baudrate for each motor can be done via the [Dynamixel Wizard 2.0](https://emanual.robotis.com/docs/en/software/dynamixel/dynamixel_wizard2/).

8. Use the provided MATLAB functions and Simulink blocks to control your Dynamixel smart actuator(s).

  > It is highly recommended that you first open and try the examples included with this MATLAB/Simulink library, as they will provide you with knowledge on how to setup and initiate motor communication, who to control the motors, troubleshoot errors, properly close the communication etc.

  > Make sure that you do not try to use the MATLAB/Simulink library while the motors are connected to the [Dynamixel Wizard 2.0](https://emanual.robotis.com/docs/en/software/dynamixel/dynamixel_wizard2/), or any other related software that establishes connection to the motors.

## Usage

The *Dynamixel library for MATLAB and Simulink* provides several functions for controlling Dynamixel smart motors from within MATLAB and Simulink. The library folders include:

### MATLAB functions

MATLAB functions that call the ROBOTIS dynamic library using C language, while providing high-level functionalities for easier control of multiple Dynamixel motors. The included MATLAB functions are:

- `bulkReadAddParamDxl`: Adds parameters for bulk read function of Dynamixel motors
- `bulkReadDxl`: Returns the acquired data from bulk read function for the connected Dynamixel motors
- `bulkReadTxRxPacket`: Executes bulk read for Dynamixel motors
- `bulkWriteAddParamDxl`: Adds parameters for bulk write function of Dynamixel motors
- `bulkWriteDxl`: Executes bulk write for Dynamixel motors
- `checkErrorDxl`: Checks for communication errors and returns the communication status of connected Dynamixel motors
- `closePortDxl`: Closes communication port with connected Dynamixel motors
- `driveModeDxl`: Changes the drive mode of connected Dynamixel motors
- `fastSyncReadDxl`: Executes fast sync read for Dynamixel motors and returns the selected read parameter
- `fastSyncReadDxlSim`: Executes fast sync read for Dynamixel Motors in Simulink
- `fastSyncWriteDxl`: Executes fast sync write for Dynamixel motors
- `fastSyncWriteDxlSim`: Executes fast sync write for Dynamixel Motors in Simulink
- `findDxl`: Finds connected dynamixels, returns their IDs and models
- `findserial`: Finds and returns connected serial (COM) ports
- `initBulkReadDxl`: Initializes the bulk read function for Dynamixel motors and returns the group numbers
- `initBulkWriteDxl`: Initializes the bulk write function for Dynamixel motors and returns the group write number
- `initDxl`: Loads C library and initializes Dynamixel communication
- `initSyncReadDxl`: Initializes the sync read function for Dynamixel motors and returns the group numbers
- `initSyncReadIndirectDxl`: Initializes the sync read function using indirect addresses of Dynamixel motors and returns the group numbers
- `initSyncWriteDxl`: Initializes the sync write function using indirect addresses of Dynamixel motors and returns the group numbers
- `initSyncWriteIndirectDxl`: Initializes the sync write function using indirect addresses of Dynamixel motors and returns the group numbers
- `lookupDxl`: Searches the control table RAM data of Dynamixel motors
- `openPortDxl`: Opens port for communication with Dynamixel motors
- `operatingModeDxl`: Changes the operating mode of Dynamixel motors
- `readDxl`: Executes read for Dynamixel motors and returns the acquired data
- `readDxlSim`: Executes read for Dynamixel motors and returns the acquired data
- `setBaudDxl`: Sets the baudrate of Dynamixel motor communication
- `setIndirectReadDxl`: Sets indirect addresses for enabling fast sync read for multiple Dynamixel motors
- `setIndirectWriteDxl`: Sets indirect addresses for enabling fast sync write for multiple Dynamixel motors
- `syncReadAddParamDxl`: Add parameter for bulk read function of Dynamixel motors
- `syncReadClearParamDxl`: Clears parameters for bulk read function of Dynamixel motors
- `syncReadDxl`: Executes sync read for Dynamixel motors and returns the acquired data
- `syncReadDxlSim`: Executes sync read for Dynamixel Motors in Simulink
- `syncWriteDxl`: Executes sync write for Dynamixel motors and returns the acquired data
- `syncWriteDxlSim`: Executes sync write for Dynamixel motors in Simulink
- `torqueDxl`: Enables or disables the torque to Dynamixel motors
- `writeDxl`: Executes write for Dynamixel motors
- `writeDxlSim`: Executes write for Dynamixel motors in Simulink

> For detailed information on these functions, please refer to the comments in the corresponding MATLAB files. 

> For examples on how to use these functions in MATLAB, please refer to the respective example files included in this library. 

> For a deeper dive into the communication protocols, check the ROBOTIS pages for protocols ([1.0](https://emanual.robotis.com/docs/en/dxl/protocol1/) and [2.0](https://emanual.robotis.com/docs/en/dxl/protocol2/)).

### Simulink Library

The Simulink library provides high-level functions for easier communication handling and control of multiple Dynamixel motors. The provided implementation is based on [level-2 MATLAB S-Functions](https://www.mathworks.com/help/simulink/sfg/writing-level-2-matlab-s-functions.html), which allow the creation of custom blocks that call the ROBOTIS dynamic library using C language in a Simulink model. Simulink's [Simulation Pacing](https://se.mathworks.com/help/simulink/ug/simulation-pacing.html) functionality allows for near real-time Dynamixel motor control, thus enabling the design and testing of higher-level robot controllers incorporating all other available Simulink's and MATLAB's toolboxes.

<img src= "https://user-images.githubusercontent.com/105386581/219953355-5d9d650f-5c9b-4359-9370-10fb0cfbf195.png" alt="Dynamixel_Simulink_Library" width="800" />

The included Simulink blocks are:

- `Read`: Library block executing the *read* instruction to one or more Dynamixel motors. The block's output is a vector whose length is equal to the number of connected Dynamixels, which contains the read results. In the current version of the library the acquired data from this block needs to be converted to *integer* values of bit-size equal to the size of the read instruction (see the *Simulink examples* for more information on how to do this, as well as the RAM Area control table provided in the [ROBOTIS](https://emanual.robotis.com/docs/en/dxl/x/xl330-m288/) emanual page for each respective motor).

 <img src= "https://user-images.githubusercontent.com/105386581/220734921-2619f89a-9e5c-441c-8ba7-5888beff024e.png" alt="Dynamixel_Simulink_Library_Read" width="400" />

- `Write`: Library block executing the *write* instruction to one or more Dynamixel motors. The block's input is a vector whose length is equal to the number of connected Dynamixels, which contains the data to write. The data sent to this block first needs to be converted to *unsigned integer* values of bit-size equal to the size of the read instruction (see the *Simulink examples* for more information on how to do this, as well as the RAM Area control table provided in the [ROBOTIS](https://emanual.robotis.com/docs/en/dxl/x/xl330-m288/) emanual page for each respective motor).

 <img src= "https://user-images.githubusercontent.com/105386581/220734776-80d58499-f15a-4e53-bef9-d1681995657f.png" alt="Dynamixel_Simulink_Library_Write" width="400" />

- `Sync Read`: Library block executing the *sync read* instruction to one or more Dynamixel motors, from the same Address and with the same length at once. The block's output is a vector whose length is equal to the number of connected Dynamixels, which contains the sync read results. The acquired data from this block needs to be converted to *integer* values of bit-size equal to the size of the read instruction (see the *Simulink examples* for more information on how to do this, as well as the RAM Area control table provided in the [ROBOTIS](https://emanual.robotis.com/docs/en/dxl/x/xl330-m288/) emanual page for each respective motor).

 <img src= "https://user-images.githubusercontent.com/105386581/220735164-fc68a354-cbdd-445f-b111-5f3fd03fc96e.png" alt="Dynamixel_Simulink_Library_SyncRead" width="400" />

- `Sync Write`: Library block executing the *sync write* instruction to one or more Dynamixel motors, on the same Address and with the same length at once. The block's input is a vector whose length is equal to the number of connected Dynamixels, which contains the data to sync write. The data sent to this block first needs to be converted to *unsigned integer* values of bit-size equal to the size of the read instruction (see the *Simulink examples* for more information on how to do this, as well as the RAM Area control table provided in the [ROBOTIS](https://emanual.robotis.com/docs/en/dxl/x/xl330-m288/) emanual page for each respective motor).

 <img src= "https://user-images.githubusercontent.com/105386581/220735025-33dd8089-ff91-4ad2-9c00-82168574c94c.png" alt="Dynamixel_Simulink_Library_SyncWrite" width="400" />

- `Fast Sync Read` (via indirect addresses): Library block executing the *sync read* instruction to one or more Dynamixel motors, from the same multiple addresses and with the same lengths at once using [indirect addresses](https://emanual.robotis.com/docs/en/software/dynamixel/dynamixel_sdk/sample_code/c_indirect_address_protocol_2_0/). As ROBOTIS states *"The indirect address links between direct and indirect data storages. This makes the Syncread and the Syncwrite function accessible to the items which are far from each other’s address"*. The block's output is a vector whose length is equal to the number of connected Dynamixels, which contains the sync read results. The acquired data from this block needs to be converted to *integer* values of bit-size equal to the size of the read instruction (see the *Simulink examples* for more information on how to do this, as well as the RAM Area control table provided in the [ROBOTIS](https://emanual.robotis.com/docs/en/dxl/x/xl330-m288/) emanual page for each respective motor).

 <img src= "https://user-images.githubusercontent.com/105386581/220735694-7e3e0e22-f671-45e2-a718-8670b453d5e4.png" alt="Dynamixel_Simulink_Library_FastSyncRead" width="400" />

- `Fast Sync Write` (via indirect addresses): Library block executing the *sync write* instruction to one or more Dynamixel motors, on the same multiple addresses and with the same lengths at once using indirect addresses. The block's input is a vector whose length is equal to the number of connected Dynamixels, which contains the data to sync write. The data sent to this block first needs to be converted to *unsigned integer* values of bit-size equal to the size of the read instruction (see the *Simulink examples* for more information on how to do this, as well as the RAM Area control table provided in the [ROBOTIS](https://emanual.robotis.com/docs/en/dxl/x/xl330-m288/) emanual page for each respective motor).

 <img src= "https://user-images.githubusercontent.com/105386581/220735573-7685be3a-6141-4554-a844-bbc102fea220.png" alt="Dynamixel_Simulink_Library_FastSyncWrite" width="400" />

- `Motor Models`: Numerical models extracted from the motors' performance graphs provided by ROBOTIS.

<img src= "https://user-images.githubusercontent.com/105386581/219953383-86ec9b01-4d77-44a5-b4fa-d9cbbb6a1390.png" alt="Dynamixel_Simulink_Library_Motor_Models" width="600" />

The performance graphs are only provided for selected motor series. These graphs include the experimentally acquired motor performance under gradually increasing loads, and describe the relationships between

- Motor current to motor torque
- Motor speed to motor torque
- Motor efficiency to motor torque

<img src= "https://user-images.githubusercontent.com/105386581/219953386-6e12b85c-f426-4154-8491-61f5f9b1383b.png" alt="Dynamixel_Simulink_Library_Motor_Models_XM430" width="400" />

(Motor images and performance graphs taken from [ROBOTIS e-Manual](https://emanual.robotis.com/docs/en/dxl/))

As ROBOTIS states *"The actual motor operation environment is closer to the performance graph, not stall torque method. For this reason, the performance graph is broadly used in the industrial field. Generally, Max Torque of the Performance Graph is less than the Stall Torque"*. Currently, the library includes the extracted models of:

- [XC430-W150](https://emanual.robotis.com/docs/en/dxl/x/xc430-w150/)
- [XM430-W350](https://emanual.robotis.com/docs/en/dxl/x/xm430-w350/)
- [XM540-W150](https://emanual.robotis.com/docs/en/dxl/x/xm540-w150/)
- [XM540-W270](https://emanual.robotis.com/docs/en/dxl/x/xm540-w270/)

> While most X series motors provide the [Present Current](https://emanual.robotis.com/docs/en/dxl/x/xc330-t181/#present-current) as feedback, which can be converted to motor torque via the respective model, motors like the XC430-W150 return the [Present Load](https://emanual.robotis.com/docs/en/dxl/x/xc430-w150/#present-load). ROBOTIS states that *"Present load is an inferred value based on the internal output value; not a measured value using torque sensor, etc. Therefore, it may be inaccurate for measuring weight or torque. It is recommended to use it for predicting the direction and size of the force being applied to the joint."*. For this reason, a simplified model for converting motor load to motor torque is provided, which maps the min/max torque values extracted from the performance graphs to the 0-100% load range.

> For detailed documentation of the Simulink library blocks, please refer to the comments in the corresponding Simulink files. 

> For examples on how to use these functions in Simulink, please refer to the respective example files included in this library. 

> For a deeper dive into the communication protocols, check the ROBOTIS pages for protocols ([1.0](https://emanual.robotis.com/docs/en/dxl/protocol1/) and [2.0](https://emanual.robotis.com/docs/en/dxl/protocol2/)).

### Examples

The *Examples* folder contains several examples of how to use the library to control Dynamixel smart actuators from within MATLAB and Simulink. These examples include:

#### MATLAB examples

The MATLAB examples included in this library are listed below:

- Protocol 1.0
  - `ReadWrite.m`: Example file executing read and write functions for one or more Dynamixel motors under Protocol 1.0 communication.
  - `ReadSyncWrite.m`: Example file executing read and sync write functions for one or more Dynamixel motors under Protocol 1.0 communication.
- Protocol 2.0
  - `ReadWrite.m`: Example file executing read and write functions for one or more Dynamixel motors under Protocol 2.0 communication.
  - `SyncReadSyncWrite.m`: Example file executing sync read and sync write functions for one or more Dynamixel motors under Protocol 2.0 communication.
  - `FastSyncReadFastSyncWrite.m`: Example file executing fast sync read and fast sync write functions for two Dynamixel motors under Protocol 2.0 communication and using indirect addresses.
The examples included in this library are listed below. For detailed documentation of these examples, please refer to the comments in the corresponding MATLAB files.

After you have performed all steps noted in the *Getting Started* section, you will need to execute the first section in the respective .m file of the example you want to run. This section opens the port, identifies the connected motors and initializes all required parameters.

If everything was done correctly, execution of that section should give you a similar result to the following image:

<img src= "https://user-images.githubusercontent.com/105386581/220471513-05f550e0-a156-4e28-b7a0-4900a35a0e0f.png" alt="Dynamixel_Simulink_Library_StartSession" width="600" />

> `SyncReadSyncWrite.m` example of controlling two different motor models of the X series under the "Extended Position Control" operating mode and the "Velocity-based Profile" drive mode.

<img src= "https://user-images.githubusercontent.com/105386581/220471381-287f91d6-16e4-44b7-9e11-8e543e467d65.png" alt="Dynamixel_Simulink_Library_Start_Session" width="600" />

> `FastSyncReadFastSyncWrite.m` example of controlling two motors via Fast Sync Read/Write by using indirect addresses. Note that the motor torques are disabled before setting the indirect data addresses.

In the case of errors, most library functions return prompts to help you identify the issues. For example, if the COM port is not set properly, the `initDXL()` function returns the communication error along with COM ports that are currently used. For example:

<img src= "https://user-images.githubusercontent.com/105386581/220377664-ce1f6849-f88a-4389-a6a6-590ea1fe54b4.png" alt="Dynamixel_Simulink_Library_COMError" width="600" />

> If the COM port assigned to your controller is not found and is not listed in that message, this usually means that the port was not closed properly during the last test. To solve this issue you will have to reset your controller.

To properly finish your tests, make sure that you execute the last section found in all example .m files (named as `End Session`) to disable motor torques and close the port.

<img src= "https://user-images.githubusercontent.com/105386581/220379243-f8b6e2ac-7f86-4d47-814e-492b69186f1b.png" alt="Dynamixel_Simulink_Library_EndSession" width="600" />

> Failing to close the port will require resetting power to your controller.

> Make sure that you disconnect from Dynamixel Wizard before using this MATLAB/Simulink library. Also, make sure that you properly end your Dynamixel connection with MATLAB/Simulink before connecting to Dynamixel Wizard or any similar software that establishes a connection to the motors.

#### Simulink examples

All Simulink examples (.slx files) are accompanied by a MATLAB (.m) file with the same name. After you have performed all steps noted in the *Getting Started* section, you will need to execute the first section in the respective .m file of the example you want to run. As in the *MATLAB examples*, this section opens the port, sets the sampling time that will be used for near real-time simulation pacing, identifies the connected motors, sets their operating and drive modes, initializes all required parameters, and opens the selected simulink file. Execution of that section should give you a similar result to the following image:

<img src= "https://user-images.githubusercontent.com/105386581/220375471-b9d9fad3-ff5a-4aeb-bead-e6d88067c6bd.png" alt="Dynamixel_Simulink_Library_Start_Session" width="600" />

At the end of that section, make sure you uncomment the .slx file you want to open, for example:

<img src= "https://user-images.githubusercontent.com/105386581/220376084-dfc615ce-1919-490b-8750-86e595cdaf17.png" alt="Dynamixel_Simulink_Library_SelectFile" width="400" />

> This step is not necessary if that file has already been opened manually

Please check the notes on the *MATLAB examples* subsection for expected outputs when executing that section, as well as notes on error handling and properly ending the session.

**%% Simulink file run and comment on real-time execution (pacing)**

As in the *MATLAB examples*, make sure that you finally execute the last section found in the respective .m files (named as `End Session`) to disable motor torques and close the port.

<img src= "https://user-images.githubusercontent.com/105386581/220379243-f8b6e2ac-7f86-4d47-814e-492b69186f1b.png" alt="Dynamixel_Simulink_Library_EndSession" width="600" />

> Failing to close the port will require resetting power to your controller.

> Make sure that you disconnect from Dynamixel Wizard before using this MATLAB/Simulink library. Also, make sure that you properly end your Dynamixel connection with MATLAB/Simulink before connecting to Dynamixel Wizard.

> To maximize performance of the Simulink programs, functions that do not usually require on-line changes during testing (setting the baudrate, changing the profile configuration between time-based and velocity profile etc.) are suggested to be set via MATLAB functions during the initialization phase, or via [Dynamixel Wizard 2.0](https://emanual.robotis.com/docs/en/software/dynamixel/dynamixel_wizard2/) prior to the Simulink tests.

> To ensure that near real-time simulation pacing is achieved, please adjust the sampling time according to the number of connected motors and the amount of data that you will be writing and/or reading. If the pacing is active, this will be noted in the left bottom edge of the Simulink window during execution, as shown below. If that message notes that pacing cannot be achieved, the sampling time will have to be increased until the warning stops.

![Screenshot 2023-02-26 224137](https://user-images.githubusercontent.com/105386581/221439275-6598b92e-7d76-4611-bd2f-010e38249d82.png)

The examples included in this library are listed below for the two communication protocols. For detailed documentation of these examples, please refer to the comments in the corresponding MATLAB and Simulink files.

- Protocol 1.0
  - **Read and Write for one or two Dynamixel motors**:
  
Examples executing the *Read* and *Write* functions for one and two motors under Protocol 1.0 communication. The motor(s) goal position is controlled via dashboard knob(s) and is sent to the motors to execute, while the present position, velocity, current/load and temperature are read and displayed. 

`ReadWrite_1Motor.slx`

<img src= "https://user-images.githubusercontent.com/105386581/221440674-8c38c894-066a-4264-a1f1-5f4d48aaedc2.png" alt="Dynamixel_Simulink_Library_Sim6" width="700" />

`ReadWrite_2Motors.slx`

<img src= "https://user-images.githubusercontent.com/105386581/221440681-83916b2c-4e35-44b8-9a99-6a2c0b251c3f.png" alt="Dynamixel_Simulink_Library_Sim7" width="700" />

  - **Read and Sync Write for one or two Dynamixel motors**:
  
Examples executing the *Read* and *Write* functions for one and two motors under Protocol 1.0 communication. The motor(s) goal position is controlled via dashboard knob(s) and is sent to the motors to execute, while the present position, velocity, current/load and temperature are read and displayed. The sync write implementation is faster than the simple write, as it handles communication on the same address and with the same length at once for all connected motors.

`ReadSyncWrite_1Motor.slx`

<img src= "https://user-images.githubusercontent.com/105386581/221440661-5e9d158f-f5c1-4811-9239-2b5c1c2c27fc.png" alt="Dynamixel_Simulink_Library_Sim8" width="700" />

`ReadSyncWrite_2Motors.slx`

<img src= "https://user-images.githubusercontent.com/105386581/221440650-29ec96f6-b14a-4e25-ab07-6c2d39a64779.png" alt="Dynamixel_Simulink_Library_Sim9" width="700" />

> In the case of multiple motors, the written and read data are all handled as vectors, with length equal to the number of connected motors. 

> As mentioned in the above *Simulink Blocks* description, the data fed into the *Write* blocks and the data acquired via the *Read* blocks must be converted to unsigned and signed integer values, respectively, of size equal to the size of the performed instructions (as stated in the motor's RAM area control table).

- Protocol 2.0

  - **Read and Write for one or two Dynamixel motors**:
  
Examples executing the *Read* and *Write* functions for one and two motors under Protocol 2.0 communication. The motors' goal position is controlled via dashboard knob(s) and is sent to the motors to execute, while the present position, velocity, current/load and temperature are read and displayed. 

`ReadWrite_1Motor.slx`

<img src= "https://user-images.githubusercontent.com/105386581/220428850-5b261873-a2c1-4229-8413-e338458b0382.png" alt="Dynamixel_Simulink_Library_Sim2" width="700" />

`ReadWrite_2Motors.slx`

<img src= "https://user-images.githubusercontent.com/105386581/220428872-c7eed34f-bacc-46f6-a546-b060b6d5afa5.png" alt="Dynamixel_Simulink_Library_Sim3" width="700" />
  
  - **Sync Read and Sync Write for one or two Dynamixel motors**:
  
Examples executing the *Sync Read* and *Sync Rrite* functions for one and two motors under Protocol 2.0 communication. The motors' goal position is controlled via dashboard knob(s) and is sent to the motors to execute, while the present position, velocity, current/load and temperature are read and displayed. This implementation is faster than the simple read and write functions, as it handles communication on the same address and with the same length at once for all connected motors.

`SyncReadSyncWrite_1Motor.slx`

<img src= "https://user-images.githubusercontent.com/105386581/220428909-d437e6a6-9fb5-4784-b713-985dbbba7aa8.png" alt="Dynamixel_Simulink_Library_Sim4" width="700" />

`SyncReadSyncWrite_2Motors.slx`

<img src= "https://user-images.githubusercontent.com/105386581/220428919-afa49586-b408-4a18-8fff-79abee54d69e.png" alt="Dynamixel_Simulink_Library_Sim5" width="700" />

  - **Fast Sync Read and Fast Sync Write for two Dynamixel motors**:

Example executing the *Fast Sync Read* and *Fast Sync Write* functions for two motors under Protocol 2.0 communication. The motors' goal position and LED status are controlled via dashboard blocks and written to the motors, while the present position, velocity, current/load and temperature are read and displayed. This implementation is faster than all previous functions, as it handles communication on the same address and with the same length at once for all connected motors using indirect addresses. In this case, the indirect addresses link the goal position and LED parameters, which are not next to each other in the RAM control table, to be written at once to all motors.

`FastSyncReadFastSyncWrite_2Motors.slx`

<img src= "https://user-images.githubusercontent.com/105386581/220428936-b19160aa-e1e1-4c49-896c-92a7142cd102.png" alt="Dynamixel_Simulink_Library_Sim1" width="700" />

> In the case of multiple motors, the written and read data are all handled as vectors, with length equal to the number of connected motors.

> As mentioned in the above *Simulink Blocks* description, the data fed into the *Write* blocks and the data acquired via the *Read* blocks must be converted to unsigned and signed integer values, respectively, of size equal to the size of the performed instructions (as stated in the motor's RAM area control table).

> Since *Present Current* and *Present Load* are assigned to the same address in the motors' RAM control table, it is handled via the unified prompt *Present Current/Load* in the `Dynamixel Read`, `Dynamixel Sync Read`, and `Dynamixel Fast Sync Read` blocks to avoid confusion. Using the prompts *Present Current* and *Present Load* will still return the same results.

## Contributing

If you find a bug or have a feature request, please open an issue in the repository. If you would like to contribute to the library, please fork the repository and submit a pull request with your changes.

## License

This library is released under the [GPL-3.0 License](https://github.com/geoand-robotdesign/Dynamixel-Library-Matlab-Simulink/blob/main/License.md). See the *License* file for more information.

## Cite as

Georgios Andrikopoulos (2022). Dynamixel Library for MATLAB and Simulink (<https://github.com/geoand-robotdesign/Dynamixel_Library_MATLAB_Simulink>), GitHub. Retrieved February 20, 2023.
