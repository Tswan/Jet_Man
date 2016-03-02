class Bridge {

  float totalLength;  
  int numPoints; 

  ArrayList<RectBody> particles;

  // Chain constructor
  Bridge(float l, int n) {

    totalLength = l;
    numPoints = n;

    particles = new ArrayList();

    float len = totalLength / numPoints;

    
    for(int i=0; i < numPoints+1; i++) {
      
      RectBody p = null;
      
      
      if (i == 0 || i == numPoints) p = new RectBody(i*len+width/4,height/2,10,10,BodyType.STATIC,mBox2D);
      else p = new RectBody(i*len+width/4,height/2,10,10,BodyType.DYNAMIC,mBox2D);
      particles.add(p);

      
      if (i > 0) {
         DistanceJointDef djd = new DistanceJointDef();
         RectBody previous = particles.get(i-1);
         
         djd.bodyA = previous.mBody;
         djd.bodyB = p.mBody;
         
         djd.length = mBox2D.scalarPixelsToWorld(len);
         
         djd.frequencyHz = 0;
         djd.dampingRatio = 1000;
         
         
         DistanceJoint dj = (DistanceJoint) mBox2D.world.createJoint(djd);
      }
    }
  }

  // Draw the bridge
  void draw() {
    for (RectBody p: particles) {
      p.draw();
    }
  }

}