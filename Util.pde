
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
		this.colors = colors.clone();
	}

	color sample(float pct)
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

	static boolean pctGT1 = false;
	public static color valueToGradientSample(int value, Gradient g)
	{
		float pct = (float)Integer.toUnsignedLong(value) / Integer.toUnsignedLong(SimulationParameters.MAX_HEIGHT);
		// if (pct > 1f) println(value, pct);
		if (pct > 1f) pctGT1 = true;
		color col = g.sample(pct);
		return col;
	}

	public static void valueToGradientSample(int[] values, Gradient g)
	{
		pctGT1 = false;
		for (int i=0; i<values.length; i++)
		{
			color col = valueToGradientSample(values[i], g);
			values[i] = col;
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