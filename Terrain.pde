
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

	int getHeight() { return heightmap.height; };
	int getWidth()  { return heightmap.width;  };

	PImage getGradient()
	{
		// TODO
		return null;
	}
}