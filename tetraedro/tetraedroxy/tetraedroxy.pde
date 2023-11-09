PImage img;

void setup() {
  size(32,32);
  background(255,255,255);
  img = createImage(600,400, RGB);
  
  float[] p1 = {+100.0, +100.0, +100.0};
  float[] p2 = {+100.0, -100.0, -100.0};
  float[] p3 = {-100.0, +100.0, -100.0};
  float[] p4 = {-100.0, -100.0, +100.0};
  
  projecaoxy(p1,p2,p3);
  projecaoxy(p1,p2,p4);
  projecaoxy(p2,p3,p4);
  projecaoxy(p3,p1,p4);
  
  img.save("tetraedroxy.png");
  
  /*projecao(p1,p2,p3);
  projecao(p1,p2,p4);
  projecao(p2,p3,p4);
  projecao(p3,p1,p4);
  
  img.save("convexcombyz.png");
  
  projecao(p1,p2,p3);
  projecao(p1,p2,p4);
  projecao(p2,p3,p4);
  projecao(p3,p1,p4);
  
  img.save("convexcombzx.png");*/
  
  exit();
}
  
void projecaoxy(float p1[], float p2[], float p3[]){
  float alpha, beta, gamma;
  float [] r = new float[3];
  float [] s = new float[3];
  float [] t = new float[3];
  beta = 1.0;
  for(int i = 0; i< 600; i++){ for(int j = 0; j< 400; j++) { img.set(i,j,color(255,255,255)); }}
  for (alpha = 0.0; alpha < 1.0; alpha += 0.01){
    beta = 1.0 - alpha;
    
    r[0] = (alpha*p1[0]) + (beta*p2[0]);
    r[1] = (alpha*p1[1]) + (beta*p2[1]);
    r[2] = (alpha*p1[2]) + (beta*p2[2]);
    
    s[0] = (alpha*p1[0]) + (beta*p3[0]);
    s[1] = (alpha*p1[1]) + (beta*p3[1]);
    s[2] = (alpha*p1[2]) + (beta*p3[2]);
    
    for (gamma = 0.0; gamma < 1.0; gamma += 0.01){
      t[0] = (gamma*r[0]) + ((1.0-gamma)*s[0]);
      t[1] = (gamma*r[1]) + ((1.0-gamma)*s[1]);
      t[2] = (gamma*r[2]) + ((1.0-gamma)*s[2]);
      t[0] = t[0] + 300.0;
      t[1] = t[1] + 200.0;
      t[2] = t[2] + 500.0;
      img.set(((int)t[0]),((int)t[1]),color(((int)(alpha*255)),((int)(beta*255)),((int)(gamma*255))));
    }

    img.set(((int)r[0]+300),((int)r[1]+200),color(255,0,0));
    img.set(((int)s[0]+300),((int)s[1]+200),color(0,0,255));
  
    beta = 1.0 - alpha;
  } 
}
