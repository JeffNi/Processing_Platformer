import processing.sound.*;

/*  
 Created by Jeff Ni
 Started Feb 6 2020
 Version: 0.1
 A platformer game
 */

//Variables
int health = 3;                   //Player health
int power = 0;                    // What powerup the player has
int subLvl;                       // Sublevel id
float invincibleTime;
float x = 0;                      //x position
float y = 300;                    //y position
float v = 0;                      //Velocity (to add y direction acceleration)
boolean[] pressed;                //Array for keys pressed
PImage bkgrd;                     //Background image     
PImage heart;                     //Health
PImage emptyHeart;                //Empty health
PImage baddie;                    //Common enemy
PImage cloud;                     //cloud
PImage feather;
SoundFile cliffs;                 //Track 1
int deathColor = 0;               //Color of the words on the death screen (it fades in)
PFont optPrinceps;                //The font on death screen
int deathTimer;                   //Time until you can respawn after death
int[] playerColor;                //The player's customizable character
int scene = 1; 
int level = 0;                    //Keeps track of how many levels were cleared
int jumpTest = 0;
boolean start = true;             //Checks when a level just started to set the initial position of background objects
boolean subChange = false;        //Checks when sublevel changes
int c;                            //Keeps track of numbers on the level select screen (scene 3)
boolean grounded; 
boolean twoPlay;                  //Multiplayer support soon
boolean[] collide;                //0 is left collision, 1 is right
int platformAmt;                  //Amount of platforms in level
int hillAmt;   
int semiAmt;
int enemyAmt;
int warpAmt;
int direction;                    //0 is left, 1 is right
int colId = 0;
boolean[] unlockedCol;
int maxCol = 10;
Obstacle[] platform;
Background[] hills;
SemiSolid[] semi;
Enemy[] enemy;
Warp[] warp;
//Detects if player is on the ground or in air      
//Scene 1 is title scene
//Scene 2 is death screen
//Scene 3 is level select
//Scene 4 is customize
//Scene 5 is instructions

void setup()
{
  //Setting up variables
  bkgrd = loadImage("background.png");
  heart = loadImage("Full_Health.png");
  emptyHeart = loadImage("Health.png");
  baddie = loadImage("baddie.png");
  cloud = loadImage("cloud.png");
  feather = loadImage("feather.png");
  //cliffs = new SoundFile(this, "Track1.mp3");
  size(1200, 800);
  unlockedCol = new boolean[maxCol];
  pressed = new boolean[4];
  playerColor = new int[7];
  collide = new boolean[2];
  platform = new Obstacle[20];
  hills = new Background[5];
  semi = new SemiSolid[10];
  enemy = new Enemy[10];
  warp = new Warp[5];
  optPrinceps = createFont("OptimusPrinceps.ttf", 100);
  colId = 0;
  unlockedCol[0] = true;

  //Declares that no keys are pressed
  for (int p = 0; p < 4; p++)
  {
    pressed[p] = false;
  }
  //Sets player color to white
  for (int c = 0; c < 4; c++)
  {
    playerColor[c] = 255;
  }
  for (int i = 1; i < maxCol; i++)
  {
    unlockedCol[i] = false;
  }
}

void draw()
{
  //Main menu where you customize player, read instructions and level select
  if (scene == 1)
  {
    subChange = false;
    subLvl = 1;
    resetCollision();
    invincibleTime = 0;
    for (int i = 0; i < 1200; i += 100) {
      for (int j = 0; j < 800; j += 100) {
        fill(random(25, i/6), random(25, j/6), random(25));
        rect (i, j, 100, 100);
      }
    }
    stroke(250, 235, 135);
    strokeWeight(10);
    fill(250, 0, 0);
    for (int i = 250; i < 551; i += 150) 
    {
      if (400 < mouseX && mouseX < 800)
      {
        if ((250 < mouseY && mouseY < 350 && i == 250) || (400 < mouseY && mouseY < 500 && i == 400) || (550 < mouseY && mouseY < 650 && i == 550))
        {
          fill(0, 255, 0);
        }
      } 
      rect(400, i, 400, 100);
      fill(250, 0, 0);
    }
    fill(0, 255, 35);
    textSize(100);
    text("A very fun game", 210, 170);
    fill(25, 180, 255);
    text("PLAY", 480, 335);
    text("HELP", 480, 635);
    textSize(65);
    text("CUSTOMIZE", 415, 470);
  }
  noStroke();
  //What happens when you die (dark screen, words fading in)
  if (scene == 2) 
  {      
    v = 0;
    power = 0;
    subLvl = 1;
    background(0);
    fill(deathColor, 0, 0);
    textSize(30);
    text("[Press any button to continue]", 400, 450);
    textFont(optPrinceps);
    text("You Died", 400, 350);
    deathColor += 10;
    deathTimer++;
    delay(100);
    resetCollision();
    health = 3;
    invincibleTime = 0;
  }
  //Level select
  if (scene == 3)
  {
    c = 1;
    x = 0;
    start = true;
    stroke(255);
    strokeWeight(10);
    background(0);
    for (int a = 100; a < 551; a += 150)
    {
      for (int b = 250; b < 851; b += 200)
      {
        fill(b/4, a/3, 255);
        rect(b, a, 100, 100);
        fill(0);
        text(c, b + 10, a + 70);
        c ++;
      }
    }
  }
  if (scene == 4) {
    //Draws GUI
    background(0);
    fill(255);
    triangle(600, 400, 600, 460, 550, 430);
    triangle(900, 400, 900, 460, 950, 430);
    triangle(600, 550, 600, 610, 550, 580);
    triangle(900, 550, 900, 610, 950, 580);
    fill(0, 255, 0);
    //Mouse hover changes color of triangle
    if (550 < mouseX && mouseX < 600) {
      if (400 < mouseY && mouseY < 460) 
      {
        triangle(600, 400, 600, 460, 550, 430);
      } else if (550 < mouseY && mouseY <610)
      {
        triangle(600, 550, 600, 610, 550, 580);
      }
    } else if (900 < mouseX && mouseX < 950)
    {
      if (400 < mouseY && mouseY < 460) 
      {
        triangle(900, 400, 900, 460, 950, 430);
      } else if (550 < mouseY && mouseY <610)
      {
        triangle(900, 550, 900, 610, 950, 580);
      }
    }
    //Displays the color that the player is switching to
    stroke(playerColor[4], playerColor[5], playerColor[6]);
    fill(playerColor[0], playerColor[1], playerColor[2], playerColor[3]);
    rect(575, 200, 50, 50);
    circle(750, 430, 50);
    text("Color:", 200, 450);
    text("Design:", 200, 600);
  }
  if (scene == 5) {
    background(0);
    text("Press Backspace to return to main menu", 200, 450);
  }
  //Level 1
  if (scene == 6) 
  {
    //Drawing background and characters
    if (subLvl == 1)
    {
      background(bkgrd);
      fill(3, 167, 255);
      rect(-1, 600, 1202, 200);
    }
    else {
      background(bkgrd);
    }
    if (start == true)
    {
      x = 0;
      y = 400;
    }
    //Creates objects for main level
    if (start == true || (subChange == true && subLvl == 1))
    {
      hillAmt = 5;
      platformAmt = 16;
      semiAmt = 9;
      enemyAmt = 9;
      warpAmt = 1;
      //Background objects
      hills[0] = new Background(-100, 800, 300, 200, 700, 800, 0);
      hills[1] = new Background(800, 800, 1300, 150, 1800, 800, 0);
      hills[2] = new Background(250, 800, 800, 50, 1350, 800, 0);
      hills[3] = new Background(8010, 0, 980, 1000, 0, 0, 1);
      hills[4] = new Background(9400, 350, 750, 1000, 0, 0, 1);
      //Semisolid platforms
      semi[0] = new SemiSolid(2375, 400, 300, 500, 0);
      semi[1] = new SemiSolid(2375, 550, 300, 500, 0);
      semi[2] = new SemiSolid(3600, 500, 500, 500, 0);
      semi[3] = new SemiSolid(4100, 400, 500, 500, 0);
      semi[5] = new SemiSolid(6500, 600, 1600, 500, 0);
      semi[4] = new SemiSolid(6700, 450, 400, 500, 1);
      semi[6] = new SemiSolid(8400, 350, 400, 500, 0);
      semi[7] = new SemiSolid(9000, 450, 400, 500, 0);
      semi[8] = new SemiSolid(10150, 350, 500, 500, 1);
      //Ground
      platform[0] = new Obstacle(-1100, -70, 600, 880, 0);
      platform[1] = new Obstacle(-500, 350, 350, 880, 0);
      platform[2] = new Obstacle(-150, 200, 600, 880, 0);
      platform[3] = new Obstacle(450, 500, 700, 880, 0);
      platform[4] = new Obstacle(1150, 350, 400, 880, 0);
      platform[5] = new Obstacle(1850, 400, 525, 880, 0);
      platform[6] = new Obstacle(2800, 650, 600, 880, 0);
      platform[7] = new Obstacle(4650, 300, 850, 700, 0);
      platform[8] = new Obstacle(5500, 450, 500, 500, 0);
      platform[9] = new Obstacle(6000, 600, 500, 500, 0);
      platform[10] = new Obstacle(7300, 600, 500, 500, 0);
      platform[11] = new Obstacle(8000, 450, 1000, 500, 0);
      platform[12] = new Obstacle(8000, -150, 1000, 425, 0);
      platform[13] = new Obstacle(9400, 350, 750, 100, 0);
      platform[14] = new Obstacle(9400, 600, 750, 500, 1);
      platform[15] = new Obstacle(10150, 600, 500, 500, 1);
      //Enemies
      enemy[0] = new Enemy(2167, 350, 317, 1, 0);
      enemy[1] = new Enemy(3075, 600, 275, 1, 0);
      enemy[2] = new Enemy(5050, 250, 400, 1, 0);
      enemy[3] = new Enemy(5050, 250, 400, 1, 0);
      enemy[4] = new Enemy(6300, 550, 300, 1, 0);
      enemy[5] = new Enemy(-325, 250, 50, 0, 1);
      enemy[6] = new Enemy(8475, 400, 475, 1, 0);
      enemy[7] = new Enemy(8475, 400, 475, 1, 0);
      enemy[8] = new Enemy(700, 300, 475, 2, 0);
      //Warp zones
      warp[0] = new Warp(6500, 800, 800, 0, 400, 2, 1);
    }
    //Creats objects for sublevel
    if (subLvl == 2 && subChange == true)
    {
      hillAmt = 0;
      platformAmt = 2;
      semiAmt = 0;
      enemyAmt = 0;
      warpAmt = 1;
      platform[0] = new Obstacle(-150, 200, 600, 880, 0);
      platform[1] = new Obstacle(450, 500, 700, 880, 0);
      warp[0] = new Warp(50, 50, 50, 6700, 0, 1, 1);
    }
    //Draws things on the scene
    for (int i = 0; i < hillAmt; i++)
    {
      hills[i].hill();
    }
    for (int i = 0; i < platformAmt; i++)
    {
      platform[i].display();
      platform[i].collisionDetect();
    }
    for (int i = 0; i < semiAmt; i++)
    {
      semi[i].display();
      semi[i].collision();
    }
    for (int i = 0; i < enemyAmt; i++)
    {
      enemy[i].display();
      enemy[i].enemyHit();
    }
    for (int i = 0; i < warpAmt; i++)
    {
      warp[i].teleport();
    }
    onAnyPlatform();
    player();
    playerTwo();
    start = false;
  }
  if (scene == 7)
  {
  }
  //Main game, when alive
  if (scene > 5)
  {
    if (health == 0 )
    {
      delay(1000);
      scene = 2;
    }
    if (invincibleTime > 0)
    {
      invincibleTime -= 0.05;
    }
    //Resets changes made after death
    deathTimer = 0;
    deathColor = 0;
    jumpTest = 0;
    //Moves when button is pressed
    if (pressed[0])
    {
      if (collide[1])
      {
        pressed[0] = false;
      } else 
      {
        collide[0] = false;
        x +=7;
      }
    }
    if (pressed[2])
    {
      if (collide[0])
      {
        pressed[2] = false;
      } else
      {
        collide[1] = false;
        x -=7;
      }
    }
    if (pressed[1])
    {
      v -= 0.6;
    }
    if (grounded == true)
    {
      if (pressed[3])
      {
        v = 12;
        grounded = false;
      }
    }
    //Happens if grounded is false, determines y 
    //position of player and accelerates downward
    if (grounded == false)
    {
      y -= v;
      if (power == 1 && pressed[3])
      {
        v -= 0.2;
      } else {
        v -= 0.4;
      }
    }
    //Kills player if the player goes below the screen
    if (y > 800) 
    {
      health = 0;
    }
  }
}
void resetCollision()
{
  //Declares side collision to be false
  collide[0] = false;
  collide[1] = false;
}
//If player is on any platform grounded doesn't change to false
void onAnyPlatform()
{
  for (int z = 0; z < platformAmt; z++)
  {
    if (platform[z].landed)
    {
      jumpTest++;
    }
  }
  for (int y = 0; y < semiAmt; y++)
  {
    if (semi[y].landed)
    {
      jumpTest++;
    }
  }
  if (jumpTest < 1)
  {
    grounded = false;
  }
}
