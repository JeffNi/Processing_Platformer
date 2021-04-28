void player()
{
  //Power up design
  if (power == 1)
  {
    image(feather, 570, y - 35, 40, 40);
  }
  //Draws player
  stroke(playerColor[4], playerColor[5], playerColor[6]);
  fill(playerColor[0], playerColor[1], playerColor[2], playerColor[3] * cos(invincibleTime));
  rect(575, y, 50, 50);
  
  //Draws lives at top left of screen
  for (int i = 50; i <= health * 50; i += 50)
  {
    //image(heart, i, 50, 50, 50);
    fill(playerColor[0], playerColor[1], playerColor[2]);
    rect(i, 50, 25, 25);
  }
  for (int i = 150; i > health * 50; i -= 50)
  {
    //image(emptyHeart, i, 50, 50, 50);
    stroke(0);
    fill(0, 0, 0, 0);
    rect(i, 50, 25, 25);
  }
}
void playerTwo()
{
  if (twoPlay) {
    stroke(playerColor[0], playerColor[1], playerColor[2]);
    fill(playerColor[4], playerColor[5], playerColor[6], playerColor[3] * cos(invincibleTime));
    rect(575, y, 50, 50);
  }
}
