
class Terrain
{
	public ValueMap heightmap;
	public Nullable<PVector>[][] gradient;

	public int getHeight() { return heightmap.height; };
	public int getWidth()  { return heightmap.width;  };

	public Terrain(PImage heightmapImg)
	{
		heightmap = new ValueMap(heightmapImg, SimulationSettings.MAX_HEIGHT);

		gradient = (Nullable<PVector>[][])new Nullable[getHeight()][getWidth()];
		for (int y=0; y<getHeight(); y++)
		{
			for (int x=0; x<getWidth(); x++)
			{
				gradient[y][x] = new Nullable<PVector>(new PVector(0,0));
			}
		}
	}

	public void draw(PGraphics canvas, Gradient displayGradient)
	{
		heightmap.draw(canvas, displayGradient);
	}

	public void preStep()
	{
		heightmap.preStep();
		// gradients = heightmap.getGradients();
		resetGradientsCache();
	}

	public void postStep()
	{
		heightmap.postStep();
	}

	public float getHeightValue(int x, int y) { return heightmap.getValue(x, y); }
	public void setHeightValue(int x, int y, float value) {
		heightmap.setValue(x, y, value);
		// TODO return remainder if value exceeds max or min
	}

	public void addValue(int x, int y, float value)
	{
		heightmap.addValue(x,y, value);
	}

	// Relies on heightmap.loadPixels previously being called
	public int getDownhillNeighborIndex(int x, int y)
	{
		int myIndex = y * heightmap.width + x;
		float myValue = heightmap.getValue(x, y);

		int lowestNeighborIndex = myIndex;
		float lowestNeighborValue = myValue;

		int signJ = randomSign();
		int signI = randomSign();
		// for (int j=-1*signJ; j!=signJ; j+=signJ)
		for (int j=-1; j<=1; j++)
		{
			int yy = y + j;
			if (yy < 0 || yy >= heightmap.height) continue;
			// for (int i=-1*signI; i!=signI; i+=signI)
			for (int i=-1; i<=1; i++)
			{
				if (x == 0 && y == 0) continue;
				int xx = x + i;
				if (xx < 0 || xx >= heightmap.width) continue;

				int neighborIndex = yy * heightmap.width + xx;
				// if (neighborIndex >= heightmap.pixels.length) println(x, y);
				float neighborValue = heightmap.getValue(neighborIndex);
				if (neighborValue <= lowestNeighborValue)
				{
					lowestNeighborIndex = neighborIndex;
					lowestNeighborValue = neighborValue;
				}

				// println("value",myValue,"neighbor",neighborValue);
			}
		}
		// println("Height",myValue,"Lowest neighbor",lowestNeighborValue,"Neighbor index",lowestNeighborIndex);

		if (lowestNeighborIndex == myIndex) return -1;
		else return lowestNeighborIndex;
	}

	public PVector getSurfaceGradient(int x, int y)
	{
		PVector val = gradient[y][x].getValue();
		if (val != null) return val;
		
		PVector g = heightmap.getSurfaceGradient(x, y);
		PVector data = gradient[y][x].getData();
		// data.x = -heightmap.getGradientX(x, y);
		// data.y = -heightmap.getGradientY(x, y);
		data.x = g.x;
		data.y = g.y;
		// int flowIndex = getDownhillNeighborIndex(x,y);
		// if (flowIndex == -1)
		// {
		// 	data.x = 0;
		// 	data.y = 0;
		// }
		// else
		// {
		// 	int flowX = flowIndex % getWidth();
		// 	int flowY = flowIndex / getWidth();
		// 	data.x = x - flowX;
		// 	data.y = y - flowY;
		// }
		return data;
	}

	public PImage toGradientImage(Gradient g)
	{
		PImage colored = heightmap.toGradientImage(g);
		return colored;
	}

	private void resetGradientsCache()
	{
		for (int y=0; y<getHeight(); y++)
		{
			for (int x=0; x<getWidth(); x++)
			{
				gradient[y][x].setNull();
			}
		}
	}
}