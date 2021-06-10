#include <Wire.h>

const byte ledPin = 13;

const byte enc0 = 30;
const byte enc0B =31;
const byte enc1 = 32;
const byte enc1B = 33;
const byte enc2 = 34;
const byte enc2B = 35;

volatile byte state = LOW;
volatile int  offset = 500000;
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

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(enc0, INPUT_PULLUP);
  pinMode(enc1, INPUT_PULLUP);
  pinMode(enc2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(enc0), count0, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc1), count1, CHANGE);
  attachInterrupt(digitalPinToInterrupt(enc2), count2, CHANGE);
  pinMode(enc0B, INPUT_PULLUP);
  pinMode(enc1B, INPUT_PULLUP);
  pinMode(enc2B, INPUT_PULLUP);
  
 Serial.begin(9600);//9600

encoder0Pos = offset;
encoder1Pos = offset;
encoder2Pos = offset;
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


void printenc(){
// Serial.print(millis());
//Serial.print(" ");
Serial.print(encoder0Pos);
Serial.print(" ");
Serial.print(encoder1Pos);
Serial.print(" ");
Serial.println(encoder2Pos); 
}


void reset(){

encoder2Pos =0;
encoder1Pos = 0;
encoder0Pos = 0; 

}
