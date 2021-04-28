void keyPressed()
{
  //Restarts if key pressed on death screen after a certain time
  if ((scene == 2)&&(deathTimer > 25)) {
    scene = 3; //change scene to level variable later
    x = 40;
    y = 40;
  }
  //Records when a key is pressed
  if (key == 'd')
  {
    pressed[0] = true;
    direction = 1;
    pressed[2] = false;
  }
  if (key == 's')
  {
    pressed[1] = true;
  }
  if (key == 'a')
  {
    pressed[2] = true;
    direction = 0;
    pressed[0] = false;
  }
  if (key == 'w')
  {
    pressed[3] = true;
  }
  if (key == BACKSPACE)
  {
    power = 0;
    scene = 1;
  }
}

void keyReleased()
{
  //Checks when a key isn't pressed so player stops moving
  if (key == 'd')
  {
    pressed[0] = false;
    if (direction == 1)
    {
      direction = 2;
    }
  }
  if (key == 's')
  {
    pressed[1] = false;
  }
  if (key == 'a')
  {
    pressed[2] = false;
    if (direction == 0)
    {
      direction = 2;
    }
  }
  if (key == 'w')
  {
    pressed[3] = false;
  }
}
