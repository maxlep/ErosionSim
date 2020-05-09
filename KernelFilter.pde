
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
		for (int y=0; y<in.height; y++)
		{
			int i_temp = y * in.width;
			for (int x=0; x<in.width; x++)
			{
				int index = i_temp + x;
				out.pixels[index] = 0;

				int loY = y - radius, loX = x - radius;
				int hiY = y + radius, hiX = x + radius;

				for (int iy=0; iy<size; iy++)
				{
					for (int ix=0; ix<size; ix++)
					{
						int yy = y - radius + iy;
						int xx = x - radius + ix;

						int inValue;
						if (yy < 0 || yy >= in.height ||
							xx < 0 || xx >= in.width)
						{
							inValue = 0; // Value to use for pixels outside the image borders
						} else {
							inValue = in.pixels[yy * in.width + xx];
						}

						float kernelValue = kernel[iy][ix];

						out.pixels[index] += inValue * kernelValue;
					}
				}

				out.pixels[index] = out.pixels[index] / (size * size);
			}
		}

		return out;
	}
}