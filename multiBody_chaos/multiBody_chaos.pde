import com.google.gson.Gson;
Particle[] p1;
Particle[] p2;
int Particles = 3;
double starting_error = 1e-08;
float radius = 2.5;
float force = 0.1;
ArrayList<Double> time, dis, acc, accX, accY, vel, velX, velY, posX, posY;
ArrayList<ArrayList> master;
double t = 0;
void setup() {
  fullScreen();
  ellipseMode(RADIUS);
  double x1[] = new double[Particles];
  double y1[] = new double[Particles];
  double x2[] = new double[Particles];
  double y2[] = new double[Particles];
  p1 = new Particle[Particles];
  p2 = new Particle[Particles];
  time = new ArrayList<Double>();
  dis = new ArrayList<Double>();
  acc = new ArrayList<Double>();
  accX = new ArrayList<Double>();
  accY = new ArrayList<Double>();
  velX = new ArrayList<Double>();
  velY = new ArrayList<Double>();
  vel = new ArrayList<Double>();
  posX = new ArrayList<Double>();
  posY = new ArrayList<Double>();
  for (int i = 0; i < Particles; i++) {
    double x = random(-400, 400);
    double y = random(-400, 400);
    x1[i] = x;
    x2[i] = x;
    y1[i] = y;
    y2[i] = y;
  }
  x2[0] += starting_error;
  for (int i = 0; i < Particles; i++) {
    p1[i] = new Particle(x1[i], y1[i], radius, force, color(255, 0, 0));
    p2[i] = new Particle(x2[i], y2[i], radius, force, color(0, 0, 255));
  }
}

void draw() {
  background(0);
  t += 0.001;
  double sumX = 0, sumY = 0;
  for (Particle P : p2) {
    sumX += P.x;
    sumY += P.y;
  }
  sumX /= p2.length;
  sumY /= p2.length;
  fill(0, 255, 0);
  translate(-(float)sumX + width/2, -(float)sumY + height/2);
  ellipse((float)sumX, (float)sumY, 5, 5);
  for (int i = 0; i < Particles; i++) {
    p1[i].show();
    p2[i].show();
    p1[i].update();
    p2[i].update();
  }
  double disum = 0;
  for (int i = 0; i < Particles; i++) {
    p1[i].getForce(p1);
    p2[i].getForce(p2);
    disum += Math.sqrt((p1[i].x-p2[i].x)*(p1[i].x-p2[i].x) + (p1[i].y-p2[i].y)*(p1[i].y-p2[i].y));
  }
  disum /= (double)Particles;
  time.add(t);
  dis.add(disum);
  acc.add(Math.sqrt(p1[0].accX * p1[0].accX + p1[0].accY * p1[0].accY));
  accX.add(p1[0].accX);
  accY.add(p1[0].accY);
  vel.add(Math.sqrt(p1[0].velocityX * p1[0].velocityX + p1[0].velocityY * p1[0].velocityY));
  velX.add(p1[0].velocityX);
  velY.add(p1[0].velocityY);
  posX.add(p1[0].x);
  posY.add(p1[0].y);
}
void keyPressed() {
  if (key == 'r') {
    setup();
  }
  if(key == 's'){
    master = new ArrayList<ArrayList>();
    master.add(time);
    master.add(dis);
    master.add(acc);
    master.add(accX);
    master.add(accY);
    master.add(vel);
    master.add(velX);
    master.add(velY);
    master.add(posX);
    master.add(posY);
    Gson gson = new Gson();
    String jsonarray[] = new String[1];
    jsonarray[0] = gson.toJson(master);
    saveStrings("data.json", jsonarray);
  }
}
