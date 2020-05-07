
import g4p_controls.*;

public SimulationWindow simulation;
public SimulationParameters global_params;
public HashMap<String,Gradient> gradientMap;

void settings()
{
	size(300,500);
	println(width,height);
}

void setup()
{
	global_params = new SimulationParameters();
	loadGradients();

	// Create the settings window GUI
	createGUI();
	surface.setLocation(200,200);
	// setDefaultClosePolicy(this, true);

	// Set some default UI values
	txtHeightmapPath.setText("Heightmaps/heightmap04.png");
	chkWater.setSelected(true);
	chkWater_clicked(chkWater, GEvent.SELECTED);
	listDisplayGradients.setItems( gradientMap.keySet().toArray(new String[0]), 0 );
	
	global_params.targetDropletCount = 30000;

	// Launch a simulation window
	startSimulation();
}

void draw()
{
	// Need to have this function for GUI to draw
}

public void startSimulation()
{
	try
	{
		readParams();
		openSimulationWindow(global_params);
	} catch(Exception e) {
		e.printStackTrace();
	}
}

public void readParams()
{
	// Set params through GUI events
	txtHeightmapPath_change(txtHeightmapPath, GEvent.ENTERED);
	chkWater.setSelected(true);
	chkWater_clicked(chkWater, GEvent.SELECTED);
	global_params.autorun = true;			// Set opposite of the desired default
	btnPlay_click(btnPlay, GEvent.CLICKED);	// ...so this event toggles it.
	listDisplayGradients_click(listDisplayGradients, GEvent.CLICKED);

	// Load the initial heightmap
	global_params.sourceHeightmap = loadImage(global_params.sourceHeightmapPath);
	global_params.width = global_params.sourceHeightmap.width;
	global_params.height = global_params.sourceHeightmap.height;

	// Set some other defaults
	global_params.displayScale = 1;
	global_params.dropletCount = 0;
	global_params.autorun = false;
	global_params.print = false;
	global_params.debug = true;
}

public void openSimulationWindow(SimulationParameters settings)
{
	String[] args = {	"--display=1",
						String.format("--location=%d,%d",500,200),
						""};//,
						//"--sketch-path=" + sketchPath};//,
						// "Projector"};
	simulation = new SimulationWindow(settings);
	PApplet.runSketch(args, simulation);
}

public void loadGradients()
{
	gradientMap = new HashMap<String,Gradient>();
	color[] colors;

	colors = new color[] { color(0), color(255) };
	gradientMap.put( "Grayscale", new Gradient(colors) );

	colors = new color[] { color(0,0,255), color(64,252,255), color(255,240,73), color(255,42,42) };
	gradientMap.put( "Heatmap", new Gradient(colors) );
}
