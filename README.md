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
- Refactor heightmap to use float values
    - This will hopefully prevent drops getting stuck in discrete holes
- Implement terrain resistance map to mimic different materials
- Add gray color scheme for disabled buttons
- Remember settings window position
- Add a parameter for the number of cycles to run the simulation for
- Add grouping and movement to rain pattern
    - Can I generate a voronoi texture?