
class SimulationWindow extends PApplet
{
	public SimulationSettings settings;
	public SimulationData data;

	SimulationWindow(SimulationSettings settings)
	{
		this.settings = settings;
		data = new SimulationData(settings);
	}

	void settings()
	{
		size(settings.getDisplayWidth(), settings.getDisplayHeight());
		println(settings.getDisplayWidth(), settings.getDisplayHeight());
	}

	void setup()
	{
		surface.setTitle( settings.getSourceHeightmapFilename() );
		// setDefaultClosePolicy(this, true);

		// Initialize the simulation with some droplets
		// for (int i=0; i<50000; i++)
		// {
		// 	data.water.addRandomDroplet();
		// }
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

		data.terrain.draw(pg, settings.displayGradient);
		if (settings.showWater) data.water.draw(pg);

		pg.endDraw();

		pushMatrix();
		scale(settings.displayScale);
		image(pg, 0,0);
		popMatrix();

		// Draw brush cursor
		noFill();
		stroke(0,255,0);
		ellipseMode(RADIUS);
		int radius = settings.activeBrush.getRadius() * settings.displayScale;
		ellipse(mouseX,mouseY, radius,radius);

		// Save mouse position for display in the settings window
		data.mouseX = mouseX;
		data.mouseY = mouseY;
	}

	void mouseClicked()
	{
		doBrush();
	}

	void mouseDragged()
	{
		doBrush();
	}
	
	void doBrush()
	{
		int scaledX = mouseX / settings.displayScale;
		int scaledY = mouseY / settings.displayScale;
		if (scaledX > settings.getWidth() || scaledY > settings.getHeight()) return;

		boolean rightClick = (mouseButton == RIGHT);
		switch (settings.getMouseMode())
		{
		case WATERSOURCE: // Modify water sources
			// for (int i=0; i<1000; i++)
			// {
			// 	data.water.addRandomDroplet(scaledX, scaledY, 30);
			// }
			data.water.waterSources.applyBrush(scaledX, scaledY, settings.waterBrush, rightClick);
			break;
		case HEIGHT: // Modify terrain
			data.terrain.heightmap.applyBrush(scaledX, scaledY, settings.terrainBrush, rightClick);
			break;
		case ROCK: // Modify terrain resistance

			break;
		case DEBUG: // Read heightmap values
			float height = data.terrain.getHeightValue(scaledX, scaledY);
			println("Clicked",scaledX,"x",scaledY,"y",height,"value");
			// println("Clicked",scaledX,"x",scaledY,"y",height.toUnsignedString(),"value");
			break;
		}
	}

	void mouseWheel(MouseEvent event)
	{
		int currentBrushSize = sliderBrushRadius.getValueI();
		sliderBrushRadius.setValue( currentBrushSize - event.getCount()*10 );
	}

	public void saveSimulationFrame()
	{
		String filename = String.format("%s_%d.png", settings.getSourceHeightmapFilename(), data.getSimulationStep());
		String path = "Outputs/" + filename;

		PImage colored = data.terrain.toGradientImage(settings.displayGradient);
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
