
public KernelFilter sobelEdgeVertical()
{
	float[][] kernel = { {1,0,-1}, {2,0,-2}, {1,0,-1} };
	return new KernelFilter(kernel);
}
public KernelFilter sobelEdgeHorizontal()
{
	float[][] kernel = { {1,2,1}, {0,0,0}, {-1,-2,-1} };
	return new KernelFilter(kernel);
}
private PImage combineGradients(PImage horz, PImage vert)
{
	return null;
}