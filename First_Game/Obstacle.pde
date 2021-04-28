class Obstacle 
  //Ground platforms
{
  boolean fell = false;
  float xPos;
  float yPos;
  float wid;
  float len;
  boolean landed = false;
  int id;
  Obstacle (float x, float y, float w, float l, int i)
  {
    xPos = x;
    yPos = y;
    wid = w;
    len = l;
    id = i;
  }
  void display()
    //Draws the platforms only when they appear on screen
  {
    if (((xPos - x) < 1210) || ((xPos - x + wid) > -10))
    {
      if (id == 0)
      {
        stroke(0);
        strokeWeight(1);
        fill(163, 92, 5);
        rect(xPos - x, yPos, wid, len, 8);
        fill(227, 155, 0);
        for (float i = yPos + 40; i < yPos + len; i += 30)
        {
          rect(xPos - x, i, wid, 15);
        }
        strokeWeight(2);
        fill(0, 230, 0);
        rect(xPos - x, yPos, wid, 40, 8);
      } else if (id == 1)
      {
        stroke(0);
        strokeWeight(1);
        fill(163, 92, 5);
        rect(xPos - x, yPos, wid, len, 8);
        fill(227, 155, 0);
        for (float i = yPos; i < yPos + len; i += 30)
        {
          rect(xPos - x, i, wid, 15);
        }
      }
    }
  }
  void collisionDetect()
  {
    if (((xPos - x) < 1210) || ((xPos - x + wid) > -10)) {
      landed = false;
      //Detects when grounded
      if ((625 > (xPos - x)) && (575 < (xPos - x + wid)))
      {
        //Top collision
        if (((y + 50) > yPos) && ((y + 50) < (yPos + 50)))
        {
          y = yPos - 50;
          grounded = true;
          landed = true;
          v = 0;
        }
        //Bottom collision
        if (((y) < (yPos + len)) && (y > (yPos + len/2)))
        {
          y = yPos + len;
          v = 0;
        }
        if ((y >= (yPos)) && (y < yPos + len))
        {
          //Right collision
          if (pressed[0] == true)
          {
            x = xPos - 625;
            collide[1] = true;
          }
          //Left collision
          if (pressed[2] == true)
          {
            x = xPos + wid - 575;
            collide[0] = true;
          }
        }
        /*else 
         {
         collide[0] = false;
         collide[1] = false;
         }*/
      }
      if (((625 == (xPos - x)) || ((xPos - x + wid) == 575)) && ((y + 50) < yPos))
      {
        resetCollision();
        if (direction == 1)
        {
          pressed[0] = true;
        } else if (direction == 0)
        {
          pressed[2] = true;
        }
        direction = 2;
      }
    }
  }
}
