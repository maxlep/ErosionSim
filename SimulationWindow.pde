
class SimulationWindow extends PApplet
{
	public SimulationSettings settings;
	public SimulationData data;

	private boolean showWaterSources;

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
		surface.setTitle("Erosion Simulator");
		// setDefaultClosePolicy(this, true);
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
    if (settings.displayScaleChanged) frame.setSize(settings.getDisplayWidth(),settings.getDisplayHeight());
		if (settings.running) doSimulationStep();

		PGraphics pg = data.canvas;
		pg.beginDraw();

		data.terrain.draw(pg, settings.displayGradient);
		data.water.draw(pg);

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

	void mousePressed()
	{
		doBrush(true);
	}

	void mouseDragged()
	{
		doBrush(false);
	}

	void mouseReleased()
	{
		settings.showWaterSources = false;
	}
	
	void doBrush(boolean isClick)
	{
		int scaledX = mouseX / settings.displayScale;
		int scaledY = mouseY / settings.displayScale;
		if (scaledX > settings.getWidth() || scaledY > settings.getHeight()) return;

		boolean rightClick = (mouseButton == RIGHT);
		switch (settings.getMouseMode())
		{
		case WATERSOURCE: // Modify water sources
			if (isClick) settings.showWaterSources = true;
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
		String filename = String.format("%d%d%d-%d:%d:%d.png",year(),month(),day(),hour(),minute(),second());
		String path = "Outputs/" + filename;

		PImage colored = data.terrain.toGradientImage(settings.displayGradient);
		colored.save(path);
		println("Saved image", path);
	}

	public void saveHeightmap()
	{
		String filename = String.format("%d%d%d-%d:%d:%d.png",year(),month(),day(),hour(),minute(),second());
		String path = "Outputs/" + filename;

		Gradient grayscale = gradientPresets.get("Grayscale");
		PImage heightmap = data.terrain.toGradientImage( grayscale );
		PImage watersources = data.water.waterSources.toGradientImage( grayscale );
		PImage packedHeightmap = ColorConverter.mergeChannels( createImage(heightmap.width,heightmap.height,RGB), heightmap, watersources );
		packedHeightmap.save(path);
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
