/**
 * ControlP5 Matrix
 *
 * A matrix can be used for example as a sequencer, a drum machine.
 *
 * find a list of public methods available for the Matrix Controller
 * at the bottom of this sketch.
 *
 * by Andreas Schlegel, 2012
 * www.sojamo.de/libraries/controlp5
 *
 */

import controlP5.*;
import processing.sound.*;

SoundFile sonidos[] = new SoundFile[4];
color colores[] = new color[4];

// tom__11_.wav

color colorActual; 

ControlP5 cp5;
Knob myKnob;
Knob velocidad; 

Dong[][] d;
int nx = 16;
int ny = 4;

void setup() {
  size(1400, 400);
  
  //----------------------------------------------
  sonidos[0] = new SoundFile(this, "kick.wav");
  sonidos[1] = new SoundFile(this, "snare.wav");
  sonidos[2] = new SoundFile(this, "tom.wav");
  sonidos[3] = new SoundFile(this, "hi.wav");

  colores[0] = #FA7777;
  colores[1] = #AF77FA;
  colores[2] = #77FAC8;
  colores[3] = #F5FA77; 

  //----------------------------------------------

  cp5 = new ControlP5(this);

  cp5.addMatrix("myMatrix")
     .setPosition(200, 100)
     .setSize(600, 220)
     .setGrid(nx, ny)
     .setGap(10, 1)
     .setInterval(200) // sonidos cortos 
     .setMode(ControlP5.MULTIPLES)
     .setColorBackground(color(255))
     .setBackground(0)
     .setColorActive(color(#98C99D))

     ;
     
  myKnob = cp5.addKnob("knob")
               .setRange(0.0,1.0)
               .setValue(0.5)
               .setPosition(50,100)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setColorForeground(color(#98C99D))
               .setColorBackground(color(255))
               .setColorActive(color(100))
               ;
               
    velocidad = cp5.addKnob("vel")
               .setRange(0.1,4.0)
               .setValue(1.0)
               .setPosition(50,220)
               .setRadius(50)
               .setDragDirection(Knob.VERTICAL)
               .setColorForeground(color(#98C99D))
               .setColorBackground(color(255))
               .setColorActive(color(100))
               ;
  
  cp5.getController("myMatrix").getCaptionLabel().alignX(CENTER);
  
  // use setMode to change the cell-activation which by 
  // default is ControlP5.SINGLE_ROW, 1 active cell per row, 
  // but can be changed to ControlP5.SINGLE_COLUMN or 
  // ControlP5.MULTIPLES

    d = new Dong[nx][ny];
  for (int x = 0;x<nx;x++) {
    for (int y = 0;y<ny;y++) {
      d[x][y] = new Dong();
    }
  }  
  noStroke();
  smooth();
}


void draw() {
  background(0);
  fill(255, 100);
  pushMatrix();
  translate(width/4 * 3, height/2);
  rotate(frameCount*0.001);
  for (int x = 0;x<nx;x++) {
    for (int y = 0;y<ny;y++) {
      d[x][y].display();
    }
  }
  popMatrix();
}


void myMatrix(int theX, int theY) {
  println("got it: "+theX+", "+theY);
  // detonar un sonido 
  sonidos[theY].play(); 
  sonidos[theY].amp(myKnob.getValue()); // volumen 
  sonidos[theY].rate(velocidad.getValue()); 
  colorActual = colores[theY];
  //println(myKnob.getValue());
  println("reproduce un sonido en la fila " + theY);
  d[theX][theY].update();
}


void keyPressed() {
  if (key=='1') {
    cp5.get(Matrix.class, "myMatrix").set(0, 0, true);
  } 
  else if (key=='2') {
    cp5.get(Matrix.class, "myMatrix").set(0, 1, true);
  }  
  else if (key=='3') {
    cp5.get(Matrix.class, "myMatrix").trigger(0);
  }
  else if (key=='p') {
    if (cp5.get(Matrix.class, "myMatrix").isPlaying()) {
      cp5.get(Matrix.class, "myMatrix").pause();
    } 
    else {
      cp5.get(Matrix.class, "myMatrix").play();
    }
  }  
  else if (key=='0') {
    cp5.get(Matrix.class, "myMatrix").clear();
  }
}

void controlEvent(ControlEvent theEvent) {
}


class Dong {
  float x, y;
  float s0, s1;

  Dong() {
    float f= random(-PI, PI);
    x = cos(f)*random(100, 150);
    y = sin(f)*random(100, 150);
    s0 = random(8, 40);
  }

  void display() {
    s1 += (s0-s1)*0.1;
    ellipse(x, y, s1, s1);
  }

  void update() {
    s1 = 100;
  }
}