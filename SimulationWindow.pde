
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
		if (settings.logToConsole) println("----------\nStarting simulation step",data.getSimulationStep());
		data.water.doSimulationStep();
		data.incrementSimulationStep();
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

		// PImage testImg = data.water.waterSources.getValuesOnGradient(settings.displayGradient);
		// pg.image(testImg, 0,0);

		// Draw brush cursor
		pg.noFill();
		pg.stroke(0,255,0);
		pg.ellipseMode(RADIUS);
		// TODO take radius from GUI
		pg.ellipse(mouseX,mouseY, settings.activeBrush.getRadius(),settings.activeBrush.getRadius());

		// pg.popMatrix();
		pg.endDraw();

		image(pg, 0,0);
	}

	void mouseClicked()
	{
		if (mouseX > settings.getWidth() || mouseY > settings.getHeight()) return;

		switch (settings.getMouseMode())
		{
		case WATERSOURCE: // Modify water sources

			break;
		case HEIGHT: // Modify terrain
			break;
		case ROCK: // Read heightmap values
			int height = data.terrain.getHeightValue(mouseX, mouseY);
			println("Clicked",mouseX,"x",mouseY,"y",height,"value");
			// println("Clicked",terrainX,"x",terrainY,"y",height.toUnsignedString(),"value");
			break;
		case DEBUG:

			break;
		}
	}

	void mouseDragged()
	{
		if (mouseX > settings.getWidth() || mouseY > settings.getHeight()) return;

		boolean rightClick = (mouseButton == RIGHT);
		switch (settings.getMouseMode())
		{
		case WATERSOURCE: // Modify water sources
			// for (int i=0; i<1000; i++)
			// {
			// 	data.water.addRandomDroplet(mouseX, mouseY, 30);
			// }
			data.water.waterSources.applyBrush(mouseX, mouseY, settings.waterBrush, rightClick);
			break;
		case HEIGHT: // Modify terrain
			data.terrain.heightmap.applyBrush(mouseX, mouseY, settings.terrainBrush, rightClick);
			break;
		case ROCK: // Read heightmap values
			int height = data.terrain.getHeightValue(mouseX, mouseY);
			println("Clicked",mouseX,"x",mouseY,"y",height,"value");
			// println("Clicked",terrainX,"x",terrainY,"y",height.toUnsignedString(),"value");
			break;
		case DEBUG:

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
