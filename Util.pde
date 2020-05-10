
int randomSign()
{
	float rand = random(0,1);
	return rand < 0.5 ? 1 : -1;
}

class Nullable<T>
{
	private T data;
	private boolean isNull;

	public Nullable(T data)
	{
		this.data = data;
		isNull = false;
	}

	public T getValue()
	{
		return isNull ? null : data;
	}

	public void setNull()
	{
		isNull = true;
	}

	public T getData()
	{
		isNull = false;
		return data;
	}
}

class Gradient
{
	private color[] colors;

	public Gradient(color[] colors)
	{
		this.colors = colors.clone();
	}

	public color sample(float pct)
	{
		if (pct >= 1f) return colors[colors.length - 1];

		float temp = pct * (colors.length - 1);
		int index = floor(temp);
		float decimal = temp - index;

		color c1 = colors[index];
		color c2 = colors[index+1];

		color value = lerpColor(c1, c2, decimal);
		return value;
	}
}

static class ColorConverter
{
	public static int grayscaleToValue(color grayscale)
	{
		int value = grayscale & 0xFF;
		return value;
	}

	public static void grayscaleToValue(int[] pixels)
	{
		for (int i=0; i<pixels.length; i++)
		{
			int value = grayscaleToValue(pixels[i]);
			pixels[i] = value;
		}
	}

	public static float colorToValue(color col)
	{
		int r = col >> 16 & 0xFF;
		int g = col >> 8 & 0xFF;
		int b = col  & 0xFF;
		// TODO rgb color to grayscale value
		float average = (r + g + b) / 3;
		return average;
	}

	public static void colorToValue(int[] pixels, float[] outArray)
	{
		for (int i=0; i<pixels.length; i++)
		{
			outArray[i] = colorToValue(pixels[i]);
		}
	}

	static boolean pctGT1 = false;
	public static color valueToGradientSample(float value, float valueMax, Gradient g)
	{
		float pct = value / valueMax;
		// if (pct > 1f) println(value, pct);
		if (pct > 1f) pctGT1 = true;
		color col = g.sample(pct);
		return col;
	}

	public static void valueToGradientImage(int[] out, float[] values, float valueMax, Gradient g)
	{
		pctGT1 = false;
		for (int i=0; i<values.length; i++)
		{
			color col = valueToGradientSample(values[i], valueMax, g);
			out[i] = col;
		}
		if (pctGT1) println("Some values are above MAX_HEIGHT");
	}
}

static final void setDefaultClosePolicy(PApplet pa, boolean keepOpen)
{
	final Object surf = pa.getSurface().getNative();
	final PGraphics canvas = pa.getGraphics();

	if (canvas.isGL()) {
		final com.jogamp.newt.Window w = (com.jogamp.newt.Window) surf;

		for (com.jogamp.newt.event.WindowListener wl : w.getWindowListeners())
			if (wl.toString().startsWith("processing.opengl.PSurfaceJOGL"))
				w.removeWindowListener(wl); 

		w.setDefaultCloseOperation(keepOpen ?
			com.jogamp.nativewindow.WindowClosingProtocol.WindowClosingMode
			.DO_NOTHING_ON_CLOSE :
			com.jogamp.nativewindow.WindowClosingProtocol.WindowClosingMode
			.DISPOSE_ON_CLOSE);
	} else if (canvas instanceof processing.awt.PGraphicsJava2D) {
		final javax.swing.JFrame f = (javax.swing.JFrame)
		((processing.awt.PSurfaceAWT.SmoothCanvas) surf).getFrame(); 

		for (java.awt.event.WindowListener wl : f.getWindowListeners())
			if (wl.toString().startsWith("processing.awt.PSurfaceAWT"))
				f.removeWindowListener(wl);

		f.setDefaultCloseOperation(keepOpen ?
			f.DO_NOTHING_ON_CLOSE : f.DISPOSE_ON_CLOSE);
	}
}