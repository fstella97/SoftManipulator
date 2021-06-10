%%IMU connection implementation
clear all
clc
a = arduino('COM7', 'Due', 'Libraries', 'I2C');

writeDigitalPin(a, 'D2', 1);
writeDigitalPin(a, 'D3', 1);

fs = 100; % Sample Rate in Hz   
imu = mpu9250(a,'SampleRate',fs,'OutputFormat','matrix') 
imu2 = mpu9250(a,'SampleRate',fs,'OutputFormat','matrix') 
GyroscopeNoiseMPU9250 = 3.0462e-06; % GyroscopeNoise (variance) in units of rad/s
AccelerometerNoiseMPU9250 = 0.0061; % AccelerometerNoise (variance) in units of m/s^2
viewer = HelperOrientationViewer('Title',{'IMU Filter'});
FUSE = imufilter('SampleRate',imu.SampleRate, 'GyroscopeNoise',GyroscopeNoiseMPU9250,'AccelerometerNoise', AccelerometerNoiseMPU9250);

while 1
writeDigitalPin(a, 'D50', 0);
writeDigitalPin(a, 'D52', 1);
writeDigitalPin(a, 'D53', 1);
[accel1,gyro1] = readSensorDataMPU9250(imu);
rotators = FUSE(accel1,gyro1)
writeDigitalPin(a, 'D50', 1);
writeDigitalPin(a, 'D52', 0);
writeDigitalPin(a, 'D53', 0);
[accel2,gyro2] = readSensorDataMPU9250(imu);
rotators = FUSE(accel2,gyro2)
writeDigitalPin(a, 'D50', 1);
writeDigitalPin(a, 'D52', 1);
writeDigitalPin(a, 'D53', 0);
[accel3,gyro3] = readSensorDataMPU9250(imu);
rotators = FUSE(accel3,gyro3)

end

%%
GyroscopeNoiseMPU9250 = 3.0462e-06; % GyroscopeNoise (variance) in units of rad/s
AccelerometerNoiseMPU9250 = 0.0061; % AccelerometerNoise (variance) in units of m/s^2
viewer = HelperOrientationViewer('Title',{'IMU Filter'});
FUSE = imufilter('SampleRate',imu.SampleRate, 'GyroscopeNoise',GyroscopeNoiseMPU9250,'AccelerometerNoise', AccelerometerNoiseMPU9250);
stopTimer=100;

% Use imufilter to estimate orientation and update the viewer as the
% sensor moves for time specified by stopTimer

while(1)
    [accel,gyro] = readSensorDataMPU9250(imu);
    rotators = FUSE(accel,gyro);
    for j = numel(rotators)
        viewer(rotators(j));
    end
end

release(imu);
delete(imu);
clear;