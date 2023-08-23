/**
 * Model movement of piston in cylinder: 
 *    where stroke = 2.0; so throw = 1.0  
 **/
float crodL = 4.0;          // conrod length
float alpha = 0.0;          // crank angle degrees 
float aVeloc = 1.0;         // angular velocity (deg/loop)
int cLine = 220;            // centre line (vert)
int sHght = 480;            // crankshaft height
float scale = 60;
boolean rotate = true;
//boolean saveFrames = true;
boolean saveFrames = false;
int frameCtr = 0;

void setup() {
  size(600, 600);
  //rectMode(CENTER);
  //noStroke();               // disables drawing the stroke (outline)
  //fill(0, 102, 153, 64);   // sets the colour used to fill shapes (rgba)
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
      case LEFT:
        println("Left arrow pressed");
        //zXadj -= adjDelta;
        break;
    }
  }
  else {
    switch (key) {
      case '+': 
        alpha += 1.0;
        break;
      case '-': 
        alpha += -1.0;
        break;
      case 'p':    // pause/play toggle
        rotate = !rotate;
        break;
    }
  }
}

void draw() {
  background(180);      // sets the background colour (255=white)
  
  float alph = radians(alpha);
  float sinA = sin(alph);
  float cosA = cos(alph);
  
  float bigEndX = cLine + scale*sinA;
  float bigEndY = sHght - scale*cosA;
  float gDist = cosA + sqrt(cosA*cosA + crodL*crodL - 1);   // distance to gudgeon
  float gudgY = sHght - scale*gDist;
  float cosB = (crodL*crodL + 1 - gDist*gDist) / (2*crodL); 
  float beta = degrees(acos(cosB));      // angle at big end (conrod & throw)
  float sinG = sinA / crodL;
  float gamma = degrees(asin(sinG));     // angle of conrod from verticle
  
  strokeWeight(12);  // thick
  line(bigEndX, bigEndY, cLine, gudgY);  // draw connecting rod
  strokeWeight(22);  // very thick 
  line(bigEndX, bigEndY, cLine, sHght);  // draw throw web
  strokeWeight(8); 
  circle(bigEndX, bigEndY, 40);          // big end journal
  
  circle(cLine, gudgY, 30);              // gudgeon pin
  float pDescent = crodL + 1 - gDist;    // piston descent
  float pctDesct = pDescent * 50; 
  
  //stroke(100);
  //strokeWeight(12);  // Thicker
  //line(bigEndX, bigEndY, cLine, gudgY);   // draw connecting rod
  
  circle(cLine, sHght, 50);               // draw crankshaft
  
  float pPos1X = cLine - 1.2*scale;       // piston position
  float pPos1Y = gudgY + 0.5*scale;
  float pPos2X = pPos1X; 
  float pPos2Y = gudgY - scale;
  float pPos3X = cLine + 1.2*scale;
  float pPos3Y = pPos2Y; 
  float pPos4X = pPos3X; 
  float pPos4Y = pPos1Y;
  strokeWeight(6); 
  line(pPos1X, pPos1Y, pPos2X, pPos2Y);   // draw piston
  line(pPos2X, pPos2Y, pPos3X, pPos3Y);
  line(pPos3X, pPos3Y, pPos4X, pPos4Y);
  
  float cwXl = pPos1X - 10; float cwXr = pPos3X + 10;               // cyl wall left/right
  float cwYb = sHght - 100; float cwYt = sHght - (crodL+2)*scale;   // cyl wall bottom/top
  line(cwXl, cwYb, cwXl, cwYt);
  line(cwXr, cwYb, cwXr, cwYt);
  
  textSize(24);
  text("Piston Motion", 200, 20); 
  textSize(18); 
  text("where Stroke = 2.0 and Con Rod length = " + nf(crodL,1,2), 90, 50); 
  text("Crank Angle: "+str(alpha)+"\u00B0", 400,140); 
  //text("Descent: "+str(pDescent), 380,140); 
  text("Descent: "+nf(pDescent,1,3), 420,200);     //     nf(zR,1,3)
  text(nf(pctDesct,1,1) + "%", 480,220);
  text("Con Rod Angle: "+nf(gamma,1,1)+"\u00B0", 400,300);
  text("Big End Angle: "+nf(beta,1,1)+"\u00B0", 400,320);
  textSize(14);
  text("press P to Pause/Play", 400, 440);
  text("press + or - adv/ret 1 deg", 400, 460);
  
  if (rotate) 
    { 
    alpha = alpha + aVeloc;
    if (saveFrames && frameCtr < 100) 
      { saveFrame("Piston-###.png"); 
        frameCtr += 1;
      }
    }
  if (alpha >= 360) 
    {alpha = 0.0;}
  
  delay(50);     // to prevent app becoming CPU bound
}
