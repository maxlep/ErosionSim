
class Droplet
{
	int speed;
	float sediment;
	boolean alternatingFlag;

	public Droplet()
	{
		speed = 0;
		sediment = 0;
		alternatingFlag = false;
	}
}

class WaterErosion
{
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

		watermap = (ArrayList<Droplet>[][]) new ArrayList[getWidth()][getHeight()];
		for (int y=0; y<getHeight(); y++)
		{
			for (int x=0; x<getWidth(); x++)
			{
				watermap[y][x] = new ArrayList<Droplet>();
			}
		}

		println(getWidth(), getHeight());
	}

	public int getWidth() { return settings.getWidth(); }
	public int getHeight() { return settings.getHeight(); }

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
			addRandomDroplet();
	}

	private int updateDroplets(int x, int y)
	{
		int destroyedCount = 0;
		ArrayList<Droplet> droplets = watermap[y][x];
		if (droplets.isEmpty()) return destroyedCount;

		// Step 1: Determine flow direction
		int flowToIndex = terrain.getDownhillNeighborIndex(x,y);
		if (flowToIndex == -1)	// No neighbor is lower than this is. Evaporate water and deposit all sediment.
		{
			int outHeight = terrain.getHeightValue(x, y);

			for (Droplet d : droplets)
			{
				outHeight += d.sediment;
				destroyedCount++;
			}
			droplets.clear();

			outHeight = constrain(outHeight, 0, SimulationSettings.MAX_HEIGHT);
			terrain.setHeightValue(x, y, outHeight);
			return destroyedCount;
		}
		ArrayList<Droplet> neighborDroplets = watermap[flowToIndex / getWidth()][flowToIndex % getWidth()];

		// Step 2: Count the number of droplets that have not yet been updated this step
		int size = 0;
		for (Droplet d : droplets)
		{
			size += (d.alternatingFlag == nextPassFlag ? 1 : 0);
		}
		if (size < 1)
		{
			return destroyedCount;
		}

		// Step 3: Determine the amount of sediment to exchange
		// TODO when speed is low they deposit sediment, when speed is higher they accumulate it
		float rand = random(-1, 3);
		if (rand > 1) rand = 1;
		int sedimentExchange = round(rand);

		int inValue = terrain.getHeightValue(x, y);
		int outValue = inValue + sedimentExchange;
		if (outValue < 0)
		{
			sedimentExchange = inValue;
		}
		if (outValue > SimulationSettings.MAX_HEIGHT)
		{
			sedimentExchange = SimulationSettings.MAX_HEIGHT - inValue;
		}
		outValue = inValue;
		float each = sedimentExchange / size;

		// Step 4: Exchange the values from each droplet and move them along in their flow direction
		for (int d=0; d<droplets.size(); d++)
		{
			Droplet curr = droplets.get(d);
			if (curr.alternatingFlag == nextPassFlag)
			{
				float amount = curr.sediment;
				curr.sediment -= each;
				if (curr.sediment < 0)
				{
					curr.sediment = 0;
				}
				if (curr.sediment > settings.SEDIMENT_LIMIT)
				{
					curr.sediment = settings.SEDIMENT_LIMIT;
					amount = amount - settings.SEDIMENT_LIMIT;
				}
				outValue += amount;
				curr.alternatingFlag = !curr.alternatingFlag;
				neighborDroplets.add(curr);
				droplets.remove(curr);
				d--;
			}
		}
		
		// Step 5: Update the height value of this cell
		terrain.setHeightValue(x, y, outValue);

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
		Droplet d = new Droplet();
		watermap[y][x].add(d);
		data.dropletCount++;
	}

	public void addRandomDroplet()
	{
		int x = int(random( getWidth() ));
		int y = int(random( getHeight() ));
		addDroplet(x,y);
	}
	public void addRandomDroplet(int x, int y, int radius)
	{
		int rx = int(random( max(0,x-radius), min(getWidth(),x+radius) ));
		int ry = int(random( max(0,y-radius), min(getHeight(),y+radius) ));
		addDroplet(rx, ry);
	}
}