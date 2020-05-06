
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
	println("setup");
	loadGradients();

	surface.setLocation(200,200);
	// setDefaultClosePolicy(this, true);

	// Create the settings window GUI
	createGUI();
	// Set some default UI values
	txtHeightmapPath.setText("Heightmaps/heightmap04.png");
	// listDisplayGradient.setItems( gradientMap.keySet().toArray(new String[0]), 0 );

	// Launch a simulation window
	// startSimulation();
}

void draw()
{
  
}

public void startSimulation()
{
  try
  {
  	readParams();
  	openSimulationWindow(global_params);
  } catch(Exception e) {
    println(e);
  }
}

public void readParams()
{
	//global_params.sourceHeightmapFilename = "heightmap05";
	global_params.sourceHeightmapPath = txtHeightmapPath.getText();
	global_params.displayScale = 1;
	global_params.autorun = false;

	// Load the initial heightmap
	//String heightmapFile = "Heightmaps/"+global_params.sourceHeightmapFilename+".png";
  println("load file", global_params.sourceHeightmapPath);
	global_params.sourceHeightmap = loadImage(global_params.sourceHeightmapPath);
  println("load file", global_params.sourceHeightmapPath);
	global_params.width = global_params.sourceHeightmap.width;
	global_params.height = global_params.sourceHeightmap.height;
	//global_params.sourceHeightmap = null;
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
