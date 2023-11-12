// Import libraries
import controlP5.*; // import controlP5 library
import processing.serial.*;

// Declare objects
Serial serial;
ControlP5 controlP5; // controlP5 object
PImage img; // Pimage object

void setup() {
  for (int i = 0; i < Serial.list().length; i++) {
    print(i + " ");
    println(Serial.list()[i]);
  }

  String pname = Serial.list()[0];
  serial = new Serial(this, pname, 9600);

  //Load the logo image
  img = loadImage("AEAlogo2.jpg");
  img.resize(400, 400);

  size(1000, 800, P3D); // create a 3D screen
  noStroke(); //We take the edges off the figures
  rectMode(CENTER); // Modifies the location from which rectangles are drawn

  // Initialize the cpmtrolP5 object
  controlP5 = new ControlP5(this);

  //Create 6 round sliders (named from 1 to 6)
  //parameters : name, minimum, maximum, default value (float, x, y, diameter
  controlP5.addKnob("S1", 0, 180, 90, 850, 100, 100);
  controlP5.addKnob("S2", 0, 180, 90, 850, 200, 100);
  controlP5.addKnob("S3", 0, 180, 90, 850, 300, 100);
  controlP5.addKnob("S4", 0, 180, 90, 850, 400, 100);
  controlP5.addKnob("S5", 0, 180, 90, 850, 500, 100);
  controlP5.addKnob("S6", 0, 180, 90, 850, 600, 100);
}

int S1 = 90;
int S2 = 90;
int S3 = 90;
int S4 = 90;
int S5 = 90;
int S6 = 90;

// Events triggered by controllers are automatically forwarded to the controlEvent method.
// So this method is called EVERY TIME a slider is moved

void controlEvent(ControlEvent theEvent) {
  /*Check if the event is from a controller otherwise we'll get an error
   when clicking other interface elements which don't support */

  if (theEvent.isController()) {
    // Get the value of the controller moved and round it to the nearest integer
    int val = round(theEvent.getController().getValue());

    //this switch assing the value of the controller moved to its variable
    //we will use this parameter TO ROTATE the 3D rappresentation
    switch(theEvent.getController().getName())
    {
    case "S1":
      S1 = val;
      serial.write("k1a" + val);
      break;

    case "S2":
      S2 = val;
      serial.write("k2a" + val);
      break;

    case "S3":
      S3 = val;
      serial.write("k3a" + val);
      break;

    case "S4":
      S4 = val;
      serial.write("k4a" + val);
      break;

    case "S5":
      S5 = val;
      serial.write("k5a" + val);
      break;

    case "S6":
      S6 = val;
      serial.write("k6a" + val);
      break;
    }
  }
}
// Executed in an infinite loop
void draw() {
  //sets
  background(255);
  //lights();
  //ambientLight(0,0,255,0,0,255);

  // Adds a point light.
  pointLight(255, 255, 255, width / 2, height / 2, 1000); // Adds a point light pointLight(R,G,B,x,y,z)

  // We start by moving the origin of the axes
  translate(400, 630, 0); // translate(x, y, z);

  fill(40, 40, 40); // Sets an rgb color for the shapes that will later be created
  box(200, 60, 200); // box(w, h, d);  creates a box with the center on the origin of the axis

  fill(255);

  // Create the rectangle to support the logo
  beginShape(); // This functions allows creating more complex shapes (defined by a series of vertices)
  texture(img);
  vertex(-99, -29, 100, 0, 0);
  vertex(99, -29, 100, 400, 0);
  vertex(99, 29, 100, 400, 400); // Vertex(x, y, z, u, v); u,v resize the x and y of the texture
  vertex(-99, 29, 100, 0, 400);
  endShape(CLOSE); // End of modelling

  // Create all the parts of the robotics arm
  translate(0, -30, 0);
  fill(255, 117, 20);  // Set the colour of the sphere
  sphere(20);
  rotateY((S1 - 90) * PI / 180); //  0<S1<180 (for the knobs structure) because we send to the servo motors
  // the absolute and not relative value of the angle but we have to totate the y-axis from -90°<degrees<90°
  // so we subtract 90 from S1 and we turn it into radians.

  // PAY ATTENTION: The functions translation and rotation act on the origin of the axes so
  // the rotation of the axis will cause the rotation of all the figures that will be created
  // we must use a bottom-up approach in the creation of the figures

  // Creation of the second actuator
  translate(0, -50, 0);
  fill(100, 100, 100);
  box(30, 60, 30);
  translate(0, -50, 0);
  fill(255, 117, 20);
  sphere(20);
  rotateX((S2 - 90) * PI / 180);

  // Creation of the third actuator
  translate(0, -50, 0);
  fill(100, 100, 100);
  box(30, 60, 30);
  translate(0, -50, 0);
  fill(255, 117, 20);
  sphere(20);
  rotateX((S3 - 90) * PI / 180);

  // Creation of the fourth actuator
  translate(0, -50, 0);
  fill(100, 100, 100);
  box(30, 60, 30);
  translate(0, -50, 0);
  fill(255, 117, 20);
  sphere(20);
  rotateX((S4 - 90) * PI / 180);

  // Creation of the fifth actuator
  translate(0, -50, 0);
  fill(100, 100, 100);
  box(30, 60, 30);
  translate(0, -50, 0);
  fill(255, 117, 20);
  sphere(20);
  rotateY((S5 - 90) * PI / 180);

  // Creation of the sixth actuator
  translate(0, -20, 0);
  fill(100, 100, 100);
  box(30, 20, 30);
  translate(0, -20, 0);
  fill(255, 117, 20);
  sphere(20);

  // Creation of the gripper left part
  rotateZ(-PI / 3 - ((S6 - 90) * PI / 180) / 9); // We limit the motion of the gripper servo otherwise the two parts of the gripper wouldn't match up exactly
  translate(0, -30, 0);
  fill(100, 100, 100);
  box(20, 80, 20);
  translate(0, -30, 0);
  rotateZ(2 * PI / 4);
  translate(0, -30, 0);
  fill(100, 100, 100);
  box(20, 60, 20);

  // We move the origin of the axis back to the center of the gripper
  translate(0, 30, 0);
  rotateZ(-2 * PI / 4);
  translate(0, 60, 0);
  rotateZ(PI / 3 + ((S6 - 90) * PI / 180) / 9);

  // Creation of the gripper right part
  rotateZ(PI / 3 + ((S6 - 90) * PI / 180) / 9);
  translate(0, -30, 0);
  fill(100, 100, 100);
  box(20, 80, 20);
  translate(0, -30, 0);
  rotateZ(-2 * PI / 4);
  translate(0, -30, 0);
  fill(100, 100, 100);
  box(20, 60, 20);

  // We move the origin of the axis back to the center of the gripper
  translate(0, 30, 0);
  rotate(2 * PI / 4);
  translate(0, 60, 0);
  rotateZ(-PI / 3 - ((S6 - 90) * PI / 180) / 9);


  // We bring the axes back to the original position to prevent knobs from being in a different position than they should be
  translate(0, 40, 0);
  rotateY(-(S5 - 90) * PI / 180);
  translate(0, 100, 0);
  rotateX(-(S4 - 90) * PI / 180);
  translate(0, 100, 0);
  rotateX(-(S3 - 90) * PI / 180);
  translate(0, 100, 0);
  rotateX(-(S2 - 90) * PI / 180);
  translate(0, 100, 0);
  rotateY(-(S1 - 90) * PI / 180);
  translate(-400, -600, 0);
}
