class Ground {
  
  protected Box2DProcessing mBox2DRef;
  ArrayList<Vec2> ground;


  Ground(Box2DProcessing box2D) {
    
    mBox2DRef = box2D;
    ground = new ArrayList<Vec2>();

    // This is what box2d uses to put the surface in its world
    ChainShape chain = new ChainShape();

    // Perlin noise argument
    float xoff = 0.0;

    // This has to go backwards so that the objects  bounce off the top of the surface
    // This "edgechain" will only work in one direction!
    for (float x = width+10; x > -10; x -= 5) {

      
      float y;
      if (x > width/2 && x < (3*width/4)) 
      {
        y = 100 + (width - x)*1.1 + map(noise(xoff),0,1,-80,80);
      }
      else if (x > width/4 && x <= width/2)
      {
        y = 100 + x*1.1 + map(noise(xoff),0,1,-80,80);
      }
      else 
      {
        y = height/2 + map(noise(xoff),0,1,-20,20);
      }
      
      
      ground.add(new Vec2(x,y));

      xoff += 0.1;

    }
    
    Vec2[] vertices = new Vec2[ground.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = mBox2DRef.coordPixelsToWorld(ground.get(i));
      vertices[i] = edge;
    }
    
    chain.createChain(vertices,vertices.length);
    
    
    BodyDef bd = new BodyDef();
    bd.position.set(0.0f,0.0f);
    Body body = mBox2DRef.createBody(bd);
    body.createFixture(chain,1);
    body.setUserData(this);
  }

  // A simple function to just draw the edge chain as a series of vertex points
  void draw() {
    strokeWeight(2);
    stroke(255);
    noFill();
    beginShape();
    for (Vec2 v: ground) {
      vertex(v.x,v.y);
    }
    endShape();
  }

}