import java.io.*;    // Needed for BufferedReader //<>//
import queasycam.*;
import controlP5.*;

QueasyCam cam;
ControlP5 cp5;
Button ChangeScene;
float xPos = 150;
float zPos = 300;
float speed = 1.0f;
BufferedReader reader;
PShape obj;
Scene scene1;
Scene scene2;
boolean isOne=false;
String[] pieces;
String objName;
int x1, y1, z1; 
float xL, yL, zL, cLR, cLG, cLB, cR, cG, cB;
ArrayList<Scene> scenes = new ArrayList<Scene>();
int currentScene = 0;
void setup()
{
  size(1200, 1000, P3D);

  pixelDensity(2);
  perspective(radians(90), width/(float)height, 0.1, 1000);

  cp5 = new ControlP5(this);
  ChangeScene = cp5.addButton("ChangeScene").setPosition(10, 10).setLabel("Change Scene");

  cam = new QueasyCam(this);
  cam.speed = 0;
  cam.sensitivity = 0;
  cam.position = new PVector(0, -100, 200);

  // TODO: Load scene files here (testfile, scene 1, and scene 2)
  scene1 = new Scene("scene1");
  scene2 = new Scene("scene2");
  scenes.add(scene1);
  scenes.add(scene2);
  lights(); // Lights turned on once here
}

void draw()
{

  // Use lights, and set values for the range of lights. Scene gets REALLY bright with this commented out...
  lightFalloff(1.0, 0.001, 0.0001);
  perspective(radians(90), width/(float)height, 0.1, 1000);
  
  pushMatrix();
  rotateZ(radians(180)); // Flip everything upside down because Processing uses -y as up
  //rotateY(radians(70));
  // TODO: Draw the current scene //<>//
  scenes.get(currentScene).DrawScene();
  popMatrix();
  
  camera();
  perspective();
  noLights(); // Turn lights off for ControlP5 to render correctly
  DrawText();
}

void mousePressed()
{
  if (mouseButton == RIGHT)
  {
    // Enable the camera
    cam.sensitivity = 1.0f; 
    cam.speed = 2;
  }
}

void mouseReleased()
{  
  if (mouseButton == RIGHT)
  {
    // "Disable" the camera by setting move and turn speed to 0
    cam.sensitivity = 0; 
    cam.speed = 0;
  }
}
void keyPressed(){
  
  
}
void ChangeScene()
{
  currentScene++;
  if (currentScene >= scenes.size())
    currentScene = 0;
}

void DrawText()
 {
 textSize(30);
 text("PShapes: " + scenes.get(currentScene).GetShapeCount(), 0, 60);
 text("Lights: " + scenes.get(currentScene).GetLightCount(), 0, 90);
 }
