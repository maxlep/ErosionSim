
class Droplet
{
	int speed;
	float sediment;

	public Droplet()
	{
		speed = 0;
		sediment = 0;
	}
}

class WaterMap
{
	int width, height;
	ArrayList<Droplet>[][] watermap;
	Terrain terrain;

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
}