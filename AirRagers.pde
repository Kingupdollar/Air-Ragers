DOT[] dots;

float rectX, rectY;      // Position of square button
float circleX, circleY;  // Position of circle button
float circle2X, circle2Y;
float rectSize = 68;     // Diameter of rect
float circleSize = 90;   // Diameter of circle
float circle2Size = 110; 
color rectColor, circleColor;
color rectHighlight, circleHighlight;
boolean rectOver = false;
boolean circleOver = false;
boolean circle2Over = false;
boolean rectOver1 = false;
boolean circleOver1 = false;
boolean circle2Over1 = false;

float m=180;
float n=m/135;

void setup(){
  rectColor = color(100);
  rectHighlight = color(200);
  circleColor = color(100);
  circleHighlight = color(250);
  circleX = width-270;
  circleY = 70+0.5*rectSize;
  rectX = width-380;
  rectY = 70;
  circle2X = circleX+150;
  circle2Y = circleY;
  ellipseMode(CENTER);
  
  size(displayWidth,displayHeight);
  background(0);
  frameRate(30);
  
  dots=new DOT[273];
  Table table = loadTable("data.csv", "header");
  int index=0;
  for(int k=0; k<table.getRowCount(); k++){
    TableRow row = table.getRow(k);
    float mm=row.getInt("ddelay");
    float mn=row.getInt("std");
    float nn=row.getInt("atd");
    float oo=row.getInt("ata");
    String pp=row.getString("code");
    int qq=row.getInt("ddelay");
    dots[index++]=new DOT(mm,mn,nn,oo,pp,qq);
  }
}


