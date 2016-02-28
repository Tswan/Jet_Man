import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;

Box2DProcessing mBox2D;
RectBody ground;
Point gem_sprite;
PImage gem_img; 
JetMan jetman;
RectBody a;

ArrayList<Point> points;

//GUI stuff
PFont f;
int playerScore = 0;

void setup()
{
  size(600,400);
  
  mBox2D = new Box2DProcessing(this);
  mBox2D.createWorld();
  mBox2D.setGravity(0.0f,-9.8f);
  gem_img = loadImage("Gem.png");
  
  float boundaryWidth = 10f;
  
  ground = new RectBody(width/2f,height-boundaryWidth/2f,width,boundaryWidth,BodyType.STATIC,mBox2D);
  gem_sprite = new Point(mBox2D, gem_img);
  jetman = new JetMan(100, 60, mBox2D);
  a = new RectBody(210, 60,gem_img.width,gem_img.height,BodyType.DYNAMIC,mBox2D);
  
  points =  new ArrayList<Point>();
  points.add(gem_sprite);
  
  // Turn on collision listening!
  mBox2D.listenForCollisions();
  
  //GUI Stuff
  f = createFont("maven.otf", 24);
  textFont(f);
  
}

void draw()
{
  background(0);
  
  //removeBodies();
  
  
  
  mBox2D.step();
  
  if (mousePressed) {
    jetman.applyVelocity(mouseX,mouseY);
  }
  
  jetman.update();
  
  ground.draw();
  a.draw();
  jetman.draw();
  
  for(int i = points.size()-1; i>= 0; i--)
  {
    Point p = points.get(i);
    p.draw();
    if(p.done())
    {
      points.remove(i);
      points.add(new Point(mBox2D, gem_img));
    }
  }
  
  drawType();
  
}

void drawType()
{
  fill(255);
  String score = "score: " + playerScore;
  pushMatrix();
    translate(10,30);
    text(score,0,0);
  popMatrix();  
  println(score);
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) 
    {
      jetman.move("up");
    }
    
    if (keyCode == LEFT) 
    {
      jetman.move("left");
    }
    
    if (keyCode == RIGHT) 
    {
      jetman.move("right");
    }
    
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) 
    {
      jetman.stopMove("up");
    }
    
    if (keyCode == LEFT) 
    {
      jetman.stopMove("left");
    }
    
    if (keyCode == RIGHT) 
    {
      jetman.stopMove("right");
    }
    
  }
}

// Collision event functions!
void beginContact(Contact cp) {
  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if (o1.getClass() == Point.class)
  {
    Point p1 = (Point) o1;
    p1.delete();
    playerScore++;
  }
  if(o2.getClass() == Point.class) 
  {
    Point p2 = (Point) o2;
    p2.delete();
    playerScore++;
  }

}

// Objects stop touching each other
void endContact(Contact cp) {
}