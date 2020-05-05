// import gab.opencv.*;

Terrain terrain;
WaterMap water;

static String inputHeightmap = "heightmap04.png";
static float displayScale = 1;

boolean autorun = false;
boolean debug = true;
boolean print = true;

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
	water = new WaterMap(terrain);

	// Initialize the simulation with some droplets
	for (int i=0; i<50000; i++)
	{
		water.addRandomDroplet();
	}
}

void doSimulationStep()
{
	int destroyedCount = water.doSimulationStep();
	
	if (autorun)
	{
		for (int i=0; i<destroyedCount; i++)
		{
			water.addRandomDroplet();
		}
	}
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
	PImage heightmap = terrain.getHeightmap();
	int heightmapX = int(mouseX / displayScale);
	int heightmapY = int(mouseY / displayScale);
	if (heightmapX > heightmap.width || heightmapY > heightmap.height) return;
	int heightmapIndex = int(heightmapY * heightmap.width + heightmapX);
	int col = heightmap.pixels[heightmapIndex];
	int height = terrain.heightFromColor(col);
	println("Clicked",heightmapX,"x",heightmapY,"y",height,"value");
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
			String filename = inputHeightmap+"_"+millis()+".png";
			if (autorun)
			{
				color c1 = color(0);
				color c2 = color(255);
				PImage colored = terrain.getColorBlend(c1,c2);

				colored.save("Outputs/" + filename);
			}
			else
			{
				color[] colors = new color[] { color(0,0,255), color(64,252,255), color(255,240,73), color(255,42,42) };
				PImage colored = terrain.getColorBlend(colors);

				colored.save("Outputs/" + filename);
			}
			break;
	}
}