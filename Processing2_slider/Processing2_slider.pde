/**  Processing code controlling a 6DOF robot arm using 6 graphical sliders.  **/

// Import libraries
import controlP5.*; // controlP5 library for GUI
import processing.serial.*; // serial library for serial communication

// Declare objects
Serial serial;
ControlP5 gui;
PImage img;

void setup() {
  // List all available serial ports
  for (int i = 0; i < Serial.list().length; i++) {
    println(i + " " + Serial.list()[i]);
  }

  // Select the first serial port
  //String pname = Serial.list()[0];
//  serial = new Serial(this, pname, 9600);

  // Create a window with a fixed size
  size(1350, 960);
  // Load the background an image
  img = loadImage("robotArm.png");

  noStroke(); // No outline for the sliders
  rectMode(CENTER); // Set coordinates reference to the center of the object

  // Initialize the GUI object
  gui = new ControlP5(this);

  // Create 6 round sliders (named from 1 to 6)
  // parameters: name, min bound, max bound, default value, x, y, diameter
  gui.addKnob("1", 0, 180, 90, 310, 600, 90);
  gui.addKnob("2", 0, 180, 90, 390, 480, 90);
  gui.addKnob("3", 0, 180, 90, 420, 170, 90);
  gui.addKnob("4", 0, 180, 90, 740, 50, 90);
  gui.addKnob("5", 0, 180, 90, 850, 140, 90);
  gui.addKnob("6", 0, 180, 90, 870, 340, 90);
}

// Executed in an infinite loop
void draw() {
  background(255); // White as background colour
  image(img, 0, 0);  // Display the background image
}

// Events triggered by controllers are automatically forwarded to the controlEvent method.
// So this method is called every time a slider is moved
void controlEvent(ControlEvent theEvent) {
  /* Check if the event is from a controller otherwise we'll get an error
   when clicking other interface elements which don't support */
  if (theEvent.isController()) {
    // Get the value of the controller moved and round it to the nearest integer
    int angle = round(theEvent.getController().getValue());

    // Get the name of the controller and convert it to an int
    int servoNum = parseInt(theEvent.getController().getName());

    // Arduino code expects a string of the form kXaY where X is the number of the servo and Y is the angle
    // We send it via the serial port
    serial.write("k" + servoNum + "a" + angle);
    // println("k" + servoNum + "a" + angle);

    /*
        switch(theEvent.getController().getName())
     {
     case "S1":
     serial.write("k1a" + val);
     break;
     
     case "S2":
     serial.write("k2a" + val);
     break;
     
     case "S3":
     serial.write("k3a" + val);
     break;
     
     case "S4":
     serial.write("k4a" + val);
     break;
     
     case "S5":
     serial.write("k5a" + val);
     break;
     
     case "S6":
     serial.write("k6a" + val);
     break;
     }*/
  }
}
