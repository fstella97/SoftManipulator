#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>

/* Set the delay between fresh samples */
#define BNO055_SAMPLERATE_DELAY_MS (20)

// Check I2C device address and correct line below (by default address is 0x29 or 0x28)
//                                   id, address
Adafruit_BNO055 bno = Adafruit_BNO055(-1, 0x28);// 29 for the MEGA
int count= 0;

int tp=0;
/**************************************************************************/
/*
    Arduino setup function (automatically called at startup)
*/
/**************************************************************************/
void setup(void)
{
  Serial.begin(115200);
 
  Serial.println("Orientation Sensor Raw Data Test"); Serial.println("");

  /* Initialise the sensor */
if(!bno.begin())
{
    /* There was a problem detecting the BNO055 ... check your connections */
Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
 while(1);
}

 delay(1000);

    
  

  /* Display the current temperature 
  int8_t temp = bno.getTemp();
  Serial.print("Current Temperature: ");
  Serial.print(temp);
  Serial.println(" C");
  Serial.println("");
*/

//Calibration for the bno
/*
adafruit_bno055_offsets_t calibData;
calibData.accel_offset_x = 9;
calibData.accel_offset_y = -51;
calibData.accel_offset_z = -26;
calibData.gyro_offset_x =-1;
calibData.gyro_offset_y =-1;
calibData.gyro_offset_z =-1;
calibData.mag_offset_x =-4;
calibData.mag_offset_y =186;
calibData.mag_offset_z =75;
calibData.accel_radius =1000;
calibData.mag_radius = 821;
bno.setSensorOffsets(calibData);
*/

adafruit_bno055_offsets_t calibData;
calibData.accel_offset_x = 5;
calibData.accel_offset_y = -38;
calibData.accel_offset_z = -43;
calibData.gyro_offset_x =-1;
calibData.gyro_offset_y =-2;
calibData.gyro_offset_z =0;
calibData.mag_offset_x =-52;
calibData.mag_offset_y =161;
calibData.mag_offset_z =-239;
calibData.accel_radius =1000;
calibData.mag_radius = 740;
bno.setSensorOffsets(calibData);

//Accelerometer: 5 -38 -43   14th Dec Data
//Gyro: -1 -2 0 
//Mag: -52 161 -239 
//Accel Radius: 1000


/*
adafruit_bno055_offsets_t calibData2;
calibData2.accel_offset_x = 1;
calibData2.accel_offset_y = -54;
calibData2.accel_offset_z = -13;
calibData2.gyro_offset_x =10;
calibData2.gyro_offset_y =-1;
calibData2.gyro_offset_z =0;
calibData2.mag_offset_x =-391;
calibData2.mag_offset_y =37;
calibData2.mag_offset_z =158;
calibData2.accel_radius =1000;
calibData2.mag_radius = 549;
bno2.setSensorOffsets(calibData2);
*/


//Accelerometer: -29 -38 -45 
//Gyro: -1 -1 0 
//Mag: -844 -583 2951 
//Accel Radius: 1000
//Mag Radius: 656


  Serial.println("Calibration status values: 0=uncalibrated, 3=fully calibrated");

/*
  /* Display calibration status for each sensor. */
  uint8_t system, gyro, accel, mag = 0;
  bno.getCalibration(&system, &gyro, &accel, &mag);
  Serial.print("CALIBRATION: Sys=");
  Serial.print(system, DEC);
  Serial.print(" Gyro=");
  Serial.print(gyro, DEC);
  Serial.print(" Accel=");
  Serial.print(accel, DEC);
  Serial.print(" Mag=");
  Serial.println(mag, DEC);


  bno.setExtCrystalUse(true);

  
}

/**************************************************************************/
/*
    Arduino loop function, called once 'setup' is complete (your own code
    should go here)
*/
/**************************************************************************/
void loop(void)
{

  // Possible vector values can be:
  // - VECTOR_ACCELEROMETER - m/s^2
  // - VECTOR_MAGNETOMETER  - uT
  // - VECTOR_GYROSCOPE     - rad/s
  // - VECTOR_EULER         - degrees
  // - VECTOR_LINEARACCEL   - m/s^2
  // - VECTOR_GRAVITY       - m/s^2
//  imu::Vector<3> euler = bno.getVector(Adafruit_BNO055::VECTOR_EULER);
 // imu::Vector<3> euler2 = bno2.getVector(Adafruit_BNO055::VECTOR_EULER);

  /* Display the floating point data */
  /*
  Serial.print("X: ");
  Serial.print(euler.x());
  Serial.print(" Y: ");
  Serial.print(euler.y());
  Serial.print(" Z: ");
  Serial.print(euler.z());
  Serial.print("\t\t");
*/


  // Quaternion data
  imu::Quaternion quat = bno.getQuat();

  //Serial.print(millis());
  //Serial.print(",");
 // Serial.print("qWT: ");
  Serial.print(quat.w(), 4);
  Serial.print(",");
  Serial.print(quat.x(), 4);
  Serial.print(",");
  Serial.print(quat.y(), 4);
  Serial.print(",");
  Serial.print(quat.z(), 4);
  Serial.println(",");


    
  
/*
  if(count !=10){
  //delay(2);
  }
  else{
    //delay(1);
    count = 0;
  }

  count++;
  */
}
