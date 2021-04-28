class Background
{
  float[] xPos = new float[4];
  float[] yPos = new float[4];
  float dif1;
  float dif2;
  float parallax = 2.5;
  int id;

  Background (float a, float o, float b, float p, float c, float q, int x)
  {
    xPos[0] = a;
    yPos[0] = o;
    xPos[1] = b;
    yPos[1] = p;
    xPos[2] = c;
    yPos[2] = q;
    id = x;
  }

  void hill()
  {
    if (id == 0)
    {
      dif1 = xPos[1] - xPos[0];
      dif2 = xPos[2] - xPos[1];
      fill(6, 210, 40);
      stroke(0);
      //Background repeats
      if ((xPos[2] - (x/parallax)) < 0)
      {
        xPos[2] = 1200 + dif1 + dif2 + x/parallax;
        xPos[1] = xPos[2] - dif2;
        xPos[0] = 1200 + x/parallax;
      }
      if ((xPos[0] - x/parallax) > 1200)
      {
        xPos[2] = x/parallax;
        xPos[1] = xPos[2] - dif2;
        xPos[0] = xPos[1] - dif1;
      }
      triangle(xPos[0] - x/parallax, yPos[0], xPos[1] - x/parallax, yPos[1], xPos[2] - x/parallax, yPos[2]);
    } else if (id == 1)
    {
      if (((xPos[0] - x) < 1210) || ((xPos[0] - x + xPos[1]) > -10))
      {
        stroke(0);
        strokeWeight(1);
        fill(135, 85, 20);
        rect(xPos[0] - x, yPos[0], xPos[1], yPos[1], 8);
        fill(192, 141, 23);
        for (float i = yPos[0] + 40; i < yPos[0] + yPos[1]; i += 30)
        {
          rect(xPos[0] - x, i, xPos[1], 15);
        }
        noStroke();
      }
    }
  }
}
