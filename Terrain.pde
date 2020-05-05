
class Terrain
{
	public ValueMap heightmap;

	public int getHeight() { return heightmap.height; };
	public int getWidth()  { return heightmap.width;  };

	public Terrain(PImage heightmapImg)
	{
		this.heightmap = new ValueMap(heightmapImg);
	}

	public void draw()
	{
		heightmap.draw();
	}

	public void preStep()
	{
		heightmap.preStep();
		// recomputeGradient();
	}

	public void postStep()
	{
		heightmap.postStep();
	}

	public int getHeightValue(int x, int y) { return heightmap.getValue(x, y); }
	public void setHeightValue(int x, int y, int value) {
		heightmap.setValue(x, y, value);
		if (print) println("Set value",x,y,value);
		// TODO return remainder if value exceeds max or min
	}

	// private void recomputeGradient()
	// {
		
	// }

	// Relies on heightmap.loadPixels previously being called
	int getDownhillNeighborIndex(int x, int y)
	{
		int myIndex = y * heightmap.width + x;
		int myValue = heightmap.getValue(x, y);

		int lowestNeighborIndex = myIndex;
		int lowestNeighborValue = myValue;

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
				int neighborValue = heightmap.getValue(neighborIndex);
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

	PImage getColorBlend(color[] colors)
	{
		Gradient g = new Gradient(colors);

		PImage heights = heightmap.getValues();

		heights.loadPixels();
		ColorConverter.valueToGradientSample(heights.pixels, g);
		heights.updatePixels();

		return heights;
	}
}