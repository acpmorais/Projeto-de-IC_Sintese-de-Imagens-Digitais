PImage img;

void projecao(double a, double b,double c,double r,double xc,double yc,double zc,double p,double q,double w,int count){
  int i, j, m, cont = 0; //ponto no plano de projeção(i,j,0) 
  double A, B, C, Delta;
  double n, cosang, t1; //raízes da equação do segundo grau(t1,t2)
  double x, y, z; //coordenada da intersecao da esfera com a reta
  double modv, modu; //modulo dos vetores v,u
  
  for (i=-300; i<300; i++){
    for (j=-200; j<200; j++){
      img.set(i+300,j+200,color(255,255,255,0));
    }
  }
  
  for (i=-300; i<300; i++){
    for (j=-200; j<200; j++){
      //equacao da esfera: (x - a)^2 + (y - b)^2 + (z - c)^2 = r^2
      //vetor de direcao (i,j,0) - (xc,yc,zc) = (i - xc, j - yc, -zc)
      //equacao da reta que passa por(i,j,0) e por (xc,yc,zc): (x,y,z) = (i,j,0) + t(i-xc, j-yc, -zc)
      //x = i + ti - txc
      //y = j + tj - tyc
      //z = -tzc
      //intersecao da esfera e da reta: (i + ti - txc - a)^2 + (j + tj - tyc - b)^2 + (-tzc - c)^2 = r^2
      //(i + ti - txc - a)*(i + ti - txc - a) = 
      //i(i + ti - txc - a)    = (i*i + i*ti - i*txc - i*a)          = i^2   + ti^2   - itxc    - ia
      //ti(i + ti - txc - a)   = (ti*i + ti*ti - ti*txc - ti*a)      = ti^2  + t^2i^2 - t^2ixc  - tia
      //-txc(i + ti - txc - a) = (-txc*i - txc*ti + txc*txc + txc*a) = -itxc - t^2ixc + t^2xc^2 + txca
      //-a(i + ti - txc - a)   = (-a*i - a*ti + a*txc + a*a)         = -ai   - ati    + atxc    + a^2
      //(i + ti - txc - a)*(i + ti - txc - a)                        =  i^2 + 2ti^2 - 2itxc - 2ia + t^2i^2 - 2t^2ixc - 2tia + t^2xc^2 + 2txca  + a^2
      //
      //(j + tj - tyc - b)*(j + tj - tyc - b) = 
      //j(j + tj - tyc - b)    = (j*j + j*tj - j*tyc - j*b)          = j^2   + tj^2   - jtyc    - jb
      //tj(j + tj - tyc - b)   = (tj*j + tj*tj - tj*tyc - tj*b)      = tj^2  + t^2j^2 - t^2jyc  - tjb
      //-tyc(j + tj - tyc - b) = (-tyc*j - tyc*tj + tyc*tyc + tyc*b) = -jtyc - t^2jyc + t^2yc^2 + tycb
      //-b(j + tj - tyc - b)   = (-b*j - b*tj + b*tyc + b*b)         = -bj   - btj    + btyc    + b^2
      //(j + tj - tyc - b)*(j + tj - tyc - b)                        = j^2 + 2tj^2 - 2jtyc - 2jb + t^2j^2 - 2t^2jyc - 2tjb + t^2yc^2 + 2tycb  + b^2
      //
      //(-tzc - c)^2 = t^2zc^2 + 2ctzc + c^2
      //
      //(i + ti - txc - a)^2 + (j + tj - tyc - b)^2 + (-tzc - c)^2 - r^2 = 
      //i^2 + 2ti^2 - 2itxc - 2ia + t^2i^2 - 2t^2ixc - 2tia + t^2xc^2 + 2txca  + a^2
      //j^2 + 2tj^2 - 2jtyc - 2jb + t^2j^2 - 2t^2jyc - 2tjb + t^2yc^2 + 2tycb  + b^2
      //t^2zc^2 + 2ctzc + c^2 - r^2 = 0
      //t^2(i^2 - 2ixc + xc^2 + j^2 - 2jyc + yc^2 + zc^2) +
      //t(2i^2 - 2ixc - 2ia + 2xca + 2j^2 - 2jyc - 2jb + 2ycb + 2czc) +
      //i^2 - 2ia + a^2 + j^2 - 2bj + b^2 + c^2 - r^2 = 0
      A = (i*i) - 2*(i*xc) + (xc*xc) + (j*j) - 2*(j*yc) + (yc*yc) + (zc*zc);
      B = 2*(i*i) - 2*(i*xc) - 2*(i*a) + 2*(xc*a) + 2*(j*j) - 2*(j*yc) - 2*(j*b) + 2*(yc*b) + 2*(c*zc);
      C = (i*i) - 2*(i*a) + (a*a) + (j*j) - 2*(b*j) + (b*b) + (c*c) - (r*r);
      
      Delta = (B*B)-(4*A*C);
      if (Delta<0.0) { img.set(i+300,j+200,color(255,255,255,0)); }
      else { 
        t1 = (-B + r2(Delta))/(2*A); 
        //t2 = (-B - r2(Delta))/(2*A);
           
        x = i + (t1 * i);
        y = j + (t1 * j);
        z = t1 * zc;
            
        //V = (i,j,0) - (x,y,z) = (i-x,j-y,-z)
        //U = (p,q,w) - (x,y,z) = (p-x,q-y,w-z)
        //cosθ = <v,u>/|v|·|u|
        //<v,u> = (e*m)+(f*n)+(g*o)  , v = (e,f,g), u = (m,n,o) 
        //|v|·|u| = raiz((e*e)+(f*f)+(g*g)) * raiz((m*m)+(n*n)+(o*o))
        modv = r2((i-x)*(i-x) + (j-y)*(j-y) + (-z)*(-z));
        modu = r2((p-x)*(p-x) + (q-y)*(q-y) + (w-z)*(w-z));
        cosang = (((i-x)*(p-x)) + ((j-y)*(q-y)) + (-z*(w-z)))/(modv*modu);
        n = 255*cosang;
        m = (int) n;

        img.set(i+300,j+200,color(0,m,0,255));
      }
   }
  } 
 
  delay(500);
  img.save("g"+str(count)+".png");
  delay(500);
  if(cont>20) noLoop();
}

void setup() {
  size(600,400);
  img = createImage(600,400, ARGB);
  
  double a  =    0.0, b = 100.0, c  =  150.0, r = 100.0; //centro(a,b,c) e raio(r)
  double p  = -300.0, q = 300.0, w  = -150.0;            //luz(p,q,w)
  double f  =    0.0, g = 100.0, h  = -100.0;            //camera(f,g,-h)
  int cont = 0;

  projecao(a,b,c,r,f,g,h,p,q,w,cont); 
  for (a = 200; a >= -200; a -= 7) {
        b = cos((float)(a/10.0))*150;
        f = a; // (a,b,c) coordenadas do centro da esfera; (xc,yc,zc) coordenadas da posicao da camera;
        g = b;

        projecao(a,b,c,r,f,g,h,p,q,w,cont); 
        cont += 1;
  }
  
  exit();
}

double r2( double num ) {
  double aa, bb, cc, dd = 0.0;
  aa = 0.0;      // println(a);
  bb = 2.0*num;  // println(b);
  cc = bb-aa;      // println(c);
  while (cc>0.0001){
      dd = (aa+bb)/2.0; // println(d);
      if ((dd*dd)<=num) { aa = dd; } // println(a);
      else              { bb = dd; } //println(b);
      cc = bb-aa;
  }//end-while
 
  return(dd);
} 
