PImage img;
int i, j, cont = 0;
double A, B, C, Delta;
double a = 0.0, b = 0.0, c = 150.0, r = 100.0; //centro(a,b,c) e raio(r)
double x = 0.0, y = 0.0, z = -30.0;       //camera(x,y,z)

void setup() {
  size(600,400);
  img = createImage(600,400, RGB);
}
   
void draw(){
  for (i=-300; i<300; i++){
    for (j=-200; j<200; j++){
      A = (i*i) - 2*(i*x) + (x*x) + (j*j) - 2*(j*y) + (y*y) + (z*z);
      B = 2*(i*i) - 2*(i*x) - 2*(i*a) + 2*(x*a) + 2*(j*j) - 2*(j*y) - 2*(j*b) + 2*(y*b) + 2*(c*z);
      C = (i*i) - 2*(i*a) + (a*a) + (j*j) - 2*(b*j) + (b*b) + (c*c) - (r*r);
      
      Delta = (B*B)-(4*A*C);
      if (Delta<0.0) set(i+300,j+200,color(255,255,255));
      else           set(i+300,j+200,color(0,0,0));
   }
  }
  
  c = c + 60;  cont = cont + 1;
  saveFrame("centro"+cont+".png");  
  if(cont>3) noLoop();
}
