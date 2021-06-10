%%IMU connection implementation
clear all
a = arduino('COM7', 'Due', 'Libraries', 'I2C');

fs = 100; % Sample Rate in Hz   
imu = mpu9250(a,'SampleRate',fs,'OutputFormat','matrix'); 

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