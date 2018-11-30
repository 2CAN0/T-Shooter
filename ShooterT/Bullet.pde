class Bullet {
  PVector position, position2, size, velocity;
  boolean ofScreen = false;
  float angle;

  Bullet(float x, float y, float x2, float y2, float w, float h, float vX, float vY, float ang) {
    position = new PVector(x, y);
    position2 = new PVector(x2, y2);
    size = new PVector(w, h);
    velocity = new PVector(vX/bulletVTune, vY/bulletVTune);
    angle = ang;
  }

  void update() {
    if (bulletOnScreen()){
      position.add(velocity);
      position2.add(velocity);
    }else
      ofScreen = true;
  }

  boolean bulletOnScreen() {
    boolean x = (position.x > -size.x && position.x < width);
    boolean y = (position.y > -size.y && position.y < height);
    return (x && y);
  }

  void draw() {
    //translate(0, 0);
    //rotate(PI/angle);
    //line(position2.x, position2.y,position.x, position.y);
    point(position.x, position.y);
    //rect(position.x, position.y, size.x, size.y);
  }
}
