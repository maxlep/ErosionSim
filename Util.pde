
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
        this.colors = colors;
    }

    color sample(float pct)
    {
        if (pct == 1f) return colors[colors.length - 1];

        float temp = pct * (colors.length - 1);
        int index = floor(temp);
        float decimal = temp - index;

        color c1 = colors[index];
        color c2 = colors[index+1];

        color value = lerpColor(c1, c2, decimal);
        return value;
    }
}