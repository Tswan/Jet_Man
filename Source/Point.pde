class Point
{
  protected Box2DProcessing mBox2DRef;
  protected Body mBody;
  private float mWidth;
  private float mHeight; 
  private color mColor = color(255,255,255);
  protected PImage sprite_img;
  private boolean delete = false;
  
  Point(Box2DProcessing box2D, PImage img){
   
    sprite_img = img;
    mWidth  = img.width;
    mHeight = img.height;
    
    mBox2DRef = box2D;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position = mBox2D.coordPixelsToWorld(random(width),random(height));
    bd.setFixedRotation(true);
    mBody = mBox2D.createBody(bd);
    
    PolygonShape base = new PolygonShape();
    float box2DW = mBox2D.scalarPixelsToWorld(mWidth/2f);
    float box2DH = mBox2D.scalarPixelsToWorld(mHeight/2f);
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
    
    Vec2 pos = mBox2D.getBodyPixelCoord(mBody);
    float angle = -mBody.getAngle();
    
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(angle);
      imageMode(CENTER);
      image(sprite_img,0,0);
    popMatrix();
    
  }
  
  
  void delete() 
  {
    delete = true;
    //println("deleted");
   //mBox2D.destroyBody(mBody);
   //mBody.setTransform(new Vec2(random(width),random(height)),0);
    
  }
  
  boolean done()
  {  
   // println("done");
   if(delete)
     mBox2D.destroyBody(mBody);
     
   return delete;
    
  }
  
}