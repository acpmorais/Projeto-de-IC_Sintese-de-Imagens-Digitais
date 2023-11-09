PImage img;
PrintWriter output;

void setup() {
  double a =  300.0, b = 200.0, c = 150.0, r = 50.0; //centro(a,b,c) e raio(r)
  //double p =  300.0, q = 200.0, w =   0.0;           //luz(p,q,w)
  double p =  80.0, q =  80.0, w =   0.0;           //luz(p,q,w)
  String header = "ply\n";
  header += "format ascii 1.0\n";
  header += "comment\n"; 
  header += "element vertex 8175\n";            
  header += "property float x\n";            
  header += "property float y\n";           
  header += "property float z\n";  
  header += "property uchar red\n";                    
  header += "property uchar green\n"; 
  header += "property uchar blue\n"; 
  header += "element face 0\n";
  header += "property list uchar int vertex_index\n";    
  header += "end_header";
  output = createWriter("MickeyYZ.ply"); 
  output.println(header);
  
  size(32,32);
  img = createImage(600, 400, RGB);
  
  for (int i = 0; i < 600; i++) { for (int j = 0; j < 400; j++) { img.set(i, j, color(255, 255, 255)); } }
  
  projecaoParalela(78,46,50,38,p,q,w,"red");
  projecaoParalela(42,46,95,23,p,q,w,"blue");
  projecaoParalela(115,46,95,23,p,q,w,"green");
  projecaoParalelaElipsoideYZ(78,79,23,18,25,16,p,q,w,"yellow");
  projecaoParalelaElipsoideYZ(78,108,26,10,12,9,p,q,w,"cyan");
  projecaoParalela(63,77,48,7,p,q,w,"white");
  projecaoParalela(93,77,48,7,p,q,w,"white");
  projecaoParalela(63,77,45,3,p,q,w,"black");
  projecaoParalela(93,77,45,3,p,q,w,"black");
  //eq10 - projecaoParalela(66,70,50,22,p,q,w,"white");
  //eq11 - projecaoParalela(90,70,50,22,p,q,w,"white");
  //eq12 - projecaoParalela(96,77,55,7,p,q,w,"white");
  //eq13 - projecaoParalela(60,77,55,7,p,q,w,"white");

  output.flush(); 
  output.close();
  img.save("MickeyZX.png");
  
  exit();
}

void projecaoParalela(double a, double b, double c, double r, double p, double q, double w, String cor) {
  int i, j, k, m;
  double delta, t;
  double x, y, z; //coordenada da intersecao da esfera com a reta
  double modu; //modulo dos vetores v,u
  double n, cosang; //raízes da equação do segundo grau(t1,t2)

  for (j = 0; j < 600; j++) {
    for (k = 0; k < 400; k++) {
      //esfera com centro(a,b,c) e raio r
      //(x-a)^2 + (y-b)^2 + (z-c)^2 = r^2
      //reta que passa por (i,j,0) com vetor(0,0,1)
      //Lij: (x,y,z) = (i,j,0) + t(0,0,1)
      //reta que passa por (i,j,0) com vetor(0,1,0)
      //Lik: (x,y,z) = (i,0,k) + t(0,1,0)
      //reta que passa por (i,j,0) com vetor(1,0,0)
      //Ljk: (x,y,z) = (0,j,k) + t(1,0,0)
      //x = t
      //y = j
      //z = k
      //(t-a)^2 + (j-b)^2 + (k-c)^2 = r^2
      //(t-a)^2  = r^2 - ( (j-b)^2 + (k-c)^2 )
      //(t-a)    = raiz( r^2 - ( (j-b)^2 + (k-c)^2 ) )
      // t       = a + raiz( r^2 - ( (j-b)^2 + (k-c)^2 ) )
      delta = (r*r) - (((j-b)*(j-b)) + ((k-c)*(k-c)));
      if (delta >= 0) {
        t = raiz(delta) + b;
        
        x = t;
        y = j;
        z = k;
            
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
        
        if      (cor == "black" ) { img.set(j, k, color(0, 0, 0));  output.println(j+"\t"+k+"\t0\t0\t0\t0"); }
        else if (cor == "blue"  ) { img.set(j, k, color(0, 0, m));  output.println(j+"\t"+k+"\t0\t0\t0\t255"); }
        else if (cor == "green" ) { img.set(j, k, color(0, m, 0));  output.println(j+"\t"+k+"\t0\t0\t255\t0"); }
        else if (cor == "cyan"  ) { img.set(j, k, color(0, m, m));  output.println(j+"\t"+k+"\t0\t0\t255\t255"); }
        else if (cor == "red"   ) { img.set(j, k, color(m, 0, 0));  output.println(j+"\t"+k+"\t0\t255\t0\t0"); }
        else if (cor == "mag"   ) { img.set(j, k, color(m, 0, m));  output.println(j+"\t"+k+"\t0\t255\t0\t255"); }
        else if (cor == "yellow") { img.set(j, k, color(m, m, 0));  output.println(j+"\t"+k+"\t0\t255\t255\t0");}
        else if (cor == "white" ) { img.set(j, k, color(m, m, m));  output.println(j+"\t"+k+"\t0\t255\t255\t255");}

      }
      
    }
  }
}

