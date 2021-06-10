#include <Wire.h>

const byte ledPin = 13;
const byte enc0 = 22;
const byte enc1 = 28;
const byte enc2 = 30;
const byte enc0B =26;
const byte enc1B = 24;
const byte enc2B = 32;

const byte enc3 = 52;
const byte enc4 = 48;
const byte enc5 = 44;
const byte enc3B =50;
const byte enc4B = 46;
const byte enc5B = 42;

volatile byte state = LOW;
volatile int  offset = 500000;
volatile unsigned int encoder0Pos = 0;
volatile unsigned int encoder1Pos = 0;
volatile unsigned int encoder2Pos = 0;
volatile unsigned int encoder3Pos = 0;
volatile unsigned int encoder4Pos = 0;
volatile unsigned int encoder5Pos = 0;

volatile unsigned int demandA = 0;
volatile unsigned int demandB = 0;
volatile unsigned int demandC = 0;
volatile unsigned int demandD = 0;
volatile unsigned int demandE = 0;
volatile unsigned int demandF = 0;

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
  attachInterrupt(digitalPinToInterrupt(enc0), count0, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc1), count1, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc2), count2, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc3), count3, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc4), count4, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc5), count5, CHANGE);
  pinMode(enc0B, INPUT_PULLUP);
  pinMode(enc1B, INPUT_PULLUP);
  pinMode(enc2B, INPUT_PULLUP);
  pinMode(enc3B, INPUT_PULLUP);
  pinMode(enc4B, INPUT_PULLUP);
  pinMode(enc5B, INPUT_PULLUP);
  
 Serial.begin(9600);//9600- 4800

encoder0Pos = offset;
encoder1Pos = offset;
encoder2Pos = offset;
encoder3Pos = offset;
encoder4Pos = offset;
encoder5Pos = offset;
}

void loop() {
printenc();    
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
void printenc(){
// Serial.print(millis());
//Serial.print(" ");
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
Serial.println(encoder5Pos); 
}


void reset(){

encoder2Pos =0;
encoder1Pos = 0;
encoder0Pos = 0; 

}
