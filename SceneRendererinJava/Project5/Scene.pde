class Scene //<>// //<>//
{
  /*
   important structures to implement:
   Some way to store PShapes and their positions
   Some way to store lights--position plus color for the pointLight() function
   Other classes may be helpful here
   A background color for the scene
   */
  BufferedReader reader;
  int i;
  String line;
  String sceneName;
  String objName;
  int numMeshes;
  int numLights;
  color background;
  ArrayList<Mesh> models;
  ArrayList<Light> lights;

  Scene(String sceneName) {
    models = new ArrayList<Mesh>();
    lights = new ArrayList<Light>();
    reader = createReader("scenes/"+sceneName+".txt");
    this.readScene(reader);
  }

  int GetShapeCount() {
    return numMeshes;
  }

  int GetLightCount() {
    return numLights;
  }

  void readScene(BufferedReader reader) {
    readTop(reader);
    for (int i = 0; i< numMeshes; i++)
      readMesh(reader);
    readLightCount(reader);
    for (int j = 0; j< numLights; j++)
      readLight(reader);
  }

  void readTop(BufferedReader reader) {
    try {
      line = reader.readLine();
      String[] colorLine = line.split(",");
      int r = Integer.parseInt(colorLine[0]);
      int g = Integer.parseInt(colorLine[1]);
      int b = Integer.parseInt(colorLine[2]);
      background = color(r, g, b);
      line = reader.readLine();
      numMeshes = Integer.parseInt(line);
    }
    catch(IOException e) {
      e.printStackTrace();
      numMeshes=0;
    }
  }

  void readMesh(BufferedReader reader) {
    try {
      line = reader.readLine();
      String[] meshLine = line.split(",");
      objName = meshLine[0];
      float x = Float.parseFloat(meshLine[1]);
      float y = Float.parseFloat(meshLine[2]);
      float z = Float.parseFloat(meshLine[3]);
      int cR = Integer.parseInt(meshLine[4]);
      int cG = Integer.parseInt(meshLine[5]);
      int cB = Integer.parseInt(meshLine[6]);
      PShape obj = loadShape("models/" +objName+".obj");
      Mesh mesh = new Mesh(objName, color(cR, cG, cB), new PVector(x, y, z), obj);
      models.add(mesh);
    }
    catch(IOException e) {
      e.printStackTrace();
      numMeshes=0;
    }
  }

  void readLightCount(BufferedReader reader) {
    try {
      line = reader.readLine();
      numLights = Integer.parseInt(line);
    }
    catch(IOException e) {
      e.printStackTrace();
    }
  }

  void readLight(BufferedReader reader) {
    try {
      line = reader.readLine();
      String[] lightLine = line.split(",");
      float xL = Float.parseFloat(lightLine[0]);
      float yL = Float.parseFloat(lightLine[1]);
      float zL = Float.parseFloat(lightLine[2]);
      float cLR = Float.parseFloat(lightLine[3]);
      float cLG = Float.parseFloat(lightLine[4]);
      float cLB = Float.parseFloat(lightLine[5]);
      Light light = new Light(color(cLR, cLG, cLB), new PVector(xL, yL, zL));
      lights.add(light);
    }
    catch(IOException e) {
      e.printStackTrace();
      numLights=0;
    }
  }

  void DrawScene()
  {
    /*
     Just like using draw() with a regular sketch, things you would need to do
     Clear the screen with background()
     Set up any lights in this scene
     Draw each object in the correct location
     */
    background(background);
    for (Light light : lights)
      light.setLight();
    for (Mesh mesh : models)
      mesh.drawMesh();
  }
}
