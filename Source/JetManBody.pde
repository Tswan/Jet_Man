class JetManBody
{
  
  protected Box2DProcessing mBox2DRef;
  protected Body mBody;
  private float mWidth;
  private float mHeight; 
  private color mColor = color(255,255,255);
  protected PImage sprite_img;
  protected boolean stopped = false;
  protected float direction;
  JetManBody(float xInit, float yInit, BodyType type, Box2DProcessing box2D, PImage img)
  {
    direction = 1.0;
    sprite_img = img;
    mWidth  = img.width;
    mHeight = img.height;
    
    mBox2DRef = box2D;
    
    BodyDef bd = new BodyDef();
    bd.type = type;
    bd.position = mBox2DRef.coordPixelsToWorld(xInit,yInit);
    bd.setFixedRotation(true);
    
    if(bd.position.y > 337)
      stopped = true;
    
    mBody = mBox2DRef.createBody(bd);
    
    PolygonShape right = new PolygonShape();
    Vec2[] rvertices = new Vec2[8];
    rvertices[0] = mBox2DRef.vectorPixelsToWorld(new Vec2(33.5, -40.8));
    rvertices[1] = mBox2DRef.vectorPixelsToWorld(new Vec2(10.5, -50.8));
    rvertices[2] = mBox2DRef.vectorPixelsToWorld(new Vec2(-33.5, -10.8));    
    rvertices[3] = mBox2DRef.vectorPixelsToWorld(new Vec2(-33.5, 30.8));
    rvertices[4] = mBox2DRef.vectorPixelsToWorld(new Vec2(0.5, 40.8));
    rvertices[5] = mBox2DRef.vectorPixelsToWorld(new Vec2(0.5, 50.8));
    rvertices[6] = mBox2DRef.vectorPixelsToWorld(new Vec2(33.5, 50.8));
    rvertices[7] = mBox2DRef.vectorPixelsToWorld(new Vec2(10.75, 13.79));
    
   right.set(rvertices, rvertices.length);
   
   
    
    
    FixtureDef fd = new FixtureDef();
    
    fd.shape = right;
    fd.density = -1f;
    fd.friction = 0.3f;
    fd.restitution = 0.1f;
    
    mBody.createFixture(fd);
    
    mBody.setUserData(this);
    
  }
  
  void draw()
  {
    Vec2 pos = mBox2DRef.getBodyPixelCoord(mBody);
    float angle = -mBody.getAngle();
    
    Fixture f = mBody.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(angle);
      scale(direction, 1.0);
      imageMode(CENTER);
      image(sprite_img,0,0);
      /*rectMode(CENTER);
      beginShape();
      //println(vertices.length);
      // For every vertex, convert to pixel vector
      for (int i = 0; i < ps.getVertexCount(); i++) {
        Vec2 v = mBox2DRef.vectorWorldToPixels(ps.getVertex(i));
        vertex(v.x, v.y);
      }
      endShape(CLOSE);*/
    popMatrix();
    
  }
  
  void applyVelocity(float x,float y)
  {
    Vec2 bodyVec = mBody.getWorldCenter();
    Vec2 worldTarg =  mBox2DRef.coordPixelsToWorld(x,y);
    worldTarg.subLocal(bodyVec);
    worldTarg.normalize();
    direction = round(worldTarg.x) == -1 ? -1 : 1;
    //println(worldTarg);
    worldTarg.mulLocal((float) 70);
    //println("Body vector: "+bodyVec);
    //println("World target: "+worldTarg);
    mBody.applyForce(worldTarg, bodyVec);
    
  }
  
  void applyVelocity(Vec2 movement)
  {
    stopped = false;
    Vec2 bodyVec = mBody.getWorldCenter();
    Vec2 target = bodyVec.add(movement);
    target.subLocal(bodyVec);
    target.normalize();
    direction = target.x == -1 ? -1 : 1;
    target.mulLocal((float) 100);
    mBody.applyForce(target, bodyVec);
  }
  void stopVelocity()
  {
    stopped = true;

  }
  
  
  void destroyBody()
  {
    
  }
  
}