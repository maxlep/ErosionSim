
class Droplet
{
	// PVector pos;
	PVector dir;
	float speed;
	float water;
	int sediment;
	boolean alternatingFlag;
	int age;

	public Droplet(float initialSpeed, float initialWaterVolume)
	{
		// pos = new PVector(0,0);
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

	private ArrayList<Droplet>[][] watermap;
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

		waterSources = new ValueMap(getWidth(), getHeight(), 1);
		watermap = (ArrayList<Droplet>[][]) new ArrayList[getWidth()][getHeight()];
		for (int y=0; y<getHeight(); y++)
		{
			for (int x=0; x<getWidth(); x++)
			{
				watermap[y][x] = new ArrayList<Droplet>();
			}
		}
	}

	public int getWidth() { return data.terrain.getWidth(); }
	public int getHeight() { return data.terrain.getHeight(); }

	public void doSimulationStep()
	{
		int destroyedCount = 0;

		terrain.preStep();

		for (int y=0; y<getHeight(); y++)
		{
			for (int x=0; x<getWidth(); x++)
			{
				destroyedCount += updateDroplets(x, y);
			}
		}

		terrain.postStep();

		nextPassFlag = !nextPassFlag;
		data.dropletCount -= destroyedCount;

		int underTarget = settings.dropletSoftLimit - data.dropletCount;
		for (int i=0; i<underTarget; i++)
			tryAddDropletFromSource();
			// addRandomDroplet();
	}

	private int updateDroplets(int x, int y)
	{
		int destroyedCount = 0;
		ArrayList<Droplet> droplets = watermap[y][x];
		if (droplets.isEmpty()) return destroyedCount;

		// Get the droplets' height and direction of flow
		int height = terrain.getHeightValue(x,y);
		PVector gradient = terrain.getGradient(x,y);

		for (int i=0; i<droplets.size(); i++)
		{
			Droplet d = droplets.get(i);
			if (d.alternatingFlag != nextPassFlag) continue;

			// Update the droplet's direction, and count the number to be processed this step.
			d.dir.x = (d.dir.x * settings.inertia - gradient.x * (1 - settings.inertia) );
			d.dir.y = (d.dir.y * settings.inertia - gradient.y * (1 - settings.inertia) );
			d.dir.normalize();

			// Calculate the index the droplet flows to
			int newX = int(x + d.dir.x);
			int newY = int(y + d.dir.y);

			// Remove the droplet if it's not moving or leaves the map
			if ((newX == x && newY == y) || newX < 0 || newX >= getWidth() || newY < 0 || newY >= getHeight())
			{
				// TODO deposit all sediment
				if (newX == x && newY == y) terrain.addValue(x,y, floor(d.sediment/2));
				droplets.remove(i);
				destroyedCount++;
				i--;
				continue;
			}

			int newHeight = terrain.getHeightValue(newX,newY);
			int deltaHeight = newHeight - height;

			float sedimentCapacity = Math.max( -deltaHeight * d.speed * d.water * settings.sedimentCapacityFactor, settings.minSedimentCapacity );

			// // If flowing uphill or carrying more than capacity deposit some sediment
			if (deltaHeight > 0 || d.sediment > sedimentCapacity)
			{
				float sedimentToDeposit;
				if (deltaHeight > 0)
					sedimentToDeposit = min(deltaHeight, d.sediment);
				else
					sedimentToDeposit = (d.sediment - sedimentCapacity) * settings.depositSpeed;

				int deltaSediment = int(sedimentToDeposit);
				d.sediment -= deltaSediment;
				terrain.addValue(x,y, deltaSediment);
			}
			else	// Otherwise erode and pick up some sediment
			{
				float sedimentToErode = min((sedimentCapacity - d.sediment) * settings.erodeSpeed, -deltaHeight);

				// TODO spread erosion out over a small area
				int deltaSediment = ( height < sedimentToErode ? height : ceil(sedimentToErode) );
				d.sediment += deltaSediment;
				terrain.addValue(x,y, -deltaSediment);
			}

			d.speed = sqrt( d.speed * d.speed + deltaHeight * settings.GRAVITY );
			d.water *= (1 - settings.evaporateSpeed);

			// println(x,y, newX,newY, d.speed,d.dir,d.water,d.sediment);

			// Move droplet to it's next position in the map
			d.alternatingFlag = !d.alternatingFlag;
			droplets.remove(i);
			i--;
			if (++d.age >= settings.maxDropletLifetime)
				destroyedCount++;
			else
				watermap[newY][newX].add(d);
		}

		return destroyedCount;
	}

	public void draw(PGraphics canvas)
	{
		// Debug display
		canvas.fill(0,0,255);
		canvas.noStroke();
		for (int y=0; y<getHeight(); y++)
		{
			for (int x=0; x<getWidth(); x++)
			{
				if (!watermap[y][x].isEmpty())
				{
					canvas.rect(x,y, 1,1);
				}
			}
		}
	}

	public void addDroplet(int x, int y)
	{
		Droplet d = new Droplet(settings.initialSpeed, settings.initialWater);
		watermap[y][x].add(d);
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