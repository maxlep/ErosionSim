// import gab.opencv.*;

Terrain terrain;
WaterErosion water;

static String inputHeightmap = "heightmap04.png";
static float displayScale = 1;
static int MAX_HEIGHT = 255;
// Height is treated as an unsigned int so the max this value can be is Integer.toUnsignedLong(-1)

boolean autorun = false;
boolean debug = true;
boolean print = true;

int simulationStep = 0;

void setup()
{
	size(500,500);
	noStroke();
	fill(0,0,255);

	// Load the initial heightmap
	String heightmapFile = "Heightmaps/"+inputHeightmap;
	PImage heightmap = loadImage(heightmapFile);
	println("Loaded",heightmapFile,"as heightmap. (",heightmap.width,"x",heightmap.height,")");

	// Intialize the terrain and the water map
	terrain = new Terrain(heightmap);
	water = new WaterErosion(terrain);

	// Initialize the simulation with some droplets
	for (int i=0; i<50000; i++)
	{
		water.addRandomDroplet();
	}
}

void doSimulationStep()
{
	if (print) println("----------\nStarting simulation step",simulationStep);
	water.doSimulationStep();
	simulationStep++;
	if (print) println("Finished simulation step");
}

void draw()
{
	if (autorun) doSimulationStep();

	pushMatrix();
	scale(displayScale);
	terrain.draw();
	if (debug) water.draw();
	popMatrix();
}

void mouseClicked()
{
	int terrainX = int(mouseX / displayScale);
	int terrainY = int(mouseY / displayScale);
	if (terrainX > terrain.getWidth() || terrainY > terrain.getHeight()) return;

	int height = terrain.getHeightValue(terrainX, terrainY);
	println("Clicked",terrainX,"x",terrainY,"y",height,"value");
	// println("Clicked",terrainX,"x",terrainY,"y",height.toUnsignedString(),"value");
}

void keyPressed()
{
	switch (key)
	{
		case 'n':
			doSimulationStep();
			break;
		case 'c':
			autorun = !autorun;
			break;
		case 'r':
			for (int i=0; i<1000; i++)
			{
				water.addRandomDroplet();
			}
			break;
		case 'd':
			debug = !debug;
			break;
		case 'p':
			print = !print;
			break;
		case 's':
			color[] colors;
			if (autorun)
				colors = new color[] { color(0), color(255) };
			else
				colors = new color[] { color(0,0,255), color(64,252,255), color(255,240,73), color(255,42,42) };

			PImage colored = terrain.getColorBlend(colors);

			String filename = inputHeightmap+"_"+millis()+".png";
			String path = "Outputs/" + filename;

			colored.save(path);
			println("Saved image", path);
			break;
	}
}