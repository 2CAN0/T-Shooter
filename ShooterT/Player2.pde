class Player2 {
  PVector position, size, velocity, centerBounce, velocityBackUp, gun;
  boolean hitCenter;
  boolean shot = false;
  float gunLength;
  float BuleltLenght;
  float aiRange = width/2;
  float aiCoolDown;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  StopWatchTimer coolDown = new StopWatchTimer();

  String[] moveMent = {"Null", "Up", "Down", "Left", "Right"};

  Player2(PVector p, float w, float h, float gL, float bL, float AIC) {
    position = p;
    gun = new PVector(mouseX, mouseY);
    gunLength = gL;
    size = new PVector(w, h);    
    velocity = new PVector(5, 5);
    velocityBackUp = new PVector(0, 0);
    velocityBackUp.add(velocity);
    centerBounce = new PVector(-0.1, -0.1);
    hitCenter = false;
    bulletLenght = bL;
    aiCoolDown = AIC;
  }

  void update(Player pl) {
    boolean plInrange = inRange(pl);
    println("Inragne: "+plInrange);

    if (plInrange) {
      velocity = velocityBackUp;
      if (frameCount % 10 == 0) {
        int moveSet = (int)Math.floor(random(1, moveMent.length));
        float multi = 2;
        if( moveMent[moveSet] == moveMent[3] && position.x > width/2 + size.x + velocity.x) position.x += velocity.x * multi;
        if (moveMent[moveSet] == moveMent[1] && position.y > size.y + velocity.y)position.y -= velocity.y*multi;
        if (moveMent[moveSet] == moveMent[2] && position.y < height - size.y - velocity.y)position.y += velocity.y*multi;
        if (moveMent[moveSet] == moveMent[4] && position.x < width - size.x - velocity.x)position.x += velocity.x*multi;
      }
    } else if (!plInrange) {
      float dX = pl.position.x  - position.x;
      float dY = pl.position.y - position.y;
      float d = sqrt(dX*dX+dY*dY);
      float eenGetal = 15;
      velocity.x = (position.x + dX/d * eenGetal) - position.x;
      velocity.y = (position.y + dY/d * eenGetal) - position.y;
      if ((position.x + velocity.x < width - size.x && position.x + velocity.y> width/2 + size.x) &&
        (position.y + velocity.y < height - size.y && position.y + velocity.y > 0 + size.y)) {
        position.add(velocity);
      }
    }

    if (position.x <= width/2 + size.x/2) {
      hitCenter = true;
    }

    float dX = player.position.x - position.x;
    float dY = player.position.y - position.y;
    float d = sqrt(dX*dX+dY*dY);

    if (d > gunLength || d < gunLength) {
      gun.x = position.x + dX/d * gunLength;
      gun.y = position.y + dY/d * gunLength;
    }

    //if (hitCenter) {
    //  velocity.add(centerBounce);
    //  if(position.x < width/2 + size.x/2 + velocity.x*2){
    //     position.x += velocity.x/5; 
    //  } else {
    //     hitCenter = false; 
    //  }

    //}

    dX = gun.x - position.x;
    dY = gun.y - position.y;




    PVector bulletP2 = new PVector();
    bulletP2.x = position.x + dX/d * bulletLenght;
    bulletP2.y = position.y + dX/d * bulletLenght;

    if (plInrange && !shot) {
      shot = true;
      bullets.add(new Bullet(gun.x, gun.y, bulletP2.x, bulletP2.y, bulletW, bulletH, dX, dY, atan(dY/dX)));
      coolDown.start();
    }

    if (coolDown.getElapsedTime() > 0) {
      if (coolDown.getElapsedTime() > aiCoolDown) {//time in miliSeconds
        shot = false;
        coolDown.stop();
        coolDown = new StopWatchTimer();
      }
    }

    for (int iBullet = 0; iBullet < bullets.size(); iBullet++) {

      Bullet blt = bullets.get(iBullet);
      blt.update();  
      blt.draw();
      if (blt.ofScreen)
        bullets.remove(iBullet);
    }
  }

  boolean inRange(Player pl) {
    float a = this.position.x - pl.position.x;
    float b = this.position.y - pl.position.y;
    float c = sqrt(a*a + b*b);
    float r1 = this.size.x*2;
    float r2 = pl.size.x*2;
    float d = c - ((r1)+(r2));
    return (d < aiRange);
  }

  void draw() {
    fill(0, 150);
    stroke(0);
    line(position.x, position.y, gun.x, gun.y);
    ellipse(position.x, position.y, size.x*2, size.y*2);
  }
}