void draw(){
  update(mouseX, mouseY);
  
  if(circleOver1){
    fill(0);
    rect(-5,-5,displayWidth+5, displayHeight+5);
    for(DOT mod : dots){
      if(frameCount<=1440*7){
        mod.update();
      }
    }
  }
  if(rectOver1){
    fill(0);
  }
  if(circle2Over1){
    fill(0);
    rect(-5,-5,displayWidth+5, displayHeight+5);
    
    //buttons
    float buttonXa=width-110;
    float buttonXai=55;
    float buttonYa=height-120;
    float buttonR=20;
    float buttonXb=width-280;
    float buttonXbi=64.5;
    float buttonYb=height-125;
    float buttonR2=24;
    
    noStroke();
    for(int i=0;i<7;i++){
      fill(180,100);
      ellipse(buttonXa,buttonYa-buttonXai*i,buttonR*2,buttonR*2);
      if(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*i)<=buttonR){
        fill(255,50);
        ellipse(buttonXa,buttonYa-buttonXai*i,buttonR*2*1.3,buttonR*2*1.3);
      }
    }
    for(int i=0;i<6;i++){
      fill(140,100);
      ellipse(buttonXb,buttonYb-buttonXbi*i,buttonR2*2,buttonR2*2);
      if(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*i)<=buttonR2){
        fill(255,50);
        ellipse(buttonXb,buttonYb-buttonXbi*i,buttonR2*2*1.3,buttonR2*2*1.3);
      }
    }
    
    fill(255,100);
    String IATA[]={"MU","CA","HU","FM","HO","CZ"};
    String air[]={"China","Air","Hainan","Shanghai","Juneyao","China"};
    String air2[]={"Eastern","China","Airlines","Airlines","Airlines","Southern"};
    for(int i=0;i<IATA.length;i++){
      PFont f2=createFont("Arial Bold",22);
      textFont(f2);
      textAlign(CENTER,CENTER);
      text(IATA[i],buttonXb,buttonYb-buttonXbi*i-3);
      
      if(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*i)<=buttonR2){
        PFont f3=createFont("Arial",16);
        textFont(f3);
        textAlign(LEFT,CENTER);
        text(air[i],buttonXb+37,buttonYb-buttonXbi*i-10);
        text(air2[i],buttonXb+37,buttonYb-buttonXbi*i+8);
      }
    }
      
    String date[]={"3/31","3/30","3/29","3/28","3/27","3/26","3/25"};
    for(int i=0;i<date.length;i++){
      PFont f2=createFont("Arial",16);
      textFont(f2);
      textAlign(CENTER,CENTER);
      text(date[i],buttonXa,buttonYa-buttonXai*i-3);
      
      if(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*i)<=buttonR){
        PFont f3=createFont("Arial",11);
        textFont(f3);
        textAlign(RIGHT,CENTER);
        text("2019/",buttonXa-53,buttonYa-buttonXai*i-16);
        text(date[i],buttonXa-33,buttonYa-buttonXai*i-16);
        text("on-time",buttonXa-33,buttonYa-buttonXai*i-3);
        text("performance",buttonXa-33,buttonYa-buttonXai*i+10);
      }
    }
    PFont f11=createFont("Arial",15);
    textFont(f11);
    textAlign(CENTER,CENTER);
    text("by airline",buttonXb,buttonYb-380);
    text("by date",buttonXa,buttonYb-380);
    
    
    Table table2 = loadTable("data_airline.csv", "header");
    for(int i=0; i<table2.getRowCount(); i++){
      TableRow row = table2.getRow(i);
      strokeWeight(4);
      float d=row.getInt("MU_D_delay");
      float t=row.getInt("MU_ATD");
      float a=row.getInt("MU_ATA");
      for(int j=0; j<d; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)){
          point(width/2+(n*j)*cos(map(t-d+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t-d+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      for(int j=0; j<(a-t); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)){
          point(width/2+(d*n+n*j)*cos(map(t+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d*n+n*j)*sin(map(t+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      float d2=row.getInt("CA_D_delay");
      float t2=row.getInt("CA_ATD");
      float a2=row.getInt("CA_ATA");
      for(int j=0; j<d2; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)){
          point(width/2+(n*j)*cos(map(t2-d2+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t2-d2+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      for(int j=0; j<(a2-t2); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)){
          point(width/2+(d2*n+n*j)*cos(map(t2+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d2*n+n*j)*sin(map(t2+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      float d3=row.getInt("HU_D_delay");
      float t3=row.getInt("HU_ATD");
      float a3=row.getInt("HU_ATA");
      for(int j=0; j<d3; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)){
          point(width/2+(n*j)*cos(map(t3-d3+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t3-d3+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      for(int j=0; j<(a3-t3); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)){
          point(width/2+(d3*n+n*j)*cos(map(t3+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d3*n+n*j)*sin(map(t3+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      float d4=row.getInt("FM_D_delay");
      float t4=row.getInt("FM_ATD");
      float a4=row.getInt("FM_ATA");
      for(int j=0; j<d4; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)){
          point(width/2+(n*j)*cos(map(t4-d4+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t4-d4+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      for(int j=0; j<(a4-t4); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)){
          point(width/2+(d4*n+n*j)*cos(map(t4+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d4*n+n*j)*sin(map(t4+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      float d5=row.getInt("HO_D_delay");
      float t5=row.getInt("HO_ATD");
      float a5=row.getInt("HO_ATA");
      for(int j=0; j<d5; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)){
          point(width/2+(n*j)*cos(map(t5-d5+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t5-d5+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      for(int j=0; j<(a5-t5); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)){
          point(width/2+(d5*n+n*j)*cos(map(t5+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d5*n+n*j)*sin(map(t5+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      float d6=row.getInt("CZ_D_delay");
      float t6=row.getInt("CZ_ATD");
      float a6=row.getInt("CZ_ATA");
      for(int j=0; j<d6; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)){
          point(width/2+(n*j)*cos(map(t6-d6+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t6-d6+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
      for(int j=0; j<(a6-t6); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)){
          point(width/2+(d6*n+n*j)*cos(map(t6+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d6*n+n*j)*sin(map(t6+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        }
      }
    }  
      
    Table table = loadTable("flights_data_csv.csv", "header");
    for(int i=0; i<table.getRowCount(); i++){
      TableRow row = table.getRow(i);
      strokeWeight(4);
      float d=row.getInt("0331_D_delay");
      float t=row.getInt("0331_ATD");
      float a=row.getInt("0331_ATA");
      for(int j=0; j<d; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(n*j)*cos(map(t-d+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t-d+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      for(int j=0; j<(a-t); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(d*n+n*j)*cos(map(t+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d*n+n*j)*sin(map(t+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      float d2=row.getInt("0330_D_delay");
      float t2=row.getInt("0330_ATD");
      float a2=row.getInt("0330_ATA");
      for(int j=0; j<d2; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(n*j)*cos(map(t2-d2+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t2-d2+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      for(int j=0; j<(a2-t2); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(d2*n+n*j)*cos(map(t2+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d2*n+n*j)*sin(map(t2+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      float d3=row.getInt("0329_D_delay");
      float t3=row.getInt("0329_ATD");
      float a3=row.getInt("0329_ATA");
      for(int j=0; j<d3; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(n*j)*cos(map(t3-d3+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t3-d3+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      for(int j=0; j<(a3-t3); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(d3*n+n*j)*cos(map(t3+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d3*n+n*j)*sin(map(t3+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      float d4=row.getInt("0328_D_delay");
      float t4=row.getInt("0328_ATD");
      float a4=row.getInt("0328_ATA");
      for(int j=0; j<d4; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(n*j)*cos(map(t4-d4+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t4-d4+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      for(int j=0; j<(a4-t4); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(d4*n+n*j)*cos(map(t4+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d4*n+n*j)*sin(map(t4+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      float d5=row.getInt("0327_D_delay");
      float t5=row.getInt("0327_ATD");
      float a5=row.getInt("0327_ATA");
      for(int j=0; j<d5; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(n*j)*cos(map(t5-d5+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t5-d5+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      for(int j=0; j<(a5-t5); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(d5*n+n*j)*cos(map(t5+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d5*n+n*j)*sin(map(t5+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      float d6=row.getInt("0326_D_delay");
      float t6=row.getInt("0326_ATD");
      float a6=row.getInt("0326_ATA");
      for(int j=0; j<d6; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(n*j)*cos(map(t6-d6+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t6-d6+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      for(int j=0; j<(a6-t6); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*1)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(d6*n+n*j)*cos(map(t6+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d6*n+n*j)*sin(map(t6+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      float d7=row.getInt("0325_D_delay");
      float t7=row.getInt("0325_ATD");
      float a7=row.getInt("0325_ATA");
      for(int j=0; j<d7; j++){
        stroke(255,100,0,50);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(n*j)*cos(map(t7-d7+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(n*j)*sin(map(t7-d7+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
      for(int j=0; j<(a7-t7); j++){
        stroke(255,30);
        if((dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*1)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*2)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*3)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*4)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*5)<=buttonR2)||(dist(mouseX,mouseY,buttonXb,buttonYb-buttonXbi*0)<=buttonR2)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*0)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*2)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*3)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*4)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*5)<=buttonR)||(dist(mouseX,mouseY,buttonXa,buttonYa-buttonXai*6)<=buttonR)){
          stroke(0,0);
        }
        point(width/2+(d7*n+n*j)*cos(map(t7+j,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+(d7*n+n*j)*sin(map(t7+j,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
    }
  }
  
  

  stroke(255,0);
  fill(0,0);
  rect(rectX, rectY, rectSize, rectSize);
  if (rectOver) {
    fill(rectHighlight);
  } 
  else {
    fill(rectColor);
  }
  if(rectOver1){
    fill(170);
  }
  noStroke();
  rect(rectX+rectSize*0.25, rectY+rectSize*0.2, rectSize*0.2, rectSize*0.6);
  rect(rectX+rectSize*0.55, rectY+rectSize*0.2, rectSize*0.2, rectSize*0.6);
  
  stroke(255,0);
  fill(0,0);
  ellipse(circleX, circleY, circleSize, circleSize);
  if (circleOver) {
    fill(200,100,0);
  } 
  else {
    fill(circleColor);
  }
  if(circleOver1){
    fill(circleHighlight);
  }
  noStroke();
  triangle(circleX+circleSize*0.3*cos(0.7*PI), circleY+circleSize*0.3*sin(0.7*PI), circleX+circleSize*0.3*cos(1.3*PI), circleY+circleSize*0.3*sin(1.3*PI), circleX+circleSize*0.3*cos(0*PI), circleY+circleSize*0.3*sin(0*PI));
  
  if (circle2Over) {
    fill(200,100,0);
  } 
  else {
    fill(50);
  }
  if(circle2Over1){
    fill(180,80,0);
  }
  noStroke();
  ellipse(circle2X, circle2Y, circle2Size, circle2Size);
  fill(255);
  PFont f9=createFont("Arial",20);
  textFont(f9);
  textAlign(CENTER,CENTER);
  text("Graphic",circle2X,circle2Y-15);
  text("Outcome",circle2X,circle2Y+7);
  
  
  
  
  
  
  
  
  stroke(255,100);
  strokeWeight(1);
  fill(255,0);
  ellipse(width/2,height/2,m*2,m*2);
  //time
  fill(0,100);
  PFont f1=createFont("Arial",12);
  textFont(f1);
  textAlign(CENTER,BOTTOM);
  text("00:00",width/2+(m+3)*cos(-PI/2),height/2+(m+3)*sin(-PI/2));
  textAlign(CENTER,TOP);
  text("12:00",width/2+(m+3)*cos(PI/2),height/2+(m+3)*sin(PI/2));
  textAlign(LEFT,BOTTOM);
  text("01:00",width/2+(m+3)*cos(-PI*75/180),height/2+(m+3)*sin(-PI*75/180));
  text("02:00",width/2+(m+3)*cos(-PI*60/180),height/2+(m+3)*sin(-PI*60/180));
  text("03:00",width/2+(m+3)*cos(-PI*45/180),height/2+(m+3)*sin(-PI*45/180));
  text("04:00",width/2+(m+3)*cos(-PI*30/180),height/2+(m+3)*sin(-PI*30/180));
  text("05:00",width/2+(m+3)*cos(-PI*15/180),height/2+(m+3)*sin(-PI*15/180));
  textAlign(LEFT,CENTER);
  text("06:00",width/2+(m+3),height/2);
  textAlign(LEFT,TOP);
  text("11:00",width/2+(m+3)*cos(PI*75/180),height/2+(m+3)*sin(PI*75/180));
  text("10:00",width/2+(m+3)*cos(PI*60/180),height/2+(m+3)*sin(PI*60/180));
  text("09:00",width/2+(m+3)*cos(PI*45/180),height/2+(m+3)*sin(PI*45/180));
  text("08:00",width/2+(m+3)*cos(PI*30/180),height/2+(m+3)*sin(PI*30/180));
  text("07:00",width/2+(m+3)*cos(PI*15/180),height/2+(m+3)*sin(PI*15/180));
  textAlign(RIGHT,BOTTOM);
  text("23:00",width/2-(m+3)*cos(-PI*75/180),height/2+(m+3)*sin(-PI*75/180));
  text("22:00",width/2-(m+3)*cos(-PI*60/180),height/2+(m+3)*sin(-PI*60/180));
  text("21:00",width/2-(m+3)*cos(-PI*45/180),height/2+(m+3)*sin(-PI*45/180));
  text("20:00",width/2-(m+3)*cos(-PI*30/180),height/2+(m+3)*sin(-PI*30/180));
  text("19:00",width/2-(m+3)*cos(-PI*15/180),height/2+(m+3)*sin(-PI*15/180));
  textAlign(RIGHT,CENTER);
  text("18:00",width/2-(m+3),height/2);
  textAlign(RIGHT,TOP);
  text("13:00",width/2-(m+3)*cos(PI*75/180),height/2+(m+3)*sin(PI*75/180));
  text("14:00",width/2-(m+3)*cos(PI*60/180),height/2+(m+3)*sin(PI*60/180));
  text("15:00",width/2-(m+3)*cos(PI*45/180),height/2+(m+3)*sin(PI*45/180));
  text("16:00",width/2-(m+3)*cos(PI*30/180),height/2+(m+3)*sin(PI*30/180));
  text("17:00",width/2-(m+3)*cos(PI*15/180),height/2+(m+3)*sin(PI*15/180));
  
  
  fill(255,100);
  //PFont f1=createFont("Arial",12);
  textFont(f1);
  textAlign(CENTER,BOTTOM);
  text("00:00",width/2+(m+3)*cos(-PI/2),height/2+(m+3)*sin(-PI/2));
  textAlign(CENTER,TOP);
  text("12:00",width/2+(m+3)*cos(PI/2),height/2+(m+3)*sin(PI/2));
  textAlign(LEFT,BOTTOM);
  text("01:00",width/2+(m+3)*cos(-PI*75/180),height/2+(m+3)*sin(-PI*75/180));
  text("02:00",width/2+(m+3)*cos(-PI*60/180),height/2+(m+3)*sin(-PI*60/180));
  text("03:00",width/2+(m+3)*cos(-PI*45/180),height/2+(m+3)*sin(-PI*45/180));
  text("04:00",width/2+(m+3)*cos(-PI*30/180),height/2+(m+3)*sin(-PI*30/180));
  text("05:00",width/2+(m+3)*cos(-PI*15/180),height/2+(m+3)*sin(-PI*15/180));
  textAlign(LEFT,CENTER);
  text("06:00",width/2+(m+3),height/2);
  textAlign(LEFT,TOP);
  text("11:00",width/2+(m+3)*cos(PI*75/180),height/2+(m+3)*sin(PI*75/180));
  text("10:00",width/2+(m+3)*cos(PI*60/180),height/2+(m+3)*sin(PI*60/180));
  text("09:00",width/2+(m+3)*cos(PI*45/180),height/2+(m+3)*sin(PI*45/180));
  text("08:00",width/2+(m+3)*cos(PI*30/180),height/2+(m+3)*sin(PI*30/180));
  text("07:00",width/2+(m+3)*cos(PI*15/180),height/2+(m+3)*sin(PI*15/180));
  textAlign(RIGHT,BOTTOM);
  text("23:00",width/2-(m+3)*cos(-PI*75/180),height/2+(m+3)*sin(-PI*75/180));
  text("22:00",width/2-(m+3)*cos(-PI*60/180),height/2+(m+3)*sin(-PI*60/180));
  text("21:00",width/2-(m+3)*cos(-PI*45/180),height/2+(m+3)*sin(-PI*45/180));
  text("20:00",width/2-(m+3)*cos(-PI*30/180),height/2+(m+3)*sin(-PI*30/180));
  text("19:00",width/2-(m+3)*cos(-PI*15/180),height/2+(m+3)*sin(-PI*15/180));
  textAlign(RIGHT,CENTER);
  text("18:00",width/2-(m+3),height/2);
  textAlign(RIGHT,TOP);
  text("13:00",width/2-(m+3)*cos(PI*75/180),height/2+(m+3)*sin(PI*75/180));
  text("14:00",width/2-(m+3)*cos(PI*60/180),height/2+(m+3)*sin(PI*60/180));
  text("15:00",width/2-(m+3)*cos(PI*45/180),height/2+(m+3)*sin(PI*45/180));
  text("16:00",width/2-(m+3)*cos(PI*30/180),height/2+(m+3)*sin(PI*30/180));
  text("17:00",width/2-(m+3)*cos(PI*15/180),height/2+(m+3)*sin(PI*15/180));
  
  fill(0);
  noStroke();
  rect(0,0,310,height);
  stroke(255);
  line(40,height/2-32,300,height/2-32);
  fill(255);
  PFont f10=createFont("Arial",40);
  PFont f2=createFont("Arial",14);
  textFont(f10);
  textAlign(LEFT,CENTER);
  text("Air Ragers",40,height/2-80);
  fill(150);
  textFont(f2);
  text("Visualizing the on-time performance",40,height/2);
  text("of flights from Beijing to Shanghai",40,height/2+22);
  text("from 2019 03/25 to 03/31",40,height/2+44);
}


void update(float x, float y) {
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
    circle2Over = false;
  } 
  else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;
    circle2Over = false;
  } 
  else if ( overCircle2(circle2X, circle2Y, circle2Size) ) {
    rectOver = false;
    circleOver = false;
    circle2Over = true;
  } 
  else {
    circleOver = rectOver = circle2Over = false;
  }
}

void mousePressed() {
  if (circleOver) {
    circleOver1 = true;
    rectOver1 = false;
    circle2Over1 = false;
  }
  if (rectOver) {
    circleOver1 = false;
    rectOver1 = true;
    circle2Over1 = false;
  }
  if (circle2Over) {
    circleOver1 = false;
    rectOver1 = false;
    circle2Over1 = true;
  }
}

boolean overRect(float x, float y, float width, float height)  {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height){
    return true;
  }
  else {
    return false;
  }
}

boolean overCircle(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  }
  else {
    return false;
  }
}

boolean overCircle2(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  }
  else {
    return false;
  }
}


class DOT{
  float distance, time1, time2, arrival, itime, idistance;
  int delaytime, distance0;
  String code;
  DOT(float d, float t1, float t2, float a, String c, int dd){
    time1=t1;
    time2=t2;
    distance=map(d,0,135,0,m);
    arrival=a;
    itime=1440/4;
    idistance=0;
    delaytime=0;
    code=c;
    distance0=dd;
  }
  void update(){
    itime+=1;
    strokeWeight(0.2);
    stroke(150,50);
    line(width/2,height/2,width/2+m*cos(map(itime,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+m*sin(map(itime,0,1440,0-0.5*PI,2*PI-0.5*PI)));
    
    if(itime>=time1){
      time1+=1;
      idistance+=n;
      if(time2>=time1){
        strokeWeight(12);
        stroke(255,100,0,100);
        if(rectOver1){
          noStroke();
        }
        point(width/2+idistance*cos(map(time1,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+idistance*sin(map(time1,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        fill(255,100);
        PFont f6 = createFont("Arial", 12);
        textAlign(LEFT,CENTER);
        textFont(f6);
        text(code,10+width/2+idistance*cos(map(time1,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+idistance*sin(map(time1,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
    }
    if(itime>=time2){
      time2+=1;
      distance+=n;
      if(arrival>=time2){
        strokeWeight(12);
        stroke(255,100);
        if(rectOver1){
          noStroke();
        }
        point(width/2+distance*cos(map(time2,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+distance*sin(map(time2,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        fill(255,100);
        PFont f6 = createFont("Arial", 12);
        textAlign(LEFT,CENTER);
        textFont(f6);
        text(code,10+width/2+distance*cos(map(time2,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+distance*sin(map(time2,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        fill(255,100,0,100);
        PFont f7 = createFont("Arial Bold", 12);
        textAlign(CENTER,CENTER);
        textFont(f7);
        text(distance0,66+width/2+distance*cos(map(time2,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+distance*sin(map(time2,0,1440,0-0.5*PI,2*PI-0.5*PI)));
        textAlign(LEFT,CENTER);
        text("mins delay",76+width/2+distance*cos(map(time2,0,1440,0-0.5*PI,2*PI-0.5*PI)),height/2+distance*sin(map(time2,0,1440,0-0.5*PI,2*PI-0.5*PI)));
      }
    }
  } 
} 
