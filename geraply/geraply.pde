PrintWriter output;

void setup() {
  
  int i, j;
  double A, B, C, Delta;
  double a = 0.0, b = 0.0, c = 150.0, r = 100.0; //centro(a,b,c) e raio(r)
  double x = 0.0, y = 0.0, z = -30.0;       //camera(x,y,z)
  String header = "ply\n";
  header += "format ascii 1.0\n";
  header += "comment\n"; 
  header += "element vertex 240000\n";            
  header += "property float x\n";            
  header += "property float y\n";           
  header += "property float z\n";  
  header += "property uchar red\n";                    
  header += "property uchar green\n"; 
  header += "property uchar blue\n";   
  header += "end_header";
  output = createWriter("esfera.ply"); 
  output.println(header);
  
  for (i=-300; i<300; i++){
    for (j=-200; j<200; j++){
      A = (i*i) - 2*(i*x) + (x*x) + (j*j) - 2*(j*y) + (y*y) + (z*z);
      B = 2*(i*i) - 2*(i*x) - 2*(i*a) + 2*(x*a) + 2*(j*j) - 2*(j*y) - 2*(j*b) + 2*(y*b) + 2*(c*z);
      C = (i*i) - 2*(i*a) + (a*a) + (j*j) - 2*(b*j) + (b*b) + (c*c) - (r*r);
      
      Delta = (B*B)-(4*A*C);
      if (Delta<0.0) { output.println(i+"\t"+j+"\t0\t255\t255\t255"); }
      else           { output.println(i+"\t"+j+"\t0\t0\t0\t0"); } 
   }
  }
  output.flush(); 
  output.close();
  exit();
}
