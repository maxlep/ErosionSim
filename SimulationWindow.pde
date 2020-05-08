
class SimulationWindow extends PApplet
{
	public SimulationSettings settings;
	public SimulationData data;

	SimulationWindow(SimulationSettings settings)
	{
		this.settings = settings;
	}

	void settings()
	{
		size(settings.getWidth(), settings.getHeight());
	}

	void setup()
	{
		noStroke();
		fill(0,0,255);
		surface.setTitle( settings.getSourceHeightmapFilename() );
		// setDefaultClosePolicy(this, true);

		data = new SimulationData(settings);

		// Initialize the simulation with some droplets
		for (int i=0; i<50000; i++)
		{
			data.water.addRandomDroplet();
		}
	}

	void doSimulationStep()
	{
		if (settings.logToConsole) println("----------\nStarting simulation step",data.simulationStep);
		data.water.doSimulationStep();
		data.simulationStep++;
		if (settings.logToConsole) println("Finished simulation step");
	}

	void draw()
	{
		if (settings.running) doSimulationStep();

		PGraphics pg = data.canvas;
		pg.beginDraw();
		// pg.pushMatrix();
		// pg.scale(2);

		data.terrain.draw(pg, settings.displayGradient);
		if (settings.showWater) data.water.draw(pg);

		// pg.popMatrix();
		pg.endDraw();

		image(pg, 0,0);
	}

	void mouseClicked()
	{
		if (mouseX > settings.getWidth() || mouseY > settings.getHeight()) return;

		switch (settings.mouseMode)
		{
		case 0: // Modify water sources

			break;
		case 1: // Modify terrain

			break;
		case 2: // Read heightmap values
			int height = data.terrain.getHeightValue(mouseX, mouseY);
			println("Clicked",mouseX,"x",mouseY,"y",height,"value");
			// println("Clicked",terrainX,"x",terrainY,"y",height.toUnsignedString(),"value");
			break;
		}
	}

	void mouseDragged()
	{
		if (mouseX > settings.getWidth() || mouseY > settings.getHeight()) return;

		switch (settings.mouseMode)
		{
		case 0: // Modify water sources
			for (int i=0; i<1000; i++)
			{
				data.water.addRandomDroplet(mouseX, mouseY, 30);
			}
			break;
		case 1: // Modify terrain

			break;
		case 2: // Read heightmap values
			int height = data.terrain.getHeightValue(mouseX, mouseY);
			println("Clicked",mouseX,"x",mouseY,"y",height,"value");
			// println("Clicked",terrainX,"x",terrainY,"y",height.toUnsignedString(),"value");
			break;
		}
	}

	public void saveSimulationFrame()
	{
		String filename = String.format("%s_%d.png", settings.getSourceHeightmapFilename(), data.getSimulationStep());
		String path = "Outputs/" + filename;

		PImage colored = data.terrain.getWithGradient(settings.displayGradient);
		colored.save(path);
		println("Saved image", path);
	}

	void keyPressed()
	{
		switch (key)
		{
		case 'p':
			settings.logToConsole = !settings.logToConsole;
			break;
		}
	}
}
