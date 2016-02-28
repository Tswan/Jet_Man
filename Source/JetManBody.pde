class JetManBody
{
  
  protected Box2DProcessing mBox2DRef;
  protected Body mBody;
  private float mWidth;
  private float mHeight; 
  private color mColor = color(255,255,255);
  protected PImage sprite_img;
  
  JetManBody(float xInit, float yInit, BodyType type, Box2DProcessing box2D, PImage img)
  {
    sprite_img = img;
    mWidth  = img.width;
    mHeight = img.height;
    
    mBox2DRef = box2D;
    
    BodyDef bd = new BodyDef();
    bd.type = type;
    bd.position = mBox2DRef.coordPixelsToWorld(xInit,yInit);
    bd.setFixedRotation(true);
    mBody = mBox2DRef.createBody(bd);
    
    PolygonShape base = new PolygonShape();
    float box2DW = mBox2DRef.scalarPixelsToWorld(mWidth/2f);
    float box2DH = mBox2DRef.scalarPixelsToWorld(mHeight/2f);
    base.setAsBox(box2DW, box2DH);
    
    
    FixtureDef fd = new FixtureDef();
    
    fd.shape = base;
    fd.density = 1.0f;
    fd.friction = 0.3f;
    fd.restitution = 0.1f;
    
    mBody.createFixture(fd);
    
    mBody.setUserData(this);
    
  }
  
  void draw()
  {
    Vec2 pos = mBox2DRef.getBodyPixelCoord(mBody);
    float angle = -mBody.getAngle();
    
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(angle);
      imageMode(CENTER);
      image(sprite_img,0,0);
    popMatrix();
    
  }
  
  void applyVelocity(Vec2 movement)
  {
    mBody.setLinearVelocity(movement);
  }
  
  void destroyBody()
  {
    
  }
  
}