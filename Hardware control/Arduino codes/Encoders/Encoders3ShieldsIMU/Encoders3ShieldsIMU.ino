#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>

#define BNO055_SAMPLERATE_DELAY_MS (100)
Adafruit_BNO055 bno = Adafruit_BNO055(-1, 0x28);//
int count= 0;
int tp=0;

const byte ledPin = 13;

const byte enc0 = 30;
const byte enc0B =31;
const byte enc1 = 32;
const byte enc1B = 33;
const byte enc2 = 34;
const byte enc2B = 35;

const byte enc3 = 14;
const byte enc3B =15;
const byte enc4 = 38;
const byte enc4B = 39;
const byte enc5 = 40;
const byte enc5B = 41;


const byte enc6 = 42;
const byte enc6B =43;
const byte enc7 = 44;
const byte enc7B = 45;
const byte enc8 = 46;
const byte enc8B = 47;

volatile byte state = LOW;
volatile int  offset = 500000;
volatile unsigned int encoder0Pos = 0;
volatile unsigned int encoder1Pos = 0;
volatile unsigned int encoder2Pos = 0;
volatile unsigned int encoder3Pos = 0;
volatile unsigned int encoder4Pos = 0;
volatile unsigned int encoder5Pos = 0;
volatile unsigned int encoder6Pos = 0;
volatile unsigned int encoder7Pos = 0;
volatile unsigned int encoder8Pos = 0;

volatile unsigned int demandA = 0;
volatile unsigned int demandB = 0;
volatile unsigned int demandC = 0;
volatile unsigned int demandD = 0;
volatile unsigned int demandE = 0;
volatile unsigned int demandF = 0;
volatile unsigned int demandG = 0;
volatile unsigned int demandH = 0;
volatile unsigned int demandI = 0;

int a =0;
int r =0;
int mspeed = 0;
int pconst = 2;
int minspeed = 30;
int error =0;


void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(enc0, INPUT_PULLUP);
  pinMode(enc1, INPUT_PULLUP);
  pinMode(enc2, INPUT_PULLUP);
  pinMode(enc3, INPUT_PULLUP);
  pinMode(enc4, INPUT_PULLUP);
  pinMode(enc5, INPUT_PULLUP);
  pinMode(enc6, INPUT_PULLUP);
  pinMode(enc7, INPUT_PULLUP);
  pinMode(enc8, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(enc0), count0, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc1), count1, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc2), count2, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc3), count3, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc4), count4, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc5), count5, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc6), count6, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc7), count7, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc8), count8, CHANGE);
  pinMode(enc0B, INPUT_PULLUP);
  pinMode(enc1B, INPUT_PULLUP);
  pinMode(enc2B, INPUT_PULLUP);
  pinMode(enc3B, INPUT_PULLUP);
  pinMode(enc4B, INPUT_PULLUP);
  pinMode(enc5B, INPUT_PULLUP);
  pinMode(enc6B, INPUT_PULLUP);
  pinMode(enc7B, INPUT_PULLUP);
  pinMode(enc8B, INPUT_PULLUP);
  
  
 Serial.begin(115200);//115200

 Serial.println("Orientation Sensor Raw Data Test"); Serial.println("");

  /* Initialise the sensor */
  if(!bno.begin())
  {
    /* There was a problem detecting the BNO055 ... check your connections */
    Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
    while(1);
  }


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


encoder0Pos = offset;
encoder1Pos = offset;
encoder2Pos = offset;
encoder3Pos = offset;
encoder4Pos = offset;
encoder5Pos = offset;
encoder6Pos = offset;
encoder7Pos = offset;
encoder8Pos = offset;
}

void loop() {
printenc();    

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
  }

//


  
void count0(){
 if (digitalRead(enc0) == HIGH) {  
    if(digitalRead(enc0B) == LOW){
      encoder0Pos = encoder0Pos + 1;
    }
    else
    {
      encoder0Pos = encoder0Pos - 1;
    }
}
 if(digitalRead(enc0) == LOW){
    if(digitalRead(enc0B) == LOW){
      encoder0Pos = encoder0Pos - 1;
    }
    else
    {
      encoder0Pos = encoder0Pos + 1;
    }
 }
 //Serial.println(encoder0Pos,DEC);
}

void count1(){
 if (digitalRead(enc1) == HIGH) {  
    if(digitalRead(enc1B) == LOW){
      encoder1Pos = encoder1Pos + 1;
    }
    else
    {
      encoder1Pos = encoder1Pos - 1;
    }
}
 if(digitalRead(enc1) == LOW){
    if(digitalRead(enc1B) == LOW){
      encoder1Pos = encoder1Pos - 1;
    }
    else
    {
      encoder1Pos = encoder1Pos + 1;
    }
 }
 //Serial.println(encoder1Pos,DEC);
}


