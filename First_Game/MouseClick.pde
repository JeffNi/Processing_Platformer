void mouseClicked() 
{
  //Detects when a button on the menu is clicked
  if (scene == 1)
  {
    if (400 < mouseX && mouseX < 800)
    {
      if (250 < mouseY && mouseY < 350)
      {
        scene = 3;
      }
      if (400 < mouseY && mouseY < 500)
      {
        scene = 4;
      }
      if (550 < mouseY && mouseY < 650)
      {
        scene = 5;
      }
    }
  } else if (scene == 3)
  {
    if ((250 < mouseX) && (mouseX < 350))
    {
      scene = 6;
    }
  } else if (scene == 4)
  {
    if (550 < mouseX && mouseX < 600) {
      //Previous color
      if (400 < mouseY && mouseY < 460 && colId > 0) 
      {
        for (int i = colId - 1; i >= 0; i--) 
        {
          if (unlockedCol[i] == true)
          {
            colId = i;
            break;
          }
        }
      } else if (550 < mouseY && mouseY < 610)
      {
      }
    } else if (900 < mouseX && mouseX < 950)
    {
      //Next color
      if (400 < mouseY && mouseY < 460 && colId < maxCol) 
      {
        for (int i = colId + 1; i < maxCol; i++) 
        {
          if (unlockedCol[i] == true)
          {
            colId = i;
            break;
          }
        }
      } else if (550 < mouseY && mouseY <610)
      {
      }
    }
    switch(colId) {
    case 0:
      playerColor[0] = 255;
      playerColor[1] = 255;
      playerColor[2] = 255;
      playerColor[3] = 255;
      break;
    case 1:
      playerColor[0] = 255;
      playerColor[1] = 0;
      playerColor[2] = 255;
      playerColor[3] = 255;
      break;
    case 2:
      playerColor[0] = 0;
      playerColor[1] = 0;
      playerColor[2] = 255;
      playerColor[3] = 255;
      break;
    case 3: 
      playerColor[3] = 60;
      break;
    }
  }
}
