
class ValueMap
{
    private PImage map;
    private PImage snapshot;
    // The snapshot will be used for reading values, while edits will be applied to the main map.

    public ValueMap(PImage map)
    {
        this.map = map.copy();

        map.loadPixels();
        ColorConverter.grayscaleToValue(map.pixels);
        map.updatePixels();
        // Reorder the values in the input heightmap to allow use of the full 4 bytes for storage of the map value.

        snapshot = map;
        // This makes snapshot and map reference the same object; if makesnapshot() is never called, values will be written and read directly on the map.
    }

    public void draw()
    {
        image(map, 0,0);
    }

    // Loads to heightmap to prepare for reading and modification during one simulation step.
    public void preStep()
    {
        map.loadPixels();
        takeSnapshot();
    }

    public void postStep()
    {
        map.updatePixels();
    }

    public int getValue(int x, int y)
    {
        int index = snapshot.width * y + x;
        return snapshot[index];
    }

    public int setValue(int x, int y, value)
    {
        int index = map.width * y + x;
        map[index] = 
        // TODO if a value exceeds the max or min return the remainder
    }

    // Makes a copy of the heightmap at a moment in time.
    private void takeSnapshot()
    {
        if (snapshot != null) { // Dispose? }

        snapshot = map.copy();
        snapshot.loadPixels();
    }
}