import netP5.*;
import oscP5.*;

OscP5 mOSC;

void setup()
{
  size(200, 200);
  String yourIP = "172.17.104.132"; //You need to put your IP here
  mOSC = new OscP5(this,yourIP, 8888);
}

void draw()
{
}

void mousePressed()
{
  OscMessage message = new OscMessage("/shoot/missle");
  
  message.add(1);
  
  mOSC.send(message);
}