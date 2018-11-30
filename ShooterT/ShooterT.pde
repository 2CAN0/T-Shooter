void setup() {
  size(1920, 1080, P2D);
  frameRate(80);
  smooth();
  mainSetup();
}

void draw() {
  noStroke();
  fill(245, 219, 116);
  rect(0, 0, width, height);
  stroke(255);
  strokeWeight(3);
  line(width/2, 0, width/2, height);

  player.update();
  player.draw();

  player2.update(player);
  player2.draw();
}

void keyPressed() {
  keysPressed[keyCode] = true;
}

void keyReleased() {
  keysPressed[keyCode] = false;
  if (!keysPressed[32])
    player.shot = false;
}
