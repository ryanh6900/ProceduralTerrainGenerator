import controlP5.*; //<>//
import java.util.*;
ControlP5 cp5;
float camX = 2.02;//6.06;
float camY = 200;//151.51;
float camZ = -98.98;//-62.62;
Camera myCamera;
PVector lookatLocation;
int numRows, numColumns;
float sizeofTerr, snowThresh;
float hMod = 1;
boolean useStroke = true;
boolean useColor, useBlend;
String fileName;
Slider Rows, Columns, terrainSize, heightMod, snowThreshold;
Button Generate,Smooth;
Toggle stroke, Color, blend;
Textfield terrainLoad;
Terrain myTerrain = new Terrain();

void setup() {
  size(1200, 800, P3D);
  
  pixelDensity(2);
  cp5 = new ControlP5(this);
  myCamera = new Camera(0, 0, 0, 0, 0, 0, 0, 1, 0);
  Generate = cp5.addButton("generate").setLabel("GENERATE").setPosition(10, 80).setSize(75, 20);
  Rows= cp5.addSlider("numRows", 1, 100).setPosition(10, 10).setLabel("ROWS").setSize(100, 10);
  Columns = cp5.addSlider("numColumns", 1, 100).setLabel("COLUMNS").setPosition(10, 30).setSize(100, 10);
  terrainSize = cp5.addSlider("sizeofTerr", 20.0f, 50.0f).setLabel("TERRAIN SIZE").setPosition(10, 50).setSize(100, 10);
  heightMod = cp5.addSlider("hMod", -5.0f, 5.0f).setLabel("HEIGHT MODIFIER").setPosition(250, 50).setSize(100, 10);
  snowThreshold = cp5.addSlider("snowThresh", 1.0f, 5.0f).setLabel("SHOW THRESHOLD").setPosition(250, 70).setSize(100, 10);
  stroke = cp5.addToggle("useStroke").setLabel("STROKE").setPosition(250, 10).setSize(40, 20);
  Color = cp5.addToggle("useColor").setLabel("COLOR").setPosition(300, 10).setSize(40, 20);
  blend = cp5.addToggle("useBlend").setLabel("BLEND").setPosition(350, 10).setSize(40, 20);
  terrainLoad = cp5.addTextfield("fileName").setLabel("LOAD FROM FILE").setPosition(10, 110).setSize(200, 20);
  Smooth = cp5.addButton("smooth").setLabel("SMOOTH").setPosition(90,80).setSize(75,20);
}

void draw() {
  background(0);
  perspective(radians(90), width/(float)height, 0.1, 1000);
  myCamera.Update();
  myTerrain.drawTerrain(-hMod, snowThresh, useBlend, useColor, useStroke);
  resetMatrix();
  camera();
  perspective();
}

void drawGrid() {
  fill(250);
  stroke(255);
  float h= sizeofTerr/numColumns;
  float w = sizeofTerr/numRows;
  strokeWeight(2);
  for (int i =0; i<=numColumns; i++) {

    for (int j = 0; j<= numRows; j++) {
      float x=i*h-sizeofTerr/2;
      float z = j*w-sizeofTerr/2;
      circle(x, z, 1);
    }

    //line(x, 0, -sizeofTerr/2, x, 0, sizeofTerr/2);
    //line(-sizeofTerr/2, 0, z, sizeofTerr/2, 0, z);
  }
}
void generate() {
  myTerrain.generate(numRows, numColumns, sizeofTerr);
  fileName = terrainLoad.getText();
  PImage myImage = loadImage(fileName);
  if (myImage != null)
    myTerrain.getHeightFromImage(numRows, numColumns, myImage);
}
 void smooth(){
   myTerrain.smooth(numRows,numColumns);
 }
 
void mouseDragged() {
  if (cp5.isMouseOver())
    return;
  float deltaX, deltaY;
  deltaX = (mouseX - pmouseX)*0.0015f;
  deltaY = (mouseY - pmouseY)*0.0015f;
  myCamera.phi += deltaX;
  myCamera.theta += deltaY;
  myCamera.phi = max(myCamera.phi, 0);
  myCamera.phi = min(myCamera.phi, radians(360));
  myCamera.theta = max(myCamera.theta, radians(1));
  myCamera.theta = min(myCamera.theta, radians(179));

  //myCamera.phi = map(mouseX, 0, width-1, 0, radians(360));
  //myCamera.theta = map(mouseY, 0, height-1, radians(1), radians(179));
}

void mouseWheel(MouseEvent event) {
  myCamera.Zoom(event.getCount());
}
