PImage img;
PrintWriter output;

void setup() {
  double a =  300.0, b = 200.0, c = 150.0, r = 50.0; //centro(a,b,c) e raio(r)
  double p =  80.0, q = 60.0, w =   0.0;           //luz(p,q,w)
  int i, j;
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
  output = createWriter("Mickey.ply"); 
  output.println(header);
  
  size(32,32);
  img = createImage(600, 400, RGB);
  
  for (i = 0; i < 600; i++) {
    for (j = 0; j < 400; j++) {
      img.set(i, j, color(255,255,255)); 
    }
  }
  
  projecaoParalela(78,46,50,38,p,q,w,"red");
  projecaoParalela(42,46,95,23,p,q,w,"blue");
  projecaoParalela(115,46,95,23,p,q,w,"green");
  projecaoParalelaElipsoide(78,79,23,18,25,16,p,q,w,"yellow");
  projecaoParalelaElipsoide(78,108,26,10,12,9,p,q,w,"cyan");
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
  img.save("Mickey.png");
  
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
        
        if      (cor == "green") { img.set(i, j, color(0, m, 0));    output.println(i+"\t"+j+"\t0\t0\t255\t0"); }
        else if (cor == "blue")  { img.set(i, j, color(0, 0, m));    output.println(i+"\t"+j+"\t0\t0\t0\t255"); }
        else if (cor == "red")  { img.set(i, j, color(m, 0, 0));     output.println(i+"\t"+j+"\t0\t255\t0\t0"); }
        else if (cor == "cyan")  { img.set(i, j, color(0, m, m));    output.println(i+"\t"+j+"\t0\t0\t255\t255"); }
        else if (cor == "yellow")  { img.set(i, j, color(m, m, 0));  output.println(i+"\t"+j+"\t0\t255\t255\t0");}
        else if (cor == "black")  { img.set(i, j, color(0, 0, 0));   output.println(i+"\t"+j+"\t0\t0\t0\t0"); }
        else if (cor == "white")  { img.set(i, j, color(m, m, m));   output.println(i+"\t"+j+"\t0\t255\t255\t255");}

      }
      
    }
  }
}

void projecaoParalelaElipsoide(double a, double b, double c, double f, double g, double h, double p, double q, double w, String cor) {
  int i, j, m;
  double delta, t;
  double x, y, z; //coordenada da intersecao da esfera com o elipsoide
  double modu; //modulo dos vetores v,u
  double n, cosang; 

  for (i = 0; i < 600; i++) {
    for (j = 0; j < 400; j++) {
      //esfera com centro(a,b,c) e eixos f,g,h
      //((x-a)^2)/f^2 + ((y-b)^2)/g^2 + ((z-c)^2)/h^2 = 1
      //reta que passa por (i,j,0) com vetor(0,0,1)
      //Lij: (x,y,z) = (i,j,0) + t(0,0,1)
      //x = i 
      //y = j
      //z = t
      //((i-a)^2)/f^2 + ((j-b)^2)/g^2 + ((t-c)^2)/h^2 = 1
      //((t-c)^2)/h^2 = 1 - ((i-a)^2)/f^2 - ((j-b)^2)/g^2
      //(t-c)^2 = h^2 * (1 - ((i-a)^2)/f^2 - ((j-b)^2)/g^2)
      //t-c = +- h * (raiz(1 - ((i-a)^2)/f^2 - ((j-b)^2)/g^2))
      //t = c +- h * (raiz(1 - ((i-a)^2)/f^2 - ((j-b)^2)/g^2))
      delta = (1 - (((i-a)*(i-a))/(f*f)) - (((j-b)*(j-b))/(g*g)));
      if (delta >= 0) {
        t = raiz(delta) + c + h;
        
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
        else if (cor == "black")  { img.set(i, j, color(0, 0, 0));  }
        else if (cor == "white")  { img.set(i, j, color(m, m, m));  }

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
