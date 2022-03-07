# Procedural Terrain Generator and Scene Renderer Project READMEs
## **1. Procedural Terrain Generator**:
This project is Procedural Terrain Generator. It takes information from PNG files and then, using an generation algorithm I implemented involving height maps, create the terrain
in a 3D space. I will detail the important components of the project down below.

#### Here is a video I created demonstrating the projects functionality:
https://user-images.githubusercontent.com/68438637/157127129-11e567e9-058c-4677-963a-de0f5d0cdd48.mp4



#### Here is a video I created briefly explaining the project's class structure:
https://user-images.githubusercontent.com/68438637/157123926-b6256aa8-b919-45e6-8011-4558d72dae4d.mp4


### The main functions of this project:
- Create a grid of customizable size and detail using the GUI controls
- Load terrain data from a PNG file (files in "data" folder in repository) 
- Load the the terrain data as 3D terrain data on the grid the user creates. 
- Maps colors to terrain elevation, terrain of highest elevation marked by white(snow), terrain of lowest is marked as blue(water)
- User is able to adjust the appearance of the grid through GUI sliders.
- Texture smooth to the users desired look of the terrain.

### Details on drawing grid algorithm:
- I created an ArrayList of vectors that store the vertex data of the points. 
- I created an ArrayLists of integers that store the triangle index data. Each triangle needs 3 integers, each of which reference the vertex data in the first arraylist.
- Using these 2 data structures. I draw thousands of polygons that ultimately create the 3D terrain, this is an industry standard for how terrain is created in 3D applications.
![GridAlgorithmPic](https://user-images.githubusercontent.com/68438637/157119926-b7fc8ec8-fdf6-48b9-827b-8894dba89b44.PNG)
![integerArraylistuse](https://user-images.githubusercontent.com/68438637/157119975-fcbdaf62-ff8b-49be-929d-a1892eb734bb.PNG)

### Details on heightmapping algorithm:
 Here is the pseudocode for the algorithm I implemented:
 ![HeightMappingAlgorithm](https://user-images.githubusercontent.com/68438637/157120102-b8beb14b-8302-4f0b-9605-1143c0bfe3b1.PNG)
<img src="docs/ProceduralTerrainGenerator/colorinfo.PNG">
### Details on texture smoothing algorithm:
For each vertex we are smoothing:
- Sample the position of the vertext and its neighboring vertices
- Take the average of all the y-values of each of those vertices
- Assign the average value to the y-value of the current vertex
<img src="docs/smoothingterrainexampleresults.PNG">

 ## **2. Scene Renderer**:
This project renders text data from scene files. The program parses through a file then draws shapes and creates lights based on what the file contains.
#### The scene files contain:
- The names of mesh files to load (then use to draw objects in scene).
- The world position of the meshes, and the right color of each mesh so we know what color to draw.
- The location and color of lights. I count the number of lights and shapes as I draw them and display them on the GUI.
Here is the scene file format (files are located in the "data" folder under SceneRenderer.

![SceneFileFormat](https://user-images.githubusercontent.com/68438637/157129098-d005f684-7b0b-4092-8045-20eaa6e2e36e.PNG)

#### Here is a video of me demonstrating the project:
https://user-images.githubusercontent.com/68438637/157130113-c5eb30db-c25f-4934-ac51-5f35aba7f83a.mp4

#### Here is a video of me briefly running throught the class structure:

https://user-images.githubusercontent.com/68438637/157131890-a07e4040-92c5-46df-be8e-d414068c2641.mp4

