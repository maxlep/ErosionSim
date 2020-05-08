
class ValueMap
{
    public int height, width;

    private PImage map;
    private PImage snapshot;
    // The snapshot will be used for reading values, while edits will be applied to the map.

    public ValueMap(PImage map)
    {
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
        ColorConverter.valueToGradientSample(colored.pixels, g);
        colored.updatePixels();
        return colored;
    }

    public void setValue(int x, int y, int value)
    {
        int index = map.width * y + x;
        map.pixels[index] = value;
    }

    // Makes a copy of the heightmap at a moment in time.
    private void takeSnapshot()
    {
        if (snapshot != null) { /* Dispose? */ }

        snapshot = map.copy();
        snapshot.loadPixels();
    }
}