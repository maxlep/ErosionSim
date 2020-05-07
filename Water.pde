
static float SEDIMENT_LIMIT = 100f;

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
	public int width, height;
	private ArrayList<Droplet>[][] watermap;
	private Terrain terrain;
	private SimulationParameters params;
	private boolean nextPassFlag;

	public WaterErosion(Terrain terrain, SimulationParameters params)
	{
		this.terrain = terrain;
		this.params = params;
		width = terrain.getWidth();
		height = terrain.getHeight();
		nextPassFlag = false;

		watermap = (ArrayList<Droplet>[][]) new ArrayList[height][width];
		for (int y=0; y<height; y++)
		{
			for (int x=0; x<width; x++)
			{
				watermap[y][x] = new ArrayList<Droplet>();
			}
		}
	}

	public void doSimulationStep()
	{
		int destroyedCount = 0;
		terrain.preStep();

		// if (print) println("Doing water simulation step");

		for (int y=0; y<height; y++)
		{
			int temp_i = y * width;
			for (int x=0; x<width; x++)
			{
				int i = temp_i + x;
				destroyedCount += updateDroplets(x, y);
			}
		}

		terrain.postStep();

		// if (print) println("Finished water simulation step");

		nextPassFlag = !nextPassFlag;
		global_params.dropletCount -= destroyedCount;
		if (params.autorun)
		{
			int underTarget = global_params.targetDropletCount - global_params.dropletCount;
			for (int i=0; i<underTarget; i++)
				addRandomDroplet();
		}
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

			outHeight = constrain(outHeight, 0, params.MAX_HEIGHT);
			terrain.setHeightValue(x, y, outHeight);
			return destroyedCount;
		}
		ArrayList<Droplet> neighborDroplets = watermap[flowToIndex / width][flowToIndex % width];

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
		if (outValue > params.MAX_HEIGHT)
		{
			sedimentExchange = params.MAX_HEIGHT - inValue;
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
				if (curr.sediment > SEDIMENT_LIMIT)
				{
					curr.sediment = SEDIMENT_LIMIT;
					amount = amount - SEDIMENT_LIMIT;
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
		for (int y=0; y<height; y++)
		{
			for (int x=0; x<width; x++)
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
		global_params.dropletCount++;
	}

	public void addRandomDroplet()
	{
		int x = int(random(this.width));
		int y = int(random(this.height));
		addDroplet(x,y);
	}
	public void addRandomDroplet(int x, int y, int radius)
	{
		int rx = int(random( max(0,x-radius), min(width,x+radius) ));
		int ry = int(random( max(0,y-radius), min(width,y+radius) ));
		addDroplet(rx, ry);
	}
}