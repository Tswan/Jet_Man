class JetMan extends SpriteBody
{

  JetMan( float xInit, float yInit, Box2DProcessing box2D)
  {
    super(xInit, yInit, BodyType.DYNAMIC, box2D, loadImage("JetMan.png"));
  }
  
  
  
  
}