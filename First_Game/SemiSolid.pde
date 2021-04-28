class SemiSolid 
{
  int identify;                         //Identifier (what type is it?)
  //1 for ground
  //2 for platforms you can fall through by pressing down
  float xPos;
  float yPos;
  float wid;
  float len;
  boolean landed = false;
  SemiSolid (float a, float b, float c, float d, int e)
  {
    xPos = a;
    yPos = b;
    wid = c;
    len = d;
    identify = e;
  }
  void display()
  {
    //Reduce lag by not drawing when off screen
    if (((xPos - x) < 1210) || ((xPos - x + wid) > -10)) 
    {
      //"Duckable platform (can fall through by pressing down)
      if (identify == 0)
      {
        fill(240, 150, 20);
        stroke(0);
        strokeWeight(2);
        for (int c = 0; c < wid/2; c += 20)
        {
          rect((xPos + c) - x, yPos, 20, 20, 4);
        }
      }
      //Grassy platform
      if (identify == 1)
      {
        if (((xPos - x) < 1210) || ((xPos - x + wid) > -10))
        {
          stroke(0);
          strokeWeight(1);
          fill(242, 191, 68);
          rect(xPos - x, yPos, wid, len, 8);
          fill(178, 129, 64);
          for (float i = yPos + 40; i < yPos + len; i += 30)
          {
            rect(xPos - x, i, wid, 15);
          }
          strokeWeight(2);
          fill(53, 215, 114);
          rect(xPos - x, yPos, wid, 40, 8);
          noStroke();
        }
      }
      //Icy platform
      if (identify == 2)
      {
      }
    }
  }
  void collision()
  {
    if (((xPos - x) < 1210) || ((xPos - x + wid) > -10))
    {
      landed = false;
      //Detects when grounded
      if (identify == 0)
      {
        if ((625 > (xPos - x - 10)) && (575 < (xPos - x + 20*(wid/40))))
        {
          if (((y + 50) > yPos) && ((y + 50) < (yPos + 25)) && v <= 0)
          {
            if (!pressed[1])
            {
              grounded = true;
              y = yPos - 50;
              landed = true;
              v = 0;
            }
            if (identify == 0 && pressed[1])
            {
              grounded = false;
            }
          }
        }
      }
      else if (identify == 1) 
      {
        if ((625 > (xPos - x)) && (575 < (xPos - x + wid)))
        {
          //Top collision
          if (((y + 50) > yPos) && ((y + 50) < (yPos + 25)) && v <= 0)
          {
            y = yPos - 50;
            grounded = true;
            landed = true;
            v = 0;
          }
        }
      }
    }
  }
}
