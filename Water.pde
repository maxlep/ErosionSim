
import java.util.LinkedList;
import java.util.Iterator;

class Droplet
{
	PVector pos;
	PVector dir;
	float speed;
	float water;
	float sediment;
	boolean alternatingFlag;
	int age;

	public Droplet(float x, float y, float initialSpeed, float initialWaterVolume)
	{
		// pos = new PVector(0,0);
		pos = new PVector(x, y);
		dir = new PVector(0,0);
		speed = initialSpeed;
		water = initialWaterVolume;
		sediment = 0;
		alternatingFlag = false;
		age = 0;
	}
}

class WaterErosion
{
	public ValueMap waterSources;

	private LinkedList<Droplet> droplets;
	private boolean nextPassFlag;

	private SimulationSettings settings;
	private SimulationData data;
	private Terrain terrain;

	public WaterErosion(SimulationSettings settings, SimulationData data)
	{
		this.settings = settings;
		this.data = data;
		this.terrain = data.terrain;
		nextPassFlag = false;

		droplets = new LinkedList<Droplet>();
		waterSources = new ValueMap(settings.sourceWatermap, 1);
	}

	public int getWidth() { return data.terrain.getWidth(); }
	public int getHeight() { return data.terrain.getHeight(); }

	public void doSimulationStep()
	{
		int destroyedCount = 0;

		terrain.preStep();

		Iterator<Droplet> iter = droplets.listIterator();
		while (iter.hasNext())
		{
			Droplet d = iter.next();

			int destroyed = updateDroplet(d);
			destroyedCount += destroyed;
			if (destroyed > 0) iter.remove();
		}

		terrain.postStep();

		nextPassFlag = !nextPassFlag;
		data.dropletCount -= destroyedCount;

		int underTarget = settings.dropletSoftLimit - data.dropletCount;
		for (int i=0; i<underTarget; i++)
			tryAddDropletFromSource();
			// addRandomDroplet();
	}

	private int updateDroplet(Droplet d)
	{
		if (d.alternatingFlag != nextPassFlag) return 0;

		// Get the droplet's grid position
		int gridX = int(d.pos.x);
		int gridY = int(d.pos.y);

		// Get the droplet's height and direction of flow
		float height = terrain.getHeightValue(gridX,gridY);
		PVector gradient = terrain.getSurfaceGradient(gridX,gridY);

		// Update the droplet's direction, and count the number to be processed this step.
		d.dir.x = (d.dir.x * settings.inertia + gradient.x * (1 - settings.inertia) );
		d.dir.y = (d.dir.y * settings.inertia + gradient.y * (1 - settings.inertia) );
		d.dir.normalize();

		// Calculate the index the droplet flows to
		d.pos.x = d.pos.x + d.dir.x;
		d.pos.y = d.pos.y + d.dir.y;

		// Remove the droplet if it's not moving or leaves the map
		if ( (d.dir.x == 0 && d.dir.y == 0)
			|| d.pos.x < 0 || d.pos.x >= getWidth()
			|| d.pos.y < 0 || d.pos.y >= getHeight())
		{
			if (d.dir.x == 0 && d.dir.y == 0) terrain.addValue(gridX,gridY, d.sediment);
			return 1;
		}

		int newGridX = int(d.pos.x);
		int newGridY = int(d.pos.y);

		float newHeight = terrain.getHeightValue(newGridX,newGridY);
		float deltaHeight = newHeight - height;

		float sedimentCapacity = Math.max( -deltaHeight * d.speed * d.water * settings.sedimentCapacityFactor, settings.minSedimentCapacity );

		// // If flowing uphill or carrying more than capacity deposit some sediment
		if (deltaHeight > 0 || d.sediment > sedimentCapacity)
		{
			float sedimentToDeposit;
			if (deltaHeight > 0)
				sedimentToDeposit = min(deltaHeight, d.sediment);
			else
				sedimentToDeposit = (d.sediment - sedimentCapacity) * settings.depositSpeed;

			float deltaSediment = sedimentToDeposit;
			d.sediment -= deltaSediment;
			terrain.addValue(gridX,gridY, deltaSediment);
		}
		else	// Otherwise erode and pick up some sediment
		{
			float sedimentToErode = min((sedimentCapacity - d.sediment) * settings.erodeSpeed, -deltaHeight);

			// TODO spread erosion out over a small area
			float deltaSediment = ( height < sedimentToErode ? height : ceil(sedimentToErode) );
			d.sediment += deltaSediment;
			terrain.addValue(gridX,gridY, -deltaSediment);
		}

		d.speed = sqrt( d.speed * d.speed + abs(deltaHeight) * settings.GRAVITY );
		d.water *= (1 - settings.evaporateSpeed);

		// println(gridX,gridY, newGridX,newGridY, d.speed,d.dir,d.water,d.sediment,deltaHeight);

		d.alternatingFlag = !d.alternatingFlag;
		if (++d.age >= settings.maxDropletLifetime)
			return 1;

		return 0;
	}

	public void draw(PGraphics canvas)
	{
		// Debug display
		canvas.fill(0,0,255);
		canvas.noStroke();

		if (settings.showWater)
		{
			Iterator<Droplet> iter = droplets.listIterator();
			while (iter.hasNext())
			{
				Droplet d = iter.next();
				int gridX = int(d.pos.x);
				int gridY = int(d.pos.y);
				canvas.rect(gridX,gridY, 1,1);
			}
		}

		if (settings.showWaterSources)
		{
			canvas.tint(255,176,24,128);
			canvas.image( waterSources.toGradientImage( gradientPresets.get("Grayscale") ), 0,0 );
			canvas.tint(255,255);
		}
	}

	public void addDroplet(int x, int y)
	{
		Droplet d = new Droplet(x,y, settings.initialSpeed, settings.initialWater);
		droplets.add(d);
		data.dropletCount++;
	}

	public boolean tryAddDropletFromSource()
	{
		int x = int( random( getWidth()  ) );
		int y = int( random( getHeight() ) );
		boolean isSource = waterSources.getValue(x, y) > 0;
		if (isSource)
		{
			addDroplet(x, y);
			return true;
		}
		else return false;
	}

	public void addRandomDroplet()
	{
		int x = int( random( getWidth()  ) );
		int y = int( random( getHeight() ) );
		addDroplet(x,y);
	}

	public void addRandomDroplet(int x, int y, int radius)
	{
		int rx = int(random( max(0,x-radius), min(getWidth(),x+radius) ));
		int ry = int(random( max(0,y-radius), min(getHeight(),y+radius) ));
		addDroplet(rx, ry);
	}
}