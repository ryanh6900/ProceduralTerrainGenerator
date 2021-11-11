class Mesh{
  
  String name;
  PVector pos;
  color c;
  PShape mesh;
  
  Mesh(String _name, color _c, PVector position, PShape _mesh){
   name = _name;
   c= _c;
   pos = position;
   mesh = _mesh;
  }
  
  void drawMesh(){
    mesh.setFill(c);
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    shape(mesh);
    popMatrix();
  }
}
