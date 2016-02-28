class JetMan extends JetManBody
{
  private boolean flying;
  private Vec2 velocity;
  private float angle;
  
  JetMan( float xInit, float yInit, Box2DProcessing box2D)
  {
    
    super(xInit, yInit, BodyType.DYNAMIC, box2D, loadImage("JetMan.png"));
    flying = false;
    //acceleration = new Vec2( 0, 0 );
    velocity = new Vec2( 0, 0 );
  }
  
  public void update()
  {
    //println(super.mBody.getAngularVelocity());
    //super.mBody.setAngularVelocity(0);//-super.mBody.getAngularVelocity());
    //if(flying == false)
      //super.mBody.setLinearVelocity(new Vec2(0,-9.8));
    
    
    //angle = -super.mBody.getAngle();
  }
  
  public void move(String direction)
  {
    
    if(direction == "up")
    {
      flying = true;
      velocity.set(new Vec2(0,1000));
      
    }
    if(direction == "left")
    {
      velocity.set(new Vec2(-10,0));
    }
    if(direction == "right")
    {
      velocity.set(new Vec2(10,0));
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
    if(direction == "left")
    {
      velocity.set(new Vec2(-50,0));
    }
    if(direction == "right")
    {
      velocity.set(new Vec2(50,0));
    }
    applyVelocity(velocity);
    velocity.mul(0);
  }
  
  
  
}