PImage img1; //<>//
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;

void setup() {
  size(600,400);
  img1 = createImage(600,400, ARGB);
  img2 = createImage(600,400, ARGB);
  img3 = createImage(600,400, ARGB);
  img4 = createImage(600,400, ARGB);
  img5 = createImage(600,400, ARGB);
  img6 = createImage(600,400, ARGB);
  int i, j; //ponto no plano de projeção(i,j,0) 
  color c1, c2, c3, c4, c5;
  
  img1 = loadImage("y33.png");
  img2 = loadImage("b33.png");
  img3 = loadImage("c33.png");
  img4 = loadImage("g33.png");
  img5 = loadImage("r33.png");
  
  for (i=0; i<600; i++){
    for (j=0; j<400; j++){
    c1 = img1.get(i,j);
    if (alpha(c1) == 255) { img6.set(i,j,c1);}
    else { img6.set(i,j,color(255,255,255,0));}
    }
  }
  
  for (i=0; i<600; i++){
    for (j=0; j<400; j++){
    c2 = img2.get(i,j);      
    if (alpha(c2) == 255) { img6.set(i,j,c2);}
    }
  }
  
  for (i=0; i<600; i++){
    for (j=0; j<400; j++){
    c3 = img3.get(i,j);      
    if (alpha(c3) == 255) { img6.set(i,j,c3);}
    }
  }
  
  for (i=0; i<600; i++){
    for (j=0; j<400; j++){
    c4 = img4.get(i,j);      
    if (alpha(c4) == 255) { img6.set(i,j,c4);}
    }
  }
  
  for (i=0; i<600; i++){
    for (j=0; j<400; j++){
    c5 = img5.get(i,j);      
    if (alpha(c5) == 255) { img6.set(i,j,c5);}
    }
  }
  
  img6.save("pilha33.png");
  exit();
}
