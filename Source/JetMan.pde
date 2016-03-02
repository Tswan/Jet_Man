class JetMan extends JetManBody
{
  private boolean flying = false;
  private Vec2 velocity;
  private float angle;
  
  
  JetMan( float xInit, float yInit, Box2DProcessing box2D)
  {
    
    super(xInit, yInit, BodyType.DYNAMIC, box2D, loadImage("JetMan.png"));
    velocity = new Vec2( 0, 0 );
  }
  
  public void update()
  {
    //println(mBox2DRef.getBodyPixelCoord(mBody).y);
    //println(height);
    if(mBox2DRef.getBodyPixelCoord(mBody).y >= height-62 && stopped)
    {  
      mBody.setLinearVelocity(new Vec2(0,0));
      stopped = false;
    }
    
  }
  
  public void move(String direction)
  {
    
    if(direction == "up")
    {
      flying = true;
      velocity.set(new Vec2(0,500));
      
    }
    if(direction == "left")
    {
      velocity.set(new Vec2(-1,0));
      //super.direction = -1.0f;
    }
    if(direction == "right")
    {
      velocity.set(new Vec2(1,0));
      //super.direction = 1.0f;
    }
    applyVelocity(velocity);
    velocity.mul(0);
  }
  
  public void stopMove(String direction)
  {
    if(direction == "up")
    {
      flying = false;
    }
    stopVelocity();
    velocity.mul(0);
  }
  public void stopMove()
  {
    stopVelocity();
    velocity.mul(0);
  }
  
  
}