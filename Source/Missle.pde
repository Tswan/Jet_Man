class Missle
{
  private PImage sprite_img;
  private int mWidth;
  private int mHeight;
  private int time;
  private int timeDelay = 5000;
  protected Body mBody;
  private boolean delete = false;
  
  
  Missle()
  {
    time = millis();
    sprite_img = missle_img;
    mWidth  = missle_img.width;
    mHeight = missle_img.height;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position = mBox2D.coordPixelsToWorld(random(width),-40);//random(height));
    
    mBody = mBox2D.createBody(bd);
    
    PolygonShape missle = new PolygonShape();
    
    float box2DW = mBox2D.scalarPixelsToWorld(mWidth/2f);
    float box2DH = mBox2D.scalarPixelsToWorld(mHeight/2f);
    missle.setAsBox(box2DW,box2DH);
    FixtureDef fd = new FixtureDef();
    fd.shape = missle;
    fd.density = 1f * 4.0f/(mWidth*mHeight);
    fd.friction = 0.3f;
    fd.restitution = 0.1f;
    
    mBody.createFixture(fd);
    
    mBody.setUserData(this);
  }
  
  void update()
  {
    followJetMan(jetman.getPosition());
    if(millis() - time >= timeDelay)
      delete = true;
  }
  
  void draw()
  {
    Vec2 pos = mBox2D.getBodyPixelCoord(mBody);
    float angle = -mBody.getAngle();
    
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(angle);
      imageMode(CENTER);
      image(sprite_img,0,0);
    popMatrix();
  }
  
  void rotateInDirection(Vec2 toTarget)
  {
    float desiredAngle = atan2(-toTarget.x,toTarget.y);
    mBody.setTransform(mBody.getPosition(),desiredAngle);
  }
  
  void followJetMan(Vec2 target)
  {
    target = mBox2D.coordPixelsToWorld(target.x,target.y);
    Vec2 bodyVec = mBody.getWorldCenter();
    target.subLocal(bodyVec);
    rotateInDirection(target);
    target.normalize();
    target.mulLocal((float) 2 );
    mBody.applyForce(target, bodyVec); 
  }
  
  
  boolean done()
  {  
   
   if(delete)
     mBox2D.destroyBody(mBody);
     
   return delete;
    
  }
  
}