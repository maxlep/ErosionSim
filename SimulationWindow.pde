
class SimulationParameters
{
	static final int MAX_HEIGHT = 255;
	// Height is treated as an unsigned int so the max this value can be is Integer.toUnsignedLong(-1)

	public int width, height;
	public String sourceHeightmapPath;
	public PImage sourceHeightmap;
	public int displayScale;

	// controls
	public boolean autorun;
	public boolean debug;
	public boolean print;
	public int mouseMode;

	// data
	public Terrain terrain;
	public WaterErosion water;
	public int simulationStep;
	public PGraphics canvas;
	public Gradient displayGradient;
}

class SimulationWindow extends PApplet
{
	public SimulationParameters params;

	SimulationWindow(SimulationParameters params)
	{
		this.params = params;
	}
	void settings()
	{
		size(params.width*params.displayScale, params.height*params.displayScale);
		println(width,height);
	}
	void setup()
	{
		noStroke();
		fill(0,0,255);
		surface.setTitle(params.sourceHeightmapPath);
		// setDefaultClosePolicy(this, true);

		// Load the initial heightmap
		//params.sourceHeightmap = null;
		//params.sourceHeightmap = loadImage(params.sourceHeightmapPath);
		//println("Loaded",params.sourceHeightmapPath,"as heightmap. (",params.sourceHeightmap.width,"x",params.sourceHeightmap.height,")");

		// Intialize the terrain and the water map
		params.terrain = new Terrain(params.sourceHeightmap);
		params.water = new WaterErosion(params.terrain, params);
		params.simulationStep = 0;

		// Initialize the PGraphics canvas
		params.canvas = createGraphics(width,height);

		// Initialize the simulation with some droplets
		for (int i=0; i<50000; i++)
		{
			params.water.addRandomDroplet();
		}

		// text("Arguments:", 0, 30);
		// if (args!=null) { //Go through arguments
		// 	for (int i=0; i<args.length; i++)
		// 	{
		// 		text(args[i], 0, 45+15*i);
		// 	}
		// }
	}

	void doSimulationStep()
	{
		if (params.print) println("----------\nStarting simulation step",params.simulationStep);
		params.water.doSimulationStep();
		params.simulationStep++;
		if (params.print) println("Finished simulation step");
	}

	void draw()
	{
		if (params.autorun) doSimulationStep();

		PGraphics pg = params.canvas;
		pg.beginDraw();
		pg.pushMatrix();
		pg.scale(params.displayScale);
		params.terrain.draw(pg);
		if (params.debug) params.water.draw(pg);
		pg.popMatrix();
		pg.endDraw();

		image(pg, 0,0);
	}

	void mouseClicked()
	{
		int terrainX = int(mouseX / params.displayScale);
		int terrainY = int(mouseY / params.displayScale);
		if (terrainX > params.terrain.getWidth() || terrainY > params.terrain.getHeight()) return;

		switch (params.mouseMode)
		{
		case 0: // Modify water sources
			// for (int i=0; i<1000; i++)
			// {
			// 	water.addRandomDroplet(terrainX, terrainY, 30);
			// }
			break;
		case 1: // Modify terrain

			break;
		case 2: // Read heightmap values
			int height = params.terrain.getHeightValue(terrainX, terrainY);
			println("Clicked",terrainX,"x",terrainY,"y",height,"value");
			// println("Clicked",terrainX,"x",terrainY,"y",height.toUnsignedString(),"value");
			break;
		}
	}

	void mouseDragged()
	{
		int terrainX = int(mouseX / params.displayScale);
		int terrainY = int(mouseY / params.displayScale);
		if (terrainX > params.terrain.getWidth() || terrainY > params.terrain.getHeight()) return;

		switch (params.mouseMode)
		{
		case 0: // Modify water sources
			for (int i=0; i<1000; i++)
			{
				params.water.addRandomDroplet(terrainX, terrainY, 30);
			}
			break;
		case 1: // Modify terrain

			break;
		case 2: // Read heightmap values
			int height = params.terrain.getHeightValue(terrainX, terrainY);
			println("Clicked",terrainX,"x",terrainY,"y",height,"value");
			// println("Clicked",terrainX,"x",terrainY,"y",height.toUnsignedString(),"value");
			break;
		}
	}

	void keyPressed()
	{
		switch (key)
		{
		case 'n':
			doSimulationStep();
			break;
		case 'c':
			params.autorun = !params.autorun;
			break;
		case 'r':
			for (int i=0; i<1000; i++)
			{
				params.water.addRandomDroplet();
			}
			break;
		case 'd':
			params.debug = !params.debug;
			break;
		case 'p':
			params.print = !params.print;
			break;
		case 's':
			color[] colors;
			if (params.autorun)
				colors = new color[] { color(0), color(255) };
			else
				colors = new color[] { color(0,0,255), color(64,252,255), color(255,240,73), color(255,42,42) };

			PImage colored = params.terrain.getWithGradient(colors);

			String filename = params.sourceHeightmapPath+"_"+params.simulationStep+".png";
			String path = "Outputs/" + filename;

			colored.save(path);
			println("Saved image", path);
			break;
		}
	}
}
