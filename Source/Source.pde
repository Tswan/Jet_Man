import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;

Box2DProcessing mBox2D;
RectBody ground;
JetMan jetMan;

void setup()
{
  size(600,400);
  
  mBox2D = new Box2DProcessing(this);
  mBox2D.createWorld();
  mBox2D.setGravity(0.0f,-9.8f);
  
  float boundaryWidth = 10f;
  ground = new RectBody(width/2f,height-boundaryWidth/2f,width,boundaryWidth,BodyType.STATIC,mBox2D);
  jetMan = new JetMan(mBox2D);
}

void draw()
{
  background(200);
  mBox2D.step();
  
  ground.draw();
  jetMan.draw();
  
}