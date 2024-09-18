PImage img;
float t; 

void setup() {
  size(800, 600);
  img = loadImage("imagen.jpg"); // cargar la imagen
  img.resize(width, height);
  println("Cantidad de pixeles: "+img.pixels.length);
}

void draw() {

  // Desactivar para tener la imagen al fondo
  //image(img, 0, 0);

  // Estos valores solamente afectan a la oscilación
  float frequency = 0.1;
  float speed = 0.05;

  loadPixels();

  for (int x = 0; x < width; x++) { // iteración en x
    for (int y = 0; y < height; y++) { // iteración en y

      int loc = x + y * width; // leemos todos los pixeles en x y
      color pix = img.pixels[loc]; // guardamos el color en una variable
      float noise = noise(x*0.005, y*0.005); // valores semi aleatorios
      float value = sin(frequency * (x) + t) * 0.5 + 0.5; // osc de 0-1

      /////////////////////////////////////////////////////
      // Varibles que se pueden usar en pixeles del canvas

      float red = red(pix); // canal rojo de la imagen
      float green = green(pix); // verde
      float blue = blue(pix); // azul

      float nMap = map(noise, 0, 1, 0, 255); // noise ajustado a color
      float gradientX = map(x, 0, width, 0, 255); // gradiente en X
      float gradientY = map(y, 0, height, 0, 255); // gradiente en X

      float osc = value * 255; 
      /////////////////////////////////////////////////////

      // pasar cualquier combinación de variables 
      pixels[loc] = color(___,___,___);
    }
  }

  updatePixels();
  t += speed;

}

void keyPressed() {
  if (key == 'c') {
    println("imagen guardada");
    saveFrame("pixeles###.png");
  }
}
