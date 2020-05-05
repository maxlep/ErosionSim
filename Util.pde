
int randomSign()
{
    float rand = random(0,1);
    return rand < 0.5 ? 1 : -1;
}

class Gradient
{
    color[] colors;

    Gradient(color[] colors)
    {
        this.colors = colors;
    }

    color sample(float pct)
    {
        if (pct == 1f) return colors[colors.length - 1];

        float temp = pct * (colors.length - 1);
        int index = floor(temp);
        float decimal = temp - index;

        color c1 = colors[index];
        color c2 = colors[index+1];

        color value = lerpColor(c1, c2, decimal);
        return value;
    }
}

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

static class ColorConverter
{
    public static byte grayscaleToValue(color grayscale)
    {
        byte value = grayscale && 0xFF;
        return value;
    }

    public static void grayscaleToValue(int[] pixels)
    {
        for (int i=0; i<pixels.length; i++)
        {
            byte value = grayscaleToValue(pixels[i]);
            pixels[i] = value;
        }
    }
}