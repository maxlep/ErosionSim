
import g4p_controls.*;

public SimulationWindow activeSimulation;
public HashMap<String,Gradient> gradientPresets;

private static int windowX=500, windowY=500;

void settings()
{
	size(300,800);
}

void setup()
{
	loadGradientPresets();

	// Create the settings window GUI
	createGUI();
	setGUIdefaults();
	surface.setLocation(windowX,windowY);
	// setDefaultClosePolicy(this, true);

	int test = constrain(10, 1,5);
	println(test);
	test = constrain(-1, 5,1);
	
	println(test);

	// Launch a simulation window
	startSimulation();
}

void draw()
{
	// Need to have this function for GUI to draw

	// Update GUI displays
	if (activeSimulation != null && activeSimulation.data != null)
	{
		valStepCount.setText( Integer.toString( activeSimulation.data.getSimulationStep() ) );
		valDropletCount.setText( Integer.toString( activeSimulation.data.getDropletCount() ) );

		if (activeSimulation.settings.running)
			valStepRate.setText( Integer.toString( activeSimulation.data.getLastStepRate() ) );
		else
			valStepRate.setText("#");

		int scaledX = activeSimulation.data.mouseX / activeSimulation.settings.displayScale;
		int scaledY = activeSimulation.data.mouseY / activeSimulation.settings.displayScale;
		if (scaledX > 0 && scaledX < activeSimulation.settings.width &&
			scaledY > 0 && scaledY < activeSimulation.settings.height)
		{
			valMousePos.setText( String.format("%d, %d", scaledX,scaledY) );
			valHeight.setText( String.format("%.2f", activeSimulation.data.terrain.getHeightValue(scaledX,scaledY)) );
			PVector gradient = activeSimulation.data.terrain.getSurfaceGradient(scaledX,scaledY);
			valGradient.setText( String.format("%.2f, %.2f", gradient.x, gradient.y) );
		}
	}
}

public void startSimulation()
{
	resetGUI();
	try
	{
		openSimulationWindow(settingsInstance);
	} catch(Exception e) {
		e.printStackTrace();
	}
}

// Sets GUI defaults and populates the SimulationSettings with initial values
public void setGUIdefaults()
{
	txtHeightmapPath.setText("Heightmaps/heightmap04.png");
	txtHeightmapPath_change(txtHeightmapPath, GEvent.ENTERED);

	sliderDropletLimit.setValue(10000);
	sliderDropletLimit_change(sliderDropletLimit, GEvent.CHANGED);
	sliderDropletLifetime.setValue(40);
	sliderDropletLifetime_change(sliderDropletLimit, GEvent.CHANGED);

	sliderInitialSpeed.setValue(1);
	sliderInitialSpeed_change(sliderInitialSpeed, GEvent.CHANGED);
	sliderInertia.setValue(0.05f);
	sliderInertia_change(sliderInertia, GEvent.CHANGED);

	sliderInitialWater.setValue(1);
	sliderInitialWater_change(sliderInitialWater, GEvent.CHANGED);
	sliderEvaporateSpeed.setValue(0.05f);
	sliderEvaporateSpeed_change(sliderEvaporateSpeed, GEvent.CHANGED);

	sliderErodeSpeed.setValue(0.01f);
	sliderErodeSpeed_change(sliderErodeSpeed, GEvent.CHANGED);
	sliderDepositSpeed.setValue(0.01f);
	sliderDepositSpeed_change(sliderDepositSpeed, GEvent.CHANGED);

	chkWater.setSelected(true);
	chkWater_clicked(chkWater, GEvent.SELECTED);

	listDisplayGradients.setItems( gradientPresets.keySet().toArray(new String[0]), 2 );
	listDisplayGradients_click(listDisplayGradients, GEvent.CLICKED);

	settingsInstance.waterBrush = new ValueBrush(80, 1f, 1);
	settingsInstance.terrainBrush = new ValueBrush(80, 0.2f, 2);
	settingsInstance.resistanceBrush = new ValueBrush(80, 1f, 1);
	optMouseWater.setSelected(true);
	optMouseWater_clicked(optMouseWater, GEvent.SELECTED);

	// TODO connect display scale to GUI
	settingsInstance.displayScale = 1;
}

public void loadBrushSettings()
{
	ValueBrush b = settingsInstance.activeBrush;
	sliderBrushRadius.setValue( b.getRadius() );
	sliderBrushHardness.setValue( b.getHardness() );
}

public void resetGUI()
{
	settingsInstance.running = true;		// Set opposite of the desired default
	btnPlay_click(btnPlay, GEvent.CLICKED);	// ...so this event toggles it.
}

public void openSimulationWindow(SimulationSettings settings)
{
	String[] args = {	"--display=1",
						String.format("--location=%d,%d",windowX+width,windowY),
						""};//,
						//"--sketch-path=" + sketchPath};//,
						// "Projector"};
	activeSimulation = new SimulationWindow(settings);
	PApplet.runSketch(args, activeSimulation);
}

public void loadGradientPresets()
{
	gradientPresets = new HashMap<String,Gradient>();
	color[] colors;

	colors = new color[] { color(0), color(255) };
	gradientPresets.put( "Grayscale", new Gradient(colors) );

	colors = new color[] { color(0,0,255), color(64,252,255), color(255,240,73), color(255,42,42) };
	gradientPresets.put( "Heatmap", new Gradient(colors) );

	// colors = new color[] { color(16,14,140), color(32,108,201), color(255,251,212), color(72,161,0) };
	colors = new color[] { color(5,0,94), color(18,18,144), color(0,63,255), color(245,244,193), color(25,93,23), color(0,173,23) };
	gradientPresets.put( "Coasts", new Gradient(colors) );

	colors = new color[] { color(26,96,24), color(5,186,0), color(104,218,100), color(182,161,127), color(194,182,157), color(255) };
	gradientPresets.put( "Mountains", new Gradient(colors) );

	colors = new color[] { color(131,58,180), color(253,29,29), color(252,176,69) };
	gradientPresets.put( "Sunset", new Gradient(colors) );

	// colors = new color[] { color(), color(), color(), color(), color(), color() };
	// gradientPresets.put( "Stripes", new Gradient(colors) );

	colors = new color[] { color(0), color(255), color(0), color(255), color(0), color(255), color(0), color(255) };
	gradientPresets.put( "Hypnotize", new Gradient(colors) );
}
