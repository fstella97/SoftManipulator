/*
  Analog Input

  Demonstrates analog input by reading an analog sensor on analog pin 0 and
  turning on and off a light emitting diode(LED) connected to digital pin 13.
  The amount of time the LED will be on and off depends on the value obtained
  by analogRead().

  The circuit:
  - potentiometer
    center pin of the potentiometer to the analog input 0
    one side pin (either one) to ground
    the other side pin to +5V
  - LED
    anode (long leg) attached to digital output 13 through 220 ohm resistor
    cathode (short leg) attached to ground

  - Note: because most Arduinos have a built-in LED attached to pin 13 on the
    board, the LED is optional.

  created by David Cuartielles
  modified 30 Aug 2011
  By Tom Igoe

  This example code is in the public domain.

  https://www.arduino.cc/en/Tutorial/BuiltInExamples/AnalogInput
*/

int sensorPin1 = A0;    // select the input pin for the potentiometer
int sensorPin2 = A1;
int sensorPin3 = A2;

double sensorValue1 = 0;  // variable to store the value coming from the sensor
double sensorValue2 = 0;  
double sensorValue3 = 0;  
double bar1=0;
double bar2=0;
double bar3=0;

double ana_step=0.0048875855;

double Rw=0.1772;
double Ry=0.1774;
double Rg=0.1775;


void setup() {

  Serial.begin(9600);//115200
}

void loop() {
  // read the value from the sensor:
  sensorValue1 = analogRead(sensorPin1);
  sensorValue2 = analogRead(sensorPin2);
  sensorValue3 = analogRead(sensorPin3);


double check1=sensorValue1*ana_step/Rw;
 bar1=((sensorValue1*ana_step/Rw)-4)/4;
 bar2=((sensorValue2*ana_step/Ry)-4)/4;
 bar3=((sensorValue3*ana_step/Rg)-4)/4;

 
  Serial.print(bar1);
  Serial.print(",");
  Serial.print(bar2);
  Serial.print(",");
  Serial.print(bar3);
Serial.println(",");
  
  
}
