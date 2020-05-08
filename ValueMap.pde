
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
		int sqrRadius = brush.radius * brush.radius;
		for (int yy=y-brush.radius; yy<y+brush.radius; yy++)
		{
			if (yy < 0 || yy >= height) continue;
			for (int xx=x-brush.radius; xx<x+brush.radius; xx++)
			{
				if (xx < 0 || xx >= width) continue;

				double sqrDistance = Math.pow(xx - x, 2) + Math.pow(yy - y, 2);
				if (sqrDistance <= sqrRadius)
				{
					int i = yy * width + xx;
					float pct = (float)sqrDistance / sqrRadius;
					float brushEffect = 1 - (float)Math.pow(pct, brush.hardness * 10);
					int sign = erase ? -1 : 1;
					map.pixels[i] += brush.value * brushEffect * sign;
					map.pixels[i] = constrain(map.pixels[i], 0,maxValue);
				}
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
	public int radius;
	public float hardness;
	public int value;

	public ValueBrush(int radius, float hardness, int value)
	{
		this.radius = radius;
		this.hardness = hardness;
		this.value = value;
	}
}