//This class includes all interactable objects, not just enemies
class Enemy
{
  int id;
  int wid;
  int extra;
  float trueX;
  float xPos;
  float yPos;
  float radius;
  float movement;

  Enemy(float a, float b, float c, int d, int e)
  {
    xPos = a;
    yPos = b;
    radius = c;
    id = d;
    extra = e;
  }

  void display() 
  {
    //Draws when on screen
    if (((xPos - x) < 1210) || ((xPos - x + 50) > -10)) 
    {
      wid = 50;
      trueX = xPos - x;
      //Custom color unlockable
      if (id == 0) 
      {
        switch(extra) {
        case 1:
          fill(255, 0, 255);
          break;
        case 2:
          playerColor[0] = 0;
          break;
        case 3: 
          playerColor[3] = 60;
          break;
        }
        strokeWeight(2);
        circle(trueX, yPos, wid);
      }
      //Standard red baddie
      if (id == 1) 
      {
        if (start)
        {
          movement = random(6.28);
        }
        movement += 0.01;
        trueX = xPos - x + radius * sin(movement);
        image(baddie, trueX, yPos, wid, wid);
      }
      //Feather powerup
      if (id == 2)
      {
        image(feather, trueX, yPos, 50, 50);
      }
    }
  }
  void enemyHit()
  //Damages player and provides temporary invincibility when hit
  {
    if ((625 > trueX) && (575 < (trueX + wid)) && invincibleTime <= 0 && ((y + 50) > yPos) && (y < (yPos + wid)))
    {
      if (id == 0)
      {
        unlockedCol[extra] = true;
        id = 500;
      } else if (id == 1)
      {
        health --;
        invincibleTime = 3;
        power = 0;
      } else if (id == 2)
      {
        power = 1;
        id = 500;
      }
    }
  }
}
