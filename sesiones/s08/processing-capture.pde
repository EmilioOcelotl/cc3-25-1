// primer paso, instalar e importar biblioteca video
import processing.video.*;

Capture cam;
float t;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {

  if (cam.available() == true) {
    cam.read();
  }

  float frequency = 0.1;
  float speed = 0.05;

  loadPixels();

  for (int x = 0; x < cam.width; x++) {
    for (int y = 0; y < cam.height; y++) {
      int loc = x + y * width;
      color pix = cam.pixels[loc];
      float noise = noise(x*0.005, y*0.005); // valores semi aleatorios
      float value = sin(frequency * (x) + t) * 0.5 + 0.5; // osc de 0-1
      float red = red(pix); // canal rojo de la imagen
      float green = green(pix); // verde
      float blue = blue(pix); // azul
      float osc = value * 255;
      pixels[loc] = color(red, green, blue);
    }
  }

  updatePixels();
  t += speed;
}
