import gab.opencv.*;

Terrain terrain;
WaterMap water;

static float displayScale = 1;

boolean autorun = false;

void setup()
{
	size(500,500);
	noStroke();
	fill(0,0,255);

	String heightmapFile = "heightmap03.png";
	PImage heightmap = loadImage(heightmapFile);
	println("Loaded",heightmapFile,"as heightmap. (",heightmap.width,"x",heightmap.height,")");
	terrain = new Terrain(heightmap);
	water = new WaterMap(terrain);

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
	water.draw();
	popMatrix();
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
		case 's':
			if (autorun)
			{
				color c1 = color(0);
				color c2 = color(255);
				PImage colored = terrain.getColorBlend(c1,c2);
				colored.save("out.png");
			}
			else
			{
				color c1 = color(255,0,0);
				color c2 = color(0,0,255);
				PImage colored = terrain.getColorBlend(c1,c2);
				colored.save("out.png");
			}
			break;
	}
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