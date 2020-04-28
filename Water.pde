
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

class WaterMap
{
	int width, height;
	ArrayList<Droplet>[][] watermap;
	Terrain terrain;
	boolean nextPassFlag;
	private int simulationStep = 1;

	WaterMap(Terrain terrain)
	{
		this.terrain = terrain;
		width = terrain.getWidth();
		height = terrain.getHeight();
		watermap = (ArrayList<Droplet>[][]) new ArrayList[height][width];
		for (int y=0; y<height; y++)
		{
			for (int x=0; x<width; x++)
			{
				watermap[y][x] = new ArrayList<Droplet>();
			}
		}
		nextPassFlag = false;
	}

	// Returns the number of droplets destroyed in this step
	int doSimulationStep()
	{
		int destroyedCount = 0;
		println("----------");
		println("Doing simulation step "+(simulationStep));

		PImage inHeightmap  = terrain.getHeightmap();
		PImage outHeightmap = terrain.getHeightmapCopy();

		for (int y=0; y<height; y++)
		{
			int temp_i = y * width;
			for (int x=0; x<width; x++)
			{
				int i = temp_i + x;

				ArrayList<Droplet> droplets = watermap[y][x];
				if (droplets.isEmpty()) continue;

				int flowToIndex = terrain.getDownhillNeighborIndex(x,y);
				// println(flowToIndex);
				if (flowToIndex == -1)
				{
					// no neighbor is lower than this is. evaporate water and deposit all sediment
					int outValue = terrain.heightFromColor(inHeightmap.pixels[i]);
					for (Droplet d : droplets)
					{
						outValue += d.sediment;
						destroyedCount++;
					}
					droplets.clear();
					outValue = constrain(outValue, 0, 255);
					outHeightmap.pixels[i] = outValue;
					// println("No lower neighbor");
					continue;
				}
				ArrayList<Droplet> neighborDroplets = watermap[flowToIndex / width][flowToIndex % width];

				int size = 0;
				for (Droplet d : droplets)
				{
					size += (d.alternatingFlag == nextPassFlag ? 1 : 0);
				}
				if (size < 1)
				{
					continue;
				}

				// println("Size ",size," Index ",i,"Flow to index",flowToIndex);

				// TODO when speed is low they deposit sediment, when speed is higher they accumulate it
				float rand = random(-1, 10);
				if (rand > 1) rand = 1;
				int sedimentExchange = round(rand);

				int inValue = terrain.heightFromColor(inHeightmap.pixels[temp_i + x]);
				int outValue = inValue + sedimentExchange;
				if (outValue < 0)
				{
					sedimentExchange = inValue;
				}
				if (outValue > 255)
				{
					sedimentExchange = 255 - inValue;
				}
				outValue = inValue;

				float each = sedimentExchange / size;
				// println("Exchanging",sedimentExchange,"sediment between ground",inValue,"and",size,"droplets,",each,"each");
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
				
				outHeightmap.pixels[temp_i + x] = terrain.colorFromHeight(outValue);
			}
		}

		terrain.setHeightmap(outHeightmap.pixels);
		nextPassFlag = !nextPassFlag;

		println("Finished simulation step "+simulationStep++);
		return destroyedCount;
	}

	void draw()
	{
		// Debug display
		for (int y=0; y<height; y++)
		{
			for (int x=0; x<width; x++)
			{
				if (!watermap[y][x].isEmpty())
				{
					rect(x,y, 1,1);
				}
			}
		}
	}

	void addDroplet(int x, int y)
	{
		Droplet d = new Droplet();
		watermap[y][x].add(d);
	}

	void addRandomDroplet()
	{
		int x = int(random(width));
		int y = int(random(height));
		addDroplet(x,y);
	}
}