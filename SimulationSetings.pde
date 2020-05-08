
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

	public MouseMode mouseMode;
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
}

class SimulationData
{
	public Terrain terrain;
	public WaterErosion water;
	public PGraphics canvas;

	private int simulationStep;
	private int dropletCount;

	public SimulationData(SimulationSettings settings)
	{
		terrain = new Terrain(settings.getSourceHeightmap());
		water = new WaterErosion(settings, this);
		canvas = createGraphics(settings.getWidth(), settings.getHeight());
		simulationStep = 0;
	}

	public int getSimulationStep() { return simulationStep; }
	public int getDropletCount() { return dropletCount; }
}

public enum MouseMode
{
	WATERSOURCE,
	HEIGHT,
	ROCK,
	DEBUG
}