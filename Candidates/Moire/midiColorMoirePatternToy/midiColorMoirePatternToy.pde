import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

void setup() {
  //size(600, 400);
  fullScreen();
   MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  
  smooth();
  noStroke();
}

void draw() {
  float r3 = map(cc[21], 0,127,0,255);
  float g3 = map(cc[22], 0,127,0,255);
  float b3 = map(cc[23], 0,127,0,255);
  background(r3,g3,b3);
    float r1 = map(cc[0], 0,127,0,255);
  float g1 = map(cc[1], 0,127,0,255);
  float b1 = map(cc[2], 0,127,0,255);
  float a1 = map(cc[3], 0,127,0,255);
  fill(r1,g1,b1,a1);
  pushMatrix();  // save things for the background pattern
    translate(width/2, height/2); 
    float ts = map(cc[16],0,width,200,1600);
       rotate(TWO_PI * frameCount/ts);  // rotate over time// move to middle of screen
    drawStar();  // draw the background
  popMatrix();
 if(mousePressed){ 
     float r2 = map(cc[4], 0,127,0,255);
  float g2 = map(cc[5], 0,127,0,255);
  float b2 = map(cc[6], 0,127,0,255);
  float a2 = map(cc[37], 0,127,0,255);
  fill(r2,g2,b2);
  pushMatrix();  // save things for the foreground pattern
    translate(mouseX, mouseY);  // move to the mouse's location
    float ts2 = map(cc[20],0,127,.1,2);
    rotate(TWO_PI * frameCount/ts * ts2);  // rotate over time
    drawStar();  // draw the foreground
  popMatrix();
 }
}

void drawStar() {
  float nS = map(cc[17],0,127,20,200);
  float numSpokes = nS;  // draw this many radiating spokes
  for (int i=0; i<numSpokes; i++) {
     float t0 = map(i, 0, numSpokes-1, 0, TWO_PI); // starting angle
     float ea = map(cc[19],0,127,1,10);
     float t1 = t0 + (TWO_PI/(ea * numSpokes));// ending angle
     float l = map(cc[18],0,127,100,5000);
     arc(0, 0, l, l, t0, t1);                // draw this stroke
  }
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  println("Frame rate:"+frameRate);
  //println("Font:"+fontNames[fontSelect]);   // How can I get it to say the font name, not just the #?
 // println("Font number:"+fontSelect);
  cc[number] = value;  // saves the midi output # to be converted later for what we need

 // if (cc[42] == 127) { // Press #42 to pause
  // pauseToggle = !pauseToggle;
  }