void count2(){
 if (digitalRead(enc2) == HIGH) {  
    if(digitalRead(enc2B) == LOW){
      encoder2Pos = encoder2Pos - 1;
    }
    else
    {
      encoder2Pos = encoder2Pos + 1;
    }
}
 if(digitalRead(enc2) == LOW){
    if(digitalRead(enc2B) == LOW){
      encoder2Pos = encoder2Pos + 1;
    }
    else
    {
      encoder2Pos = encoder2Pos - 1;
    }
 }
 //Serial.println(encoder2Pos,DEC);
}


void count3(){
 if (digitalRead(enc3) == HIGH) {  
    if(digitalRead(enc3B) == LOW){
      encoder3Pos = encoder3Pos + 1;
    }
    else
    {
      encoder3Pos = encoder3Pos - 1;
    }
}
 if(digitalRead(enc3) == LOW){
    if(digitalRead(enc3B) == LOW){
      encoder3Pos = encoder3Pos - 1;
    }
    else
    {
      encoder3Pos = encoder3Pos + 1;
    }
 }
 //Serial.println(encoder0Pos,DEC);
}


void count4(){
 if (digitalRead(enc4) == HIGH) {  
    if(digitalRead(enc4B) == LOW){
      encoder4Pos = encoder4Pos + 1;
    }
    else
    {
      encoder4Pos = encoder4Pos - 1;
    }
}
 if(digitalRead(enc4) == LOW){
    if(digitalRead(enc4B) == LOW){
      encoder4Pos = encoder4Pos - 1;
    }
    else
    {
      encoder4Pos = encoder4Pos + 1;
    }
 }
 //Serial.println(encoder0Pos,DEC);
}

void count5(){
 if (digitalRead(enc5) == HIGH) {  
    if(digitalRead(enc5B) == LOW){
      encoder5Pos = encoder5Pos + 1;
    }
    else
    {
      encoder5Pos = encoder5Pos - 1;
    }
}
 if(digitalRead(enc5) == LOW){
    if(digitalRead(enc5B) == LOW){
      encoder5Pos = encoder5Pos - 1;
    }
    else
    {
      encoder5Pos = encoder5Pos + 1;
    }
 }
 //Serial.println(encoder0Pos,DEC);
}

void count6(){
 if (digitalRead(enc6) == HIGH) {  
    if(digitalRead(enc6B) == LOW){
      encoder6Pos = encoder6Pos + 1;
    }
    else
    {
      encoder6Pos = encoder6Pos - 1;
    }
}
 if(digitalRead(enc6) == LOW){
    if(digitalRead(enc6B) == LOW){
      encoder6Pos = encoder6Pos - 1;
    }
    else
    {
      encoder6Pos = encoder6Pos + 1;
    }
 }
 //Serial.println(encoder0Pos,DEC);
}

void count7(){
 if (digitalRead(enc7) == HIGH) {  
    if(digitalRead(enc7B) == LOW){
      encoder7Pos = encoder7Pos + 1;
    }
    else
    {
      encoder7Pos = encoder7Pos - 1;
    }
}
 if(digitalRead(enc7) == LOW){
    if(digitalRead(enc7B) == LOW){
      encoder7Pos = encoder7Pos - 1;
    }
    else
    {
      encoder7Pos = encoder7Pos + 1;
    }
 }
 //Serial.println(encoder0Pos,DEC);
}

void count8(){
 if (digitalRead(enc8) == HIGH) {  
    if(digitalRead(enc8B) == LOW){
      encoder8Pos = encoder8Pos + 1;
    }
    else
    {
      encoder8Pos = encoder8Pos - 1;
    }
}
 if(digitalRead(enc8) == LOW){
    if(digitalRead(enc8B) == LOW){
      encoder8Pos = encoder8Pos - 1;
    }
    else
    {
      encoder8Pos = encoder8Pos + 1;
    }
 }
 //Serial.println(encoder0Pos,DEC);
}

void printenc(){
// Serial.print(millis());
//Serial.print(" ");
Serial.print(0);
Serial.print(" ");
Serial.print(encoder0Pos);
Serial.print(" ");
Serial.print(encoder1Pos);
Serial.print(" ");
Serial.print(encoder2Pos); 
Serial.print(" ");
Serial.print(encoder3Pos); 
Serial.print(" ");
Serial.print(encoder4Pos); 
Serial.print(" ");
Serial.print(encoder5Pos); 
Serial.print(" ");
Serial.print(encoder6Pos); 
Serial.print(" ");
Serial.print(encoder7Pos); 
Serial.print(" ");
Serial.print(encoder8Pos); 
}


void reset(){
encoder8Pos =0;
encoder7Pos = 0;
encoder6Pos = 0; 
encoder5Pos =0;
encoder4Pos = 0;
encoder3Pos = 0; 
encoder2Pos =0;
encoder1Pos = 0;
encoder0Pos = 0; 

}
