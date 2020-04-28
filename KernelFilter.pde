
class KernelFilter
{
	private int size, radius;
	private float[][] kernel;

	KernelFilter(float[][] values)
	{
		kernel = values;
		size = kernel.length;
		radius = size / 2;
	}
	KernelFilter(int size)
	{
		this(new float[size][size]);
	}

	PImage applyFilter(PImage in)
	{
		PImage out = createImage(in.width, in.height, RGB);
		in.loadPixels();
		out.loadPixels();
		for (int y=0; y<height; y++)
		{
			int i_temp = y * width;
			for (int x=0; x<width; x++)
			{
				out.pixels[i_temp + x] = 0;

				int loY = y - radius, loX = x - radius;
				int hiY = y + radius, hiX = x + radius;

				for (int j=0; j<size; j++)
				{
					for (int i=0; i<size; i++)
					{
						int yy = y - radius + j;
						int xx = x - radius + i;

						int inValue;
						if (yy < 0 || yy > in.height ||
							xx < 0 || xx > in.width)
						{
							inValue = 0; // Value to use for pixels outside the image borders
						} else {
							inValue = in.pixels[yy * in.width + xx];
						}

						float kernelValue = kernel[j][i];

						out.pixels[i_temp + x] += inValue * kernelValue;
					}
				}
			}
		}

		return out;
	}
}