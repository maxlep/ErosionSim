
import java.nio.file.Path; 
import java.nio.file.Paths; 

public SimulationSettings settingsInstance = new SimulationSettings();

class SimulationSettings
{
	public static final int MAX_HEIGHT = 255;
	public static final float SEDIMENT_LIMIT = 100f;

	public boolean running;
	public boolean showWater;
	public boolean logToConsole;

	private MouseMode mouseMode;
	public ValueBrush activeBrush;	// Just a pointer to the brush for the current mode
	public ValueBrush waterBrush;
	public ValueBrush terrainBrush;
	public ValueBrush resistanceBrush;

	public int dropletSoftLimit;

	public Gradient displayGradient;

	private String sourceHeightmapPath;
	private String sourceHeightmapFilename;
	private PImage sourceHeightmap;
	private int width, height;

	public String getSourceHeightmapFilename() { return sourceHeightmapFilename; }
	public PImage getSourceHeightmap() { return sourceHeightmap; }
	public int getWidth() { return width; }
	public int getHeight() { return height; }

	public void setSourceHeightmap(String sourceHeightmapPath)
	{
		// This should throw an exception if path is invalid, before any fields are actually assigned
		Path testPath = Paths.get(sourceHeightmapPath);
		Path testFile = testPath.getFileName();

		this.sourceHeightmapPath = testPath.toString();
		sourceHeightmapFilename = testFile.toString();
		sourceHeightmap = loadImage(this.sourceHeightmapPath);
		this.width = sourceHeightmap.width;
		this.height = sourceHeightmap.height;

		println(width, height);
	}

	public MouseMode getMouseMode() { return mouseMode; }

	public void setMouseMode(MouseMode mode)
	{
		mouseMode = mode;
		switch(mouseMode)
		{
			case WATERSOURCE:
				activeBrush = waterBrush;
				break;
			case HEIGHT:
				activeBrush = terrainBrush;
				break;
			case ROCK:
				activeBrush = resistanceBrush;
				break;
			case DEBUG:
				// TODO add debug brush?
				activeBrush = terrainBrush;
				break;
		}
	}
}

class SimulationData
{
	public Terrain terrain;
	public WaterErosion water;
	public PGraphics canvas;

	private int simulationStep;
	private int dropletCount;

	private int stepsInLastSec;
	private int stepsCountEndTime;
	private int lastStepRate;

	public SimulationData(SimulationSettings settings)
	{
		terrain = new Terrain(settings.getSourceHeightmap());
		water = new WaterErosion(settings, this);
		canvas = createGraphics(settings.getWidth(), settings.getHeight());
		simulationStep = 0;
		stepsCountEndTime = millis() + 1000;
		lastStepRate = 0;
	}

	public int getSimulationStep() { return simulationStep; }
	public int getLastStepRate() { return lastStepRate; }
	public int getDropletCount() { return dropletCount; }
	
	public void incrementSimulationStep()
	{
		if (stepsCountEndTime <= millis())
		{
			stepsCountEndTime = millis() + 1000;
			lastStepRate = stepsInLastSec;
			stepsInLastSec = 0;
		}
		simulationStep++;
		stepsInLastSec++;
	}
}

public enum MouseMode
{
	WATERSOURCE,
	HEIGHT,
	ROCK,
	DEBUG
}