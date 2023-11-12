import processing.serial.*; //used to comunicate with arduino

Serial serial; //class to use serial comunication protocol

// The setup function has the same features of arduino
void setup() {
  size(400,600); //This function creates a new window that we use to controll the robotic arm with mouse and keyboard
  background(100); //Sets the color for the new window
  
  //Now we want to print all the current doors that are being used to know on which of this we have to send the output
  //and we use it for the serial comunication with arduino
  for (int i = 0; i < Serial.list().length; i++) {
    print(i + " ");
    println(Serial.list()[i]);
  }
   String pname = Serial.list()[0];
  serial = new Serial(this, pname, 9600);
}

// The draw function has the same features of loop arduino's function
void draw(){
  }

//Processing use this function when we use the mouse wheel and puts in event.getCount() positive or negative numbers depending on mouse wheel rotation direction
void mouseWheel(MouseEvent event) {
  int segno = event.getCount();
  serial.write("r" + segno); //write in the serial the number given by event.getCount()
  println(segno);
}

//Processing use this function when a keyboard key is pressed and it saves it in key
void keyPressed() {
  if ('1' <= key && key <= '6') {  
    serial.write("k" + key);
    println(key);
  }
  else 
    println("Il carattere inserito non è valido");
}