void projecaoParalelaElipsoideYZ(double a, double b, double c, double f, double g, double h, double p, double q, double w, String cor) {
  int i, j, k, m;
  double delta, t;
  double x, y, z; //coordenada da intersecao da esfera com o elipsoide
  double modu; //modulo dos vetores v,u
  double n, cosang; 

  for (j = 0; j < 600; j++) {
    for (k = 0; k < 400; k++) {
      //esfera com centro(a,b,c) e eixos f,g,h
      //((x-a)^2)/f^2 + ((y-b)^2)/g^2 + ((z-c)^2)/h^2 = 1
      //reta que passa por (i,j,0) com vetor(0,0,1)
      //Lij: (x,y,z) = (i,j,0) + t(0,0,1)
      //reta que passa por (i,0,k) com vetor(0,1,0)
      //Lij: (x,y,z) = (i,0,k) + t(0,1,0)
      //reta que passa por (i,j,0) com vetor(1,0,0)
      //Ljk: (x,y,z) = (0,j,k) + t(1,0,0)
      //x = t 
      //y = j
      //z = k
      //((t-a)^2)/f^2 + ((j-b)^2)/g^2 + ((k-c)^2)/h^2 = 1
      // ((t-a)^2)/f^2 +  = 1 - ((j-b)^2)/g^2 + ((k-c)^2)/h^2 )
      // ((t-a)^2)/f^2 +  = (1 - ((j-b)^2)/g^2 + ((k-c)^2)/h^2 ) )
      // ((t-a)^2) +  = f^2*(1 - ((j-b)^2)/g^2 + ((k-c)^2)/h^2 ) )
      // t-a         = f*raiz(1 - ((j-b)^2)/g^2 + ((k-c)^2)/h^2 ) )
      // t = a + f*raiz(1 - ((j-b)^2)/g^2 + ((k-c)^2)/h^2 ) )
      
      delta = (1 - (((j-b)*(j-b))/(g*g)) - (((k-c)*(k-c))/(h*h)));
      if (delta >= 0) {
        t = (g*raiz(delta)) + b;
        
        x = t;
        y = j;
        z = k;
            
        //V = (0,0,1)
        //U = (x,y,z) - (p,q,w) = (x-p,y-q,z-w)
        //cosθ = <v,u>/|v|·|u|
        //<v,u> = (e*m)+(f*n)+(g*o) = n  , v = (0,1,0), u = (m,n,o) 
        //|v|·|u| = raiz((m*m)+(n*n)+(o*o))
        //modv = 1.0;
        modu = raiz(((x-p)*(x-p)) + ((y-q)*(y-q)) + ((z-w)*(z-w)));
        cosang = (y-q)/modu;
        n = 255*cosang;
        m = (int) n;
        
        if      (cor == "black")  { img.set(j, k, color(0, 0, 0));  } // BLACK: 000 : 0
        else if (cor == "blue" )  { img.set(j, k, color(0, 0, m));  } // BLUE:: 001 : 1
        else if (cor == "green")  { img.set(j, k, color(0, m, 0));  } // GREEN: 010 : 2
        else if (cor == "cyan" )  { img.set(j, k, color(0, m, m));  } // CYAN:: 011 : 3
        else if (cor == "red"  )  { img.set(j, k, color(m, 0, 0));  } // RED::: 100 : 4
        else if (cor == "mag"  )  { img.set(j, k, color(m, 0, 1));  } // MAGEN: 101 : 5
        else if (cor == "yellow") { img.set(j, k, color(m, m, 0));  } // YELLO: 110 : 6
        else if (cor == "white")  { img.set(j, k, color(m, m, m));  } // WHITE: 111 : 7

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
