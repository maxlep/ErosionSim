
import java.util.Arrays;

class ValueMap
{
	public int height, width;

	private float maxValue;
	private float[] map;
	private float[] snapshot;
	// The snapshot will be used for reading values, while edits will be applied to the map.

	public ValueMap(PImage sourceMap, float maxValue)
	{
		this.maxValue = maxValue;
		this.height = sourceMap.height;
		this.width = sourceMap.width;

		// Copy the values from the map image and convert them to floats
		sourceMap.loadPixels();
		this.map = new float[height*width];
		ColorConverter.colorToValue(sourceMap.pixels, this.map);

		// This makes snapshot and map reference the same object; if makesnapshot() is never called, values will be written and read directly on the map.
		snapshot = this.map;
	}

	public ValueMap(int width, int height, int maxValue)
	{
		this(createImage(width, height, RGB), maxValue);
	}

	public void draw(PGraphics canvas, Gradient displayGradient)
	{
		PImage colored = toGradientImage(displayGradient);
		canvas.image(colored, 0,0);
	}

	public void preStep()
	{
		takeSnapshot();
	}

	public void postStep()
	{

	}

	public void setValue(int x, int y, float value)
	{
		int index = width * y + x;
		map[index] = value;
	}
	public void addValue(int index, float value)
	{
		float current = map[index];
		map[index] = constrain(current + value, 0, maxValue);
	}
	public void addValue(int x, int y, float value)
	{
		int index = width * y + x;
		addValue(index, value);
	}

	public float getValue(int index)
	{
		return snapshot[index];
	}
	public float getValue(int x, int y)
	{
		int index = width * y + x;
		return getValue(index);
	}
	public float[] getValues()
	{
		return Arrays.copyOf(map, map.length);
	}

	public PVector getSurfaceGradient(float x, float y)
	{
		PVector gradient = new PVector();

		int gridX = int(x);
		int gridY = int(y);
		if (gridX == 0 || gridX == width-1 || gridY == 0 || gridY == height-1) return gradient;

		int index = gridY * width + gridX;
		int indexSE = index;

		float heightNW = snapshot[indexSE - width - 1];
		float heightNE = snapshot[indexSE - width];
		float heightSW = snapshot[indexSE - 1];
		float heightSE = snapshot[indexSE];

		float cellX = x - gridX;
		float cellY = y - gridY;
		gradient.x = -( (heightNE - heightNW) * (1 - cellY) + (heightSE - heightSW) * cellY );
		gradient.y = -( (heightSW - heightNW) * (1 - cellX) + (heightSE - heightNE) * cellX );
		return gradient;
	}

	public PImage toGradientImage(Gradient g)
	{
		PImage colored = createImage(width,height, RGB);
		colored.loadPixels();
		ColorConverter.valueToGradientImage(colored.pixels, map, maxValue, g);
		colored.updatePixels();
		return colored;
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
				map[i] += brushEffect * sign;
				map[i] = constrain(map[i], 0,maxValue);
			}
		}
		// updatePixels();
	}

	// Makes a copy of the heightmap at a moment in time.
	private void takeSnapshot()
	{
		if (snapshot == null) snapshot = new float[map.length];

		System.arraycopy(map,0, snapshot,0, map.length);
	}
}

class ValueBrush
{
	private int radius;
	private int size;
	private float hardness;
	private int value;
	private float[][] brushMask;

	public ValueBrush(int radius, float hardness, int value)
	{
		this.radius = radius;
		this.size = 2 * radius + 1;
		this.hardness = hardness;
		this.value = value;
		brushMask = new float[size][size];
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

		brushMask = new float[size][size];
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

	public float getMaskValue(int x, int y)
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

					brushMask[y][x] = value * brushEffect;
				}
			}
		}
	}
}