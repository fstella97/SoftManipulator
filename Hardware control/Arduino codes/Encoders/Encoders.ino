#include <Wire.h>
//#include <Adafruit_MotorShield.h>

//Adafruit_MotorShield AFMS = Adafruit_MotorShield(); // What is connection between the motor shield and the encoders, I tought they were controlled by 2 different arduinos. 

const byte ledPin = 13;
const byte enc0 = 22; // Digital pins (with interrupt) ok 
const byte enc1 = 26;// ok 
const byte enc2 = 30;
const byte enc0B =24;
const byte enc1B = 28;
const byte enc2B = 32;

volatile byte state = LOW;
volatile int offset = 500000; //(to remove positive and negative) 
volatile unsigned int encoder0Pos = 0;
volatile unsigned int encoder1Pos = 0;
volatile unsigned int encoder2Pos = 0;

volatile unsigned int demandA = 0;
volatile unsigned int demandB = 0;
volatile unsigned int demandC = 0;

int a =0;
int r =0;
int mspeed = 0;
int pconst = 2;
int minspeed = 30;
int error =0;

String serialResponse = "";
char sz[] = "Here; is some; sample;100;data;1.414;1020";
String num = "";

// to control motors 
//Adafruit_DCMotor *motorA = AFMS.getMotor(1);
//Adafruit_DCMotor *motorB = AFMS.getMotor(2);
//Adafruit_DCMotor *motorC = AFMS.getMotor(3);

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(enc0, INPUT_PULLUP);
  pinMode(enc1, INPUT_PULLUP);
  pinMode(enc2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(enc0), blink, CHANGE); // count0 instead of blink
  attachInterrupt(digitalPinToInterrupt(enc1), blink, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc2), blink, CHANGE);
  pinMode(enc0B, INPUT_PULLUP);
  pinMode(enc1B, INPUT_PULLUP);
  pinMode(enc2B, INPUT_PULLUP);
  
 Serial.begin(9600);
// AFMS.begin();  
 //motorA->setSpeed(110);
 //motorB->setSpeed(110);
 //motorC->setSpeed(110);  

   // motorA->run(RELEASE);
encoder0Pos = offset;
encoder1Pos = offset;


void blink() {
  state = !state;
}
