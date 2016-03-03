import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;

import netP5.*;
import oscP5.*;

//OSC Variable
OscP5 mOSC;

//Box2D Variables
Box2DProcessing mBox2D;
Ground ground;
Bridge bridge;
Point gem_sprite; 
JetMan jetman;
Missle a;
ArrayList<Point> points;
ArrayList<Missle> missles;

//Images
PImage gem_img;
PImage missle_img;

//

//GUI stuff
PFont f;
int playerScore = 0;

void setup()
{
  size(1080,720);
  
  String yourIP = "172.17.104.132"; //You need to put your IP here
  mOSC = new OscP5(this,yourIP, 8888); //has to be these numbers for multicast abilities
  mOSC.plug(this, "missleTriggerOSCPlug", "/shoot/missle"); //a plug is a function that will be called when we receive a message from a particular address

  
  mBox2D = new Box2DProcessing(this);
  mBox2D.createWorld();
  mBox2D.setGravity(0.0f,-9.8f);
  gem_img = loadImage("Gem.png");
  missle_img = loadImage("Missle.png");
  
  float boundaryWidth = 10f;
  
  
  gem_sprite = new Point(mBox2D, gem_img);
  jetman = new JetMan(100, 60, mBox2D);
  ground = new Ground(mBox2D);
  bridge = new Bridge(width/2,width/30);
  //a = new Missle();//(210, 60,gem_img.width,gem_img.height,BodyType.DYNAMIC,mBox2D);
  
  points =  new ArrayList<Point>();
  points.add(gem_sprite);
  
  missles = new ArrayList<Missle>();
  
  // Turn on collision listening!
  mBox2D.listenForCollisions();
  
  //GUI Stuff
  f = createFont("maven.otf", 24);
  textFont(f);
  
}

void draw()
{
  background(0);  
  
  mBox2D.step();
  
  if (mousePressed) {
    jetman.applyVelocity(mouseX,mouseY);
  }
  
  jetman.update();
  
  ground.draw();
  bridge.draw();
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
  
  for(int i = missles.size()-1; i>= 0; i--)
  {
    Missle m = missles.get(i);
    m.update();
    m.draw();
    if(m.done())
    {
      missles.remove(i);
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
}

void missleTriggerOSCPlug(int msg)
{  
  if(msg == 1)
    missles.add(new Missle());
}

void keyPressed() {
  if (key == CODED) 
  {
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
  if (key == CODED) 
  {
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

void mouseReleased()
{
  jetman.stopMove();
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
  
  if (o1.getClass() == Point.class && o2.getClass() == JetMan.class)
  {
    Point p1 = (Point) o1;
    p1.delete();
    playerScore++;
  }
  if(o2.getClass() == Point.class && o1.getClass() == JetMan.class) 
  {
    Point p2 = (Point) o2;
    p2.delete();
    playerScore++;
  }

}

// Objects stop touching each other
void endContact(Contact cp) {
}