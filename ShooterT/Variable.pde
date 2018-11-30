final int MAX_KEYSPRESSED = 1024;
boolean[] keysPressed = new boolean[MAX_KEYSPRESSED];

// Player
Player player;
Player2 player2;
PVector position;
float radius, t;
float gunLength;
float bulletVTune = 10;
boolean shot;

//AI
float aiShootCoolDown = 350;

// Bullet
float bulletW = 30;
float bulletH = 20;
float bulletLenght = 50;

void mainSetup(){
  radius = 20;
  gunLength = radius*2;
  position = new PVector(width/4, height/2);
  player = new Player(position, radius, radius, gunLength, bulletLenght);
  position = new PVector(width/4*3, height/2);
  player2 = new Player2(position, radius, radius, gunLength, bulletLenght, aiShootCoolDown);
}
