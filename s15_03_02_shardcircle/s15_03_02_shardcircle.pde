import processing.opengl.*;

float radius = 280;
int shardCount = 1000; 
float seed = 0;
int countdown = 0;
float fade = 50;

void setup()
{
  size(500, 500, OPENGL);
  background(255);
  stroke(0);
  frameRate(45);
  
  reset();
}

void draw()
{
  background(255);
  
  translate(width / 2, height / 2);
  rotate(frameCount * 0.01 + seed);
  //rotateZ(seed);
  //rotateX(frameCount * 0.04);
  
  float a;
  if (countdown <= 0)
  {
    a = min(frameCount / fade, 1);
  }
  else
  {
    a = min(countdown / fade, 1);
    countdown--;
    if (countdown <= 0)
    {
      reset();
      a = 0;
    }
  }
  
  for (int i = 0; i < shardCount; i++)
  {
    beginShape();
    //float c = i;// + frameCount * 0.1;
    float c = i * 0.000005 * frameCount + seed;
    fill(noise(c, 0) * 255, noise(c, 1) * 255, noise(c, 2) * 255, 100 * a);
    stroke(255, 255, 255, 5 * a);
    
    for (int j = 0; j < 3; j++)
    { 
      float s = radians(noise(i, j * 0.1 + seed) * 360);
      float r1 = noise(i, 1 + j * 0.1 + seed);
      float r2 = noise(i, 2 + j * 0.1 + seed);
      
      float factor = frameCount * 0.01;
      s *= factor * 1;
      //t *= factor * 0.1;
      //t += s * 0.1;
      
      //t *= min(frameCount / 100.0, 1);
      //s *= min(frameCount / 1000.0, 1);
      
      float x = cos(s);
      float y = sin(s);
      float r = radius;
      
      vertex(x * r * r1, y * r * r2);
    }
    
    endShape(CLOSE);
  }
}

void mouseClicked() {
  if (countdown <= 0)
  {
    countdown = min(frameCount, (int)fade);
  }
}

void reset()
{
  seed = random(100);
  frameCount = 0;
}
