# Erosion Sim

A simulation inspired by erosion. Created using Processing 3.

## Results (WIP)
![](Outputs/island.png)
![](Outputs/waves.png)

## Running
Execute ErosionSim.pde with `processing-java`.

On linux this is:   
```processing-java --force '--sketch=./' '--output=./out' --run```

### Controls
**n** - Do one simulation step  
**c** - Continue running simulation steps (toggle)  
**r** - Create 1000 additional raindrops    
**p** - Toggle console status messages  
**d** - Toggle display of water droplets over terrain   
**s** - Save the current terrain to `./Outputs`

## TODO
- Add debug window to display information and toggle settings
    - Finish implementing debug views
    - Add gray color scheme for disabled buttons
- Add terrain manipulation tool
- Add water sources
- Make simulation droplets normalize to a set amount with no hard limit
    - Implement droplet count
- Implement terrain resistance map to mimic different materials
- Move settings to config file
- Add a parameter for the number of cycles to run the simulation for
- Add a parameter for the amount of upward slope that droplets can traverse
    - Hopefully will help to keep them from getting stuck
- Add grouping and movement to rain pattern
    - Can I generate a voronoi texture?
- Make speed dependent on the slope droplets travel
    - Speed will affect the amount of sediment they deposit and leave
    - Also use impact speed to determine rainsplash erosion
- Finish or remove gradient filter implementation
    - The intention was to compute the whole image gradient at once, rather than compute the downhill each droplet's neighbors iteratively. But unless droplet density sufficiently increases, it may be faster going by droplet so that no computation is needed for unpopulated image areas.