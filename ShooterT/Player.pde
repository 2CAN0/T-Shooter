class Player {
  PVector position, size, velocity, centerBounce, velocityBackUp, gun;
  boolean hitCenter;
  boolean shot = false;
  float gunLength;
  float bulletLength;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  Player(PVector p, float w, float h, float gL, float bL) {
    position = p;
    gun = new PVector(mouseX, mouseY);
    gunLength = gL;
    size = new PVector(w, h);    
    velocity = new PVector(5, 5);
    velocityBackUp = new PVector(0, 0);
    velocityBackUp.add(velocity);
    centerBounce = new PVector(0.1, 0.1);
    hitCenter = false;
    bulletLength = bL;
  }

  void update() {
    if (keysPressed[87] && position.y > size.y)position.y -= velocity.y;
    if (keysPressed[83] && position.y < height - size.y)position.y += velocity.y;
    if (keysPressed[68] && position.x < width/2 - size.x)position.x += velocity.x;
    if (keysPressed[65] && position.x > size.x)position.x -= velocity.x;

    if (position.x >= width/2 - size.x) {
      hitCenter = true;
      velocity.x = -2;
      velocity.y = -2;
    }

    float dX = mouseX - position.x;
    float dY = mouseY - position.y;
    float d = sqrt(dX*dX+dY*dY);

    if (d > gunLength || d < gunLength) {
      gun.x = position.x + dX/d * gunLength;
      gun.y = position.y + dY/d * gunLength;
    }

    if (hitCenter) {
      velocity.add(centerBounce);
      if (velocity.x < 0) {
        position.add(velocity);
      }
      if (velocity.x >= velocityBackUp.x) {
        hitCenter = false;
      }
    }

    dX = gun.x - position.x;
    dY = gun.y - position.y;
    
    
    
    PVector bulletP2 = new PVector();
    bulletP2.x = position.x + dX/d * bulletLength;
    bulletP2.y = position.y + dX/d * bulletLength;

    if (keysPressed[32] && !shot) {
      shot = true;
      bullets.add(new Bullet(gun.x, gun.y, bulletP2.x, bulletP2.y,bulletW, bulletH, dX, dY, atan(dY/dX)));
    }

    for (int iBullet = 0; iBullet < bullets.size(); iBullet++) {

      Bullet blt = bullets.get(iBullet);
      blt.update();  
      blt.draw();
      if (blt.ofScreen)
        bullets.remove(iBullet);
    }
  }

  void draw() {
    fill(0, 150);
    stroke(0);
    line(position.x, position.y, gun.x, gun.y);
    ellipse(position.x, position.y, size.x*2, size.y*2);
  }
}
