class SpriteBody extends RectBody
{
  PImage sprite_img;
  
  SpriteBody( float xInit, float yInit, BodyType type, Box2DProcessing box2D, PImage img)
  {
    super(xInit, yInit, img.width, img.height, type, box2D);
    sprite_img = img;
  }
  
  void draw()
  {
    Vec2 pos = super.mBox2DRef.getBodyPixelCoord(super.mBody);
    float angle = -super.mBody.getAngle();
    
    pushMatrix();
      translate(pos.x,pos.y);
      rotate(angle);
      imageMode(CENTER);
      image(sprite_img,0,0);
    popMatrix();
  }
  
}