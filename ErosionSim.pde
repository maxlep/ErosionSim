import gab.opencv.*;

Terrain terrain;
WaterMap water;

void setup()
{
	size(530,530);
	noStroke();
	fill(0,0,255);

	PImage heightmap = loadImage("heightmap01.png");
	terrain = new Terrain(heightmap);
	water = new WaterMap(terrain);

	water.addDroplet(20, 70);
}

void draw()
{
	pushMatrix();
	scale(4);
	terrain.draw();
	water.draw();
	popMatrix();
}