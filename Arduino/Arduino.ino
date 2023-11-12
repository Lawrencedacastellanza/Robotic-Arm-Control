#define MAX_EASING_SERVOS 6  // Max number of "servo" objects
#define ENABLE_EASE_QUADRATIC
//#define ENABLE_EASE_CUBIC
//#define ENABLE_EASE_QUARTIC
//#define ENABLE_EASE_SINE
//#define ENABLE_EASE_CIRCULAR
//#define EASE_BACK
//#define EASE_ELASTIC
//#define EASE_BOUNCE
//#define EASE_USER

#include <ServoEasing.hpp>

ServoEasing Servo0; //initializing Servo motors
ServoEasing Servo1;
ServoEasing Servo2;
ServoEasing Servo3;
ServoEasing Servo4;
ServoEasing Servo5;

short unsigned int vel = 50;

void setup() {
  Serial.begin(9600);
  
  Serial.setTimeout(100);
  
  Servo0.attach(11, 90, 600, 2400, 0, 180);
  Servo1.attach(, 90, 600, 2400, 0, 180);
  Servo2.attach(9, 90, 600, 2400, 0, 180);
  Servo3.attach(6, 90, 600, 2400, 0, 180);
  Servo4.attach(5, 90, 600, 2400, 0, 180);
  Servo5.attach(3, 90, 600, 2400, 0, 180);
  
  Serial.println("Pronto!");
  setEasingTypeForAllServos(EASE_QUADRATIC_IN_OUT);  // setting acceleration for all the servo motors (the library allows to do it for each servo)
  setSpeedForAllServos(vel);                          // setting speed for all the servo motors (the library allows to do it for each servo)
  setEaseToForAllServos();                           // programming the movement for servo motors
}

int numeroServo = 0;
int incomingByte;

void loop() {
  if (Serial.available() > 0) {       //Checking the result of the serial
    incomingByte = Serial.read();     
    if (incomingByte == 'k') {        //If the serial returns "k", followed by a number between 1 and 6, the program switchs servo
      numeroServo = Serial.parseInt()-1;
    } else if (incomingByte == 'a') {   //If the serial returns "a", followed by a number, 
      int angolo = Serial.parseInt();   //it moves the selected servo to the requested angle
      ServoEasing::ServoEasingNextPositionArray[numeroServo] = angolo;
      setEaseToForAllServosSynchronizeAndStartInterrupt();
    } else if (incomingByte == 'r') {    //if returned "r", it keeps moving the servo in a relative angle
      int relativo = Serial.parseInt();
      ServoEasing::ServoEasingNextPositionArray[numeroServo] += relativo;
      setEaseToForAllServosSynchronizeAndStartInterrupt();
    }
  }
}
