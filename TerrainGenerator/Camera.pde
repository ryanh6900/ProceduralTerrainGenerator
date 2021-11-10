import java.util.*;
class Camera {

  float r=15;
  float phi = 1.57;
  float theta = 1.9;
  float fov;
  int targetIndex =0;
  ArrayList <PVector> targetPositions; //list of PVectors that stores target positions
  PVector camPos;
  PVector lookatTarget;
  PVector cameraUp; //= new PVector(0,1,0);
  Camera(float posX, float posY, float posZ, float tarX, float tarY, float tarZ, int vx, int vy, int vz) {
    camPos = new PVector(posX, posY, posZ);
    lookatTarget = new PVector(tarX, tarY, tarZ);
    cameraUp = new PVector(vx, vy, vz);
    fov=90;
  }
  

  void Update() {
    float x= r*cos(phi)*sin(theta);
    float y = r*cos(theta);
    float z = r*sin(theta)*sin(phi);
    camPos.x= lookatTarget.x + x;
    camPos.y = lookatTarget.y + y;
    camPos.z = lookatTarget.z +z;
    camera(camPos.x, camPos.y, camPos.z, lookatTarget.x, lookatTarget.y, lookatTarget.z, cameraUp.x, cameraUp.y, cameraUp.z);
    //phi+=.01;
  }

  void Zoom(float val) {
    r+=val*2;
    r = max(r,5);
    r = min(r,200);
  }
}
