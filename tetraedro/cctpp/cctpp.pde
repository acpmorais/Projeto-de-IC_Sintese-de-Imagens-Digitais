PrintWriter output;

void setup() {
  size(32,32);
  background(255,255,255);

  float[] p1 = {+300.0, +200.0, +150.0};
  float[] p2 = {+300.0, -200.0, -150.0};
  float[] p3 = {-300.0, +200.0, -150.0};
  float[] p4 = {-300.0, -200.0, +150.0};
 
  String header = "ply\n";
  header += "format ascii 1.0\n";
  header += "comment\n"; 
  header += "element vertex 41616\n";            
  header += "property float x\n";            
  header += "property float y\n";           
  header += "property float z\n";  
  header += "property uchar red\n";                    
  header += "property uchar green\n"; 
  header += "property uchar blue\n"; 
  header += "element face 0\n";
  header += "property list uchar int vertex_index\n";    
  header += "end_header";
  output = createWriter("combination.ply"); 
  output.println(header);
  
  // Escreve os vertices do tetraedro no PLY
  output.println(p1[0] + "\t" + p1[1] + "\t" + p1[2] + "\t255\t0\t0");
  output.println(p2[0] + "\t" + p2[1] + "\t" + p2[2] + "\t255\t0\t0");
  output.println(p3[0] + "\t" + p3[1] + "\t" + p3[2] + "\t255\t0\t0");
  output.println(p4[0] + "\t" + p4[1] + "\t" + p4[2] + "\t255\t0\t0");
  
  projecao(p1,p2,p3);
  projecao(p1,p2,p4);
  projecao(p2,p3,p4);
  projecao(p3,p1,p4);
  
  output.println("3 0 1 3"); // Face with vertices p1, p2, and p4
  output.println("3 0 2 3"); // Face with vertices p1, p3, and p4
  output.println("3 1 2 3"); // Face with vertices p2, p3, and p4
  output.println("3 0 1 2"); // Face with vertices p1, p2, and p3
  
  output.flush(); 
  output.close();
  exit();
}

void projecao(float p1[], float p2[], float p3[]){
  float alpha = 0.1, beta = 0.2, gamma = 0.3;
  float [] r = new float[3];
  float [] s = new float[3];
  float [] u = new float[3];
  
  beta = 1.0;
  for (alpha = 0.0; alpha < 1.0; alpha += 0.01){
    beta = 1.0 - alpha;
    
    r[0] = (alpha*p1[0]) + (beta*p2[0]);
    r[1] = (alpha*p1[1]) + (beta*p2[1]);
    r[2] = (alpha*p1[2]) + (beta*p2[2]);
    
    s[0] = (alpha*p1[0]) + (beta*p3[0]);
    s[1] = (alpha*p1[1]) + (beta*p3[1]);
    s[2] = (alpha*p1[2]) + (beta*p3[2]);
    
    for (gamma = 0.0; gamma < 1.0; gamma += 0.01){
      u[0] = (gamma*r[0]) + ((1.0-gamma)*s[0]);
      u[1] = (gamma*r[1]) + ((1.0-gamma)*s[1]);
      u[2] = (gamma*r[2]) + ((1.0-gamma)*s[2]);
    
      output.println(u[0] + "\t" + u[1] + "\t" + u[2]+ "\t"+((int)(alpha*255))+"\t"+((int)(beta*255))+"\t"+((int)(gamma*255)));
    }
  
    output.println(r[0] + "\t" + r[1] + "\t" + r[2] + "\t255\t0\t0");
    output.println(s[0] + "\t" + s[1] + "\t" + s[2] + "\t0\t0\t255");
    
    
  }
}
