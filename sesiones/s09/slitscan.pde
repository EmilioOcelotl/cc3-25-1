// importar la librería 

import processing.video.*; 

Capture cam; // sintaxis programación orientada a objetos  
PImage img; 
float contador; // 0, 1, 2, 3, 4, 5, 6.. inf 

// acceder a la cámara ( leer un archivo ) 
// - enlistar cámaras
// - obtener resoluciones 
// Elegir una cámara y una resolución 

void setup(){
  size(1000, 300); 
  String[] cameras = Capture.list();
  //cam = new Capture(this, 320, 240); // 512, 720px 15fps 
  cam = new Capture(this, cameras[0]); //
  printArray(cameras); 
  cam.start(); 
  background(0);
}

// Leer cada uno de los cuadros en función independiente 

void captureEvent(Capture cam){
  cam.read(); 
}

// draw dibujar los cuadros de la cámara 
// dibujar imagen con efecto 

void draw(){
  /// leer pixeles, escribir pixeles, copiar pixeles 
  int w = cam.width;
  int h = cam.height;
  copy(cam, w/2, 0, 1, h, int(contador), 0, 1, height); 
  image(cam, 0, 0, cam.width/2, cam.height/2);
  contador = contador + 1; // 0, 1, 2, 3, 4... w
  
  if(contador > width){
    contador = 0; 
  }
  
  // saveFrame("cuadros/########.png"); 
  
}