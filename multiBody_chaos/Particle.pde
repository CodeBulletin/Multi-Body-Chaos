class Particle {
  double x, y;
  double gravityForce;
  double velocityX = 0;
  double velocityY = 0;
  double accX = 0;
  double accY = 0;
  double dirX;
  double dirY;
  float r;
  int c;
  Particle(double _x, double _y, float _r, double _gravityForce, int _c) {
    x = _x;
    y = _y;
    gravityForce = _gravityForce;
    r = _r;
    c = _c;
  }
  void show() {
    fill(c);
    stroke(0);
    ellipse((float)x, (float)y, 2*r, 2*r);
    stroke(c);
    //line((float)x, (float)y, (float)(dirX*20 + x), (float)(dirY*20 + y));
    //line((float)x, (float)y, (float)(velocityX*2 + x), (float)(velocityY*2 + y));
    //line((float)x, (float)y, (float)(accX*30 + x), (float)(accY*30 + y));
  }
  void update() {
    velocityX += accX;
    velocityY += accY;
    accX = 0;
    accY = 0;
    x += velocityX;
    y += velocityY;
  }
  void getForce(Particle[] P) {
    for (Particle p : P) {
      if (p != this) {
        dirX = p.x - x;
        dirY = p.y - y;
        double mdir = Math.sqrt(dirX*dirX + dirY*dirY);
        dirX /= mdir;
        dirY /= mdir;
        accX += dirX*p.gravityForce;
        accY += dirY*p.gravityForce;
      }
    }
  }
};
