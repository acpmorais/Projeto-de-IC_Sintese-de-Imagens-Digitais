PImage img;

void setup() {
  double a =  300.0, b = 200.0, c = 150.0, r = 50.0; //centro(a,b,c) e raio(r)
  double p =    0.0, q = 200.0, w =   0.0;           //luz(p,q,w)
  int cont = 0, i, j;
  
  size(32,32);
  img = createImage(600, 400, RGB);
  
  for (a = 100; a <=600; a += 10) {
    for (i = 0; i < 600; i++) { for (j = 0; j < 400; j++) { img.set(i, j, color(255,255,255)); }}
    b = (((a-450)*(a-450))/450); 
    projecaoParalela(a,b,c,r,p,q,w,"green"); 
    
    b = 200.0 + (200*cos((int)a));
    projecaoParalela(a+50.0,b,c,r,p,q,w,"blue");

    b = 250.0 + (200*sin((int)a)); 
    projecaoParalela(a+50.0,b,c,r,p,q,w,"red"); 
    
    b = (((-a-450)*(a-450))/450); 
    projecaoParalela(a+50.0,b,c,r,p,q,w,"yellow");
    
    b = (a/2.0) + (500*exp(-(float)(a/100.0))); 
    projecaoParalela((600.0-a),b,c,r,p,q,w,"cyan");
    
    cont += 1; 
    
    if (cont<10) {
      img.updatePixels();
      img.save("esfera00"+str(cont)+".png");
      //img2.save("esfera11"+str(cont)+".png");
    }
    else if (cont<100) {
      img.updatePixels();
      img.save("esfera0"+str(cont)+".png");
      //img2.save("esfera1"+str(cont)+".png");
    }
    else {
      img.updatePixels();
      img.save("esfera"+str(cont)+".png");
      //img2.save("esferabb"+str(cont)+".png");
    }
  }
  
  exit();
}

void projecaoParalela(double a, double b, double c, double r, double p, double q, double w, String cor) {
  int i, j, m;
  double delta, t;
  double x, y, z; //coordenada da intersecao da esfera com a reta
  double modu; //modulo dos vetores v,u
  double n, cosang; //raízes da equação do segundo grau(t1,t2)

  for (i = 0; i < 600; i++) {
    for (j = 0; j < 400; j++) {
      //esfera com centro(a,b,c) e raio r
      //(x-a)^2 + (y-b)^2 + (z-c)^2 = r^2
      //reta que passa por (i,j,0) com vetor(0,0,1)
      //Lij: (x,y,z) = (i,j,0) + t(0,0,1)
      //x = i 
      //y = j
      //z = t
      //(i-a)^2 + (j-b)^2 + (t-c)^2 = r^2
      //(t-c)^2 = r^2 - ((i-a)^2 + (j-b)^2)
      //t-c = raiz(r^2 - ((i-a)^2 + (j-b)^2))
      delta = (r*r) - (((i-a)*(i-a)) + ((j-b)*(j-b)));
      if (delta >= 0) {
        t = raiz(delta) + c;
        
        x = i;
        y = j;
        z = t;
            
        //V = (0,0,1)
        //U = (x,y,z) - (p,q,w) = (x-p,y-q,z-w)
        //cosθ = <v,u>/|v|·|u|
        //<v,u> = (e*m)+(f*n)+(g*o) = o  , v = (0,0,1), u = (m,n,o) 
        //|v|·|u| = raiz((m*m)+(n*n)+(o*o))
        //modv = 1.0;
        modu = raiz(((x-p)*(x-p)) + ((y-q)*(y-q)) + ((z-w)*(z-w)));
        cosang = (z-w)/modu;
        n = 255*cosang;
        m = (int) n;
        
        if      (cor == "green") { img.set(i, j, color(0, m, 0));  }
        else if (cor == "blue")  { img.set(i, j, color(0, 0, m));  }
        else if (cor == "red")  { img.set(i, j, color(m, 0, 0));  }
        else if (cor == "cyan")  { img.set(i, j, color(0, m, m));  }
        else if (cor == "yellow")  { img.set(i, j, color(m, m, 0));  }

      }
      
    }
  }
}

double raiz( double num ) {
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
