class Terrain {
  ArrayList<PVector> points;

  ArrayList<Integer> triangles;

  Terrain() {
    points = new ArrayList<PVector>();
    triangles = new ArrayList<Integer>();
  }

  void getHeightFromImage(int numRows, int numColumns, PImage myImage) {
    for (int i = 0; i <= numRows; i++) {//generate all vertices.
      for (int j = 0; j <= numColumns; j++) {
        int xIndex= (int)map(j, 0, numColumns + 1, 0, myImage.width);
        int yIndex = (int)map(i, 0, numRows + 1, 0, myImage.height);
        color aColor = myImage.get(xIndex, yIndex);
        float heightFromColor = map(red(aColor), 0, 255, 0, 1.0f);
        int vIndex = i*(numColumns +1) + j;
        points.get(vIndex).y = heightFromColor;
      }
    }
  }


  color getColorfromHeight(float hMod, float snowThresh, int index, boolean useBlend) {
    float relativeHeight = abs(points.get(index).y) * hMod / -snowThresh;    
    float ratio;
    color snow = color(255, 255, 255);
    color grass = color(143, 170, 64);
    color rock = color(135, 135, 135);
    color dirt = color(160, 126, 84);
    color water = color(0, 75, 200);


    if (relativeHeight>1.0) {

      relativeHeight = 1.0;
    }
    if (relativeHeight>=0.8) {
      if (useBlend) {
        ratio = (relativeHeight-0.8f)/.2f;
        return lerpColor(rock, snow, ratio);
      } else
        return snow;
    }
    if (relativeHeight>=0.4 && relativeHeight<=0.8) {
      if (useBlend) {
        ratio = (relativeHeight-0.4f)/0.4f;
        return lerpColor(grass, rock, ratio);
      } else
        return rock;
    }
    if (relativeHeight>=0.2 && relativeHeight <= 0.4) {
      if (useBlend) {
        ratio = (relativeHeight-0.2f)/0.2f;
        return lerpColor(dirt, grass, ratio);
      } else
        return grass;
    }
    if (useBlend) {
      ratio = relativeHeight/0.2f;
      return lerpColor(water, dirt, ratio);
    } else {

      return water;
    }
  }


  void generate(int numRows, int numColumns, float gridSize) { //put all x-y-z into vectors for the vertex data. Then it puts the vectors in groups of 3 (triangles) for each trianglel
    float w = gridSize/numColumns;
    float h = gridSize/numRows;

    points = new ArrayList<PVector>();
    triangles = new ArrayList<Integer>();
    int verticesInRow = numColumns+1;
    int verticesInColumn = numRows +1;
    for (int i = 0; i < verticesInColumn; i++) {//generate all vertices.
      for (int j = 0; j < verticesInRow; j++) {
        float x = j*w - gridSize/2;
        float y = 0;
        float z = i*h - gridSize/2;
        points.add(new PVector(x, y, z));
      }
    }
    for (int i = 0; i < numColumns; i++) {//generate the triangles
      for (int j = 0; j < numRows; j++) {
        int startIndex = j*verticesInRow + i;

        triangles.add(startIndex);
        triangles.add(startIndex + 1);
        triangles.add(startIndex + verticesInRow);
        triangles.add(startIndex + 1);
        triangles.add(startIndex + verticesInRow + 1);
        triangles.add(startIndex + verticesInRow);
      }
    }
  }

  void drawTerrain(float heightMod, float snowThresh, boolean useBlend, boolean useColor, boolean useStroke) {
    if (useStroke){
      stroke(0);
      strokeWeight(1);
    }
    else
      noStroke();

    beginShape(TRIANGLES);
    for (int i = 0; i< triangles.size(); i++) {
      int vertIndex = triangles.get(i);
      PVector vert = points.get(vertIndex);
      if (useColor) {
        color aColor = getColorfromHeight(heightMod, snowThresh, vertIndex, useBlend);
        fill(aColor);
      }
      else
      fill(255);
      vertex(vert.x, heightMod*vert.y, vert.z);
    }
    endShape();
  }

  void smooth(int numRows, int numColumns) {
    int index;
    if(points.size()==0)
    return;
    ArrayList<PVector> before = new ArrayList<PVector>(points);
    System.out.println(before.size());
    for (int i = 0; i<numColumns+1; i++) {
      for (int j = 0; j<numRows +1; j++) {
        int num = 1;
        float sum = 0;
        float avg;
        index = j*(numColumns+1) + i;
        sum += before.get(index).y;

        if (i>0) {
          sum+= before.get(index-1).y;
          num++;
        }
        if (i<numColumns) {
          sum+= before.get(index+1).y;
          num++;
        }

        if (j>0) {
          sum+=before.get(index- (numColumns+1)).y;
          num++;
        } 
        if (j<numRows) {
          sum+= before.get(index + (numColumns+1)).y;
          num++;
        }
        avg = sum/num;
        points.get(index).y = avg;
        System.out.println("Index:"+index+ " Sum:"+ sum +  " Num:" + num + " Avg:" + avg);
      }
    }
  }
}
