
class Terrain
{
	public ValueMap heightmap;

	public Terrain(PImage heightmapImg)
	{
		this.heightmap = new ValueMap(heightmapImg);
	}

	public void draw()
	{
		heightmap.draw();
	}

	public void prepForStep()
	{
		heightmap.prepForStep();
	}

	public void postStep()
	{
		heightmap.postStep();
	}

	// Relies on heightmap.loadPixels previously being called
	int getDownhillNeighborIndex(int x, int y)
	{
		int myIndex = y * heightmap.width + x;
		// if (myIndex >= heightmap.pixels.length) println(x, y);
		int myValue = heightFromColor(heightmap.pixels[myIndex]);
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
				int neighborValue = heightFromColor(heightmap.pixels[neighborIndex]);
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

	int getHeight() { return heightmap.height; };
	int getWidth()  { return heightmap.width;  };
	
	PImage getColorBlend(color c1, color c2)
	{
		PImage copy = heightmap.copy();
		copy.loadPixels();
		for (int i=0; i<copy.pixels.length; i++)
		{
			int height = copy.pixels[i] & 0xFF;
			float pct = float(height) / 255f;
			copy.pixels[i] = lerpColor(c1, c2, pct);
		}
		return copy;
	}
	PImage getColorBlend(color[] colors)
	{
		Gradient g = new Gradient(colors);

		PImage copy = heightmap.copy();
		copy.loadPixels();

		for (int i=0; i<copy.pixels.length; i++)
		{
			int height = copy.pixels[i] & 0xFF;
			float pct = float(height) / 255f;
			color col = g.sample(pct);

			copy.pixels[i] = col;
		}

		return copy;
	}

	PImage getGradient()
	{
		// TODO
		return null;
	}
}