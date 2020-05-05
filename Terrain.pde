
static class PImageUtils
{
	static int[][] getGrayscaleValues(PImage img)
	{
		int width = img.width;
		int height = img.height;
		int[][] grayscale = new int[height][width];

		img.loadPixels();
		for (int y=0; y<height; y++)
		{
			int i_temp = y * width;
			for (int x=0; x<width; x++)
			{
				grayscale[y][x] = img.pixels[i_temp + x] & 0xFF;
			}
		}
		return grayscale;
	}
}

class Terrain
{
	PImage heightmap;

	Terrain(PImage heightmap)
	{
		this.heightmap = heightmap;
	}

	void draw()
	{
		image(heightmap, 0,0);
	}

	PImage getHeightmap()
	{
		heightmap.loadPixels();
		return heightmap;
	}
	PImage getHeightmapCopy()
	{
		PImage copy = heightmap.copy();
		copy.loadPixels();
		return copy;
	}
	void setHeightmap(int[] heightmap)
	{
		this.heightmap.pixels = heightmap;
		this.heightmap.updatePixels();
		// for (int i=0; i<this.heightmap.pixels.length; i++)
		// {
		// 	if (this.heightmap.pixels[i] != heightmap[i]) println("Heightmap not updated",this.heightmap.pixels[i],heightmap[i]);
		// }
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

	int heightFromColor(int col)
	{
		return col & 0xFF;
	}
	int colorFromHeight(int height)
	{
		return color(height);
	}
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