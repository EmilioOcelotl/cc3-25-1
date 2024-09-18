float t = 0.0; 

void setup() {
  size(800, 800);
  noStroke();
}

void draw() {
  float frequency = 0.1; 
  float speed = 0.05;    
  t += speed;

  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int loc = x + y * width;

      float value = sin(frequency * (x) + t) * 0.5 + 0.5; 
      float r = value * 255;

      pixels[loc] = color(r);
    }
  }

  updatePixels(); 
}