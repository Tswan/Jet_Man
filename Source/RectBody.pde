class RectBody
{
  
  protected Box2DProcessing mBox2DRef;
  public Body mBody;
  private float mWidth;
  private float mHeight; 
  private color mColor = color(255,0,0);
  
  RectBody(float xInit, float yInit, float initWidth, float initHeight, BodyType type, Box2DProcessing box2D)
  {
    mWidth  = initWidth;
    mHeight = initHeight;
    
    mBox2DRef = box2D;
    
    BodyDef bd = new BodyDef();
    bd.type = type;
    bd.position = mBox2DRef.coordPixelsToWorld(xInit,yInit);
     bd.setFixedRotation(true);
    mBody = mBox2DRef.createBody(bd);
    
    PolygonShape rs = new PolygonShape();
    float box2DW = mBox2DRef.scalarPixelsToWorld(mWidth/2f);
    float box2DH = mBox2DRef.scalarPixelsToWorld(mHeight/2f);
    rs.setAsBox(box2DW,box2DH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = rs;
    fd.density = 1f * 4.0f/(mWidth*mHeight);
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
      fill(mColor);      
      rectMode(CENTER);
      rect(0,0,mWidth,mHeight);
    popMatrix();
  }
  
  
  
}