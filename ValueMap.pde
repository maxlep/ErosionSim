
class ValueMap
{
	public int height, width;

	private int maxValue;
	private PImage map;
	private PImage snapshot;
	// The snapshot will be used for reading values, while edits will be applied to the map.

	public ValueMap(PImage map, int maxValue)
	{
		this.maxValue = maxValue;
		this.height = map.height;
		this.width = map.width;
		this.map = map.copy();

		this.map.loadPixels();
		ColorConverter.grayscaleToValue(this.map.pixels);
		this.map.updatePixels();
		// Reorder the values in the input heightmap to allow use of the full 4 bytes for storage of the map value.

		snapshot = this.map;
		// This makes snapshot and map reference the same object; if makesnapshot() is never called, values will be written and read directly on the map.
	}
	public ValueMap(int width, int height, int maxValue)
	{
		this(createImage(width, height, RGB), maxValue);
	}

	public void draw(PGraphics canvas, Gradient displayGradient)
	{
		PImage colored = getValuesOnGradient(displayGradient);
		canvas.image(colored, 0,0);
	}

	public void preStep()
	{
		map.loadPixels();
		takeSnapshot();
	}

	public void postStep()
	{
		map.updatePixels();
	}

	public int getValue(int index)
	{
		return snapshot.pixels[index];
	}

	public int getValue(int x, int y)
	{
		int index = snapshot.width * y + x;
		return getValue(index);
	}

	public PImage getValues()
	{
		// TODO make not reliant on the PImage type
		map.loadPixels();
		return map.copy();
	}

	public PImage[] getGradients()
	{
		return new PImage[] { sobelX.applyFilter(snapshot), sobelY.applyFilter(snapshot) };
	}

	private KernelFilter sobelX = sobelEdgeVertical();
	private KernelFilter sobelY = sobelEdgeHorizontal();
	public PVector getGradient(int x, int y)
	{
		return new PVector( sobelX.applyFilter(snapshot, x,y), sobelY.applyFilter(snapshot, x,y) );
	}

	public PImage getValuesOnGradient(Gradient g)
	{
		PImage colored = getValues();
		colored.loadPixels();
		ColorConverter.valueToGradientSample(colored.pixels, maxValue, g);
		colored.updatePixels();
		return colored;
	}

	public void setValue(int x, int y, int value)
	{
		int index = map.width * y + x;
		map.pixels[index] = value;
	}

	public void applyBrush(int x, int y, ValueBrush brush, boolean erase)
	{
		// loadPixels();
		int x0 = x - brush.getRadius();
		int y0 = y - brush.getRadius();
		for (int iy=0; iy<brush.getSize(); iy++)
		{
			int yy = y0 + iy;
			if (yy < 0 || yy >= height) continue;
			for (int ix=0; ix<brush.getSize(); ix++)
			{
				int xx = x0 + ix;
				if (xx < 0 || xx >= width) continue;

				float brushEffect = brush.getMaskValue(ix, iy);
				int sign = erase ? -1 : 1;

				int i = yy * width + xx;
				map.pixels[i] += brushEffect * sign;
				map.pixels[i] = constrain(map.pixels[i], 0,maxValue);
			}
		}
		// updatePixels();
	}

	// Makes a copy of the heightmap at a moment in time.
	private void takeSnapshot()
	{
		if (snapshot != null) { /* Dispose? */ }

		snapshot = map.copy();
		snapshot.loadPixels();
	}
}

class ValueBrush
{
	private int radius;
	private int size;
	private float hardness;
	private int value;
	private int[][] brushMask;

	public ValueBrush(int radius, float hardness, int value)
	{
		this.radius = radius;
		this.size = 2 * radius + 1;
		this.hardness = hardness;
		this.value = value;
		brushMask = new int[size][size];
		recalculateMask();
	}

	public int getRadius() { return radius; }
	public int getSize() { return size; }
	public float getHardness() { return hardness; }
	public int getValue() { return value; }

	public void setRadius(int radius)
	{
		this.radius = radius;
		this.size = 2 * radius + 1;

		brushMask = new int[size][size];
		recalculateMask();
	}

	public void setHardness(float hardness)
	{
		this.hardness = hardness;
		recalculateMask();
	}

	public void setMultiplier(int value)
	{
		this.value = value;
		recalculateMask();
	}

	public int getMaskValue(int x, int y)
	{
		return brushMask[y][x];
	}

	private void recalculateMask()
	{
		int sqrRadius = radius * radius;
		PVector center = new PVector(radius, radius);
		
		for (int y=0; y<size; y++)
		{
			for (int x=0; x<2*radius; x++)
			{
				double sqrDistance = Math.pow(x - center.x, 2) + Math.pow(y - center.y, 2);
				if (sqrDistance <= sqrRadius)
				{
					float pct = (float)sqrDistance / sqrRadius;
					float brushEffect = 1 - (float)Math.pow(pct, hardness * 10);

					brushMask[y][x] = (int)(value * brushEffect);
				}
			}
		}
	}
}