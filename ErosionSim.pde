
import g4p_controls.*;

public SimulationWindow activeSimulation;
public HashMap<String,Gradient> gradientPresets;

private static int windowX=500, windowY=500;

void settings()
{
	size(300,500);
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

	chkWater.setSelected(true);
	chkWater_clicked(chkWater, GEvent.SELECTED);

	listDisplayGradients.setItems( gradientPresets.keySet().toArray(new String[0]), 1 );
	listDisplayGradients_click(listDisplayGradients, GEvent.CLICKED);

	// TODO add droplet limit GUI
	settingsInstance.dropletSoftLimit = 10000;

	settingsInstance.waterBrush = new ValueBrush(80, 1f, 1);
	settingsInstance.terrainBrush = new ValueBrush(80, 0.2f, 2);
	settingsInstance.resistanceBrush = new ValueBrush(80, 1f, 1);
	optMouseTerrain.setSelected(true);
	optMouseTerrain_clicked(optMouseTerrain, GEvent.SELECTED);

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
}
