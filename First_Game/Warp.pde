class Warp 
{
  int xPos;
  int yPos;
  int wid;
  int len = 50;
  int exitX;
  int exitY;
  int exitSubLvl;
  int type;                        //Type 1 = up, type 2 = down, type 3 = door
  int counter;
  
  Warp (int a, int b, int c, int d, int e, int f, int g)
  {
    xPos = a;
    yPos = b;
    wid = c;
    exitX = d;
    exitY = e;
    exitSubLvl = f;
    type = g;
  }
  
  void teleport () {
    subChange = false;
    if ((625 > (xPos - x)) && (575 < (xPos - x + wid)))
    {
      if (((y + 50) > yPos) && ((y + 50) < (yPos + 50)))
      {
        subLvl = exitSubLvl;
        subChange = true;
        v = 0;
        x = exitX;
        y = exitY;
      }
    }
  }
}
