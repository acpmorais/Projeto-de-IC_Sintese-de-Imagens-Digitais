PImage img;
int i, j, m, cont = 0; //ponto no plano de projeção(i,j,0) 
double A, B, C, Delta, n, cosang, t1; //raiz da equação do segundo grau(t1)
double a = 0.0, b = 0.0, c = 150.0, r = 100.0; //centro(a,b,c) e raio(r)
double x, y, z; //coordenada do vetor que vai da posicao da camera para a esfera(x,y,z)
double p = 0.0, q = -200.0, w = 300.0; //coordenadas da posicao da luz
double modv, modu; //modulo dos vetores v,u
double xc = 0.0, yc = 0.0, zc = -100; //camera(xc,yc,zc)  
  
void setup() {
  size(600,400);
  img = createImage(600,400, RGB);
}

void draw(){
  for (i=-300; i<300; i++){
    for (j=-200; j<200; j++){
      A = (i*i) - 2*(i*xc) + (xc*xc) + (j*j) - 2*(j*yc) + (yc*yc) + (zc*zc);
      B = 2*(i*i) - 2*(i*xc) - 2*(i*a) + 2*(xc*a) + 2*(j*j) - 2*(j*yc) - 2*(j*b) + 2*(yc*b) + 2*(c*zc);
      C = (i*i) - 2*(i*a) + (a*a) + (j*j) - 2*(b*j) + (b*b) + (c*c) - (r*r);
      
      Delta = (B*B)-(4*A*C);
      t1 = (-B + raiz(Delta))/(2*A);
      x = i + (t1 * i);  y = j + (t1 * j);  z = t1 * zc;
      
      modv = raiz((i-x)*(i-x) + (j-y)*(j-y) + (-z)*(-z));
      modu = raiz((p-x)*(p-x) + (q-y)*(q-y) + (w-z)*(w-z));
      cosang = (((i-x)*(p-x)) + ((j-y)*(q-y)) + (-z*(w-z)))/(modv*modu);
      n = 255*cosang;
      m = (int) n;
      
      if (Delta<0.0) { set(i+300,j+200,color(255,255,255)); }
      else           { set(i+300,j+200,color(m,m,0)); }
   }
  }
  p = p + 10;  q = q + 50;  w = w + 10;  cont = cont + 1;
  saveFrame("sombra-###("+p+","+q+","+w+").png"); 
  if(cont>20) noLoop();
}

double raiz( double num ) {
  double a, b, c, d = 0.0;
  a = 0.0;      // println(a);
  b = 2.0*num;  // println(b);
  c = b-a;      // println(c);
  while (c>0.0001){
      d = (a+b)/2.0; // println(d);
      if ((d*d)<=num) { a = d; } // println(a);
      else            { b = d; } //println(b);
      c = b-a;
  }//end-while
 
  return(d);
} 
