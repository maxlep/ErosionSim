
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

	// Launch a simulation window
	startSimulation();
}

void draw()
{
	// Need to have this function for GUI to draw

	// Update GUI displays
	if (activeSimulation != null && activeSimulation.data != null)
	{
		lblDropletCount.setText( Integer.toString( activeSimulation.data.getDropletCount() ) );
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
	settingsInstance.dropletSoftLimit = 50000;

	// TODO connect mouse mode GUI
	settingsInstance.waterBrush = new ValueBrush(80, 1f, 1);
	settingsInstance.terrainBrush = new ValueBrush(80, 0.2f, 2);
	settingsInstance.resistanceBrush = new ValueBrush(80, 1f, 1);
	settingsInstance.mouseMode = MouseMode.HEIGHT;
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
