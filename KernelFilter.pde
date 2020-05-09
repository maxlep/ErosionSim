
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

	public PImage applyFilter(PImage in)
	{
		PImage out = createImage(in.width, in.height, RGB);
		in.loadPixels();
		out.loadPixels();
		for (int y=0; y<in.height; y++)
		{
			int i_temp = y * in.width;
			for (int x=0; x<in.width; x++)
			{
				out.pixels[i_temp + x] = (int)applyFilter(in, x, y);
			}
		}

		return out;
	}

	public float applyFilter(PImage in, int x, int y)
	{
		float outValue = 0;

		int loY = y - radius;
		int loX = x - radius;
		for (int iy=0; iy<size; iy++)
		{
			for (int ix=0; ix<size; ix++)
			{
				int yy = loY + iy;
				int xx = loX + ix;

				int inValue;
				if (yy < 0 || yy >= in.height ||
					xx < 0 || xx >= in.width)
				{
					inValue = 0; // Value to use for pixels outside the image borders
				} else {
					inValue = in.pixels[yy * in.width + xx];
				}

				float kernelValue = kernel[iy][ix];

				outValue += inValue * kernelValue;
			}
		}

		outValue = outValue / (size * size);
		return outValue;
	}
}