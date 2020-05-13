# Erosion Sim

A simulation inspired by erosion. Created using Processing 3.

## Results (WIP)
![](Outputs/basic_gradient.png)
![](Outputs/islands.png)
![](Outputs/crumbling.png)


## Running
Execute ErosionSim.pde with `processing-java`.

On linux this is:   
```processing-java --force '--sketch=./' '--output=./out' --run```

### Controls
- GUI

## TODO
- Add some better default maps to demo the features
- Change GUI labels to be easier to interpret
    - Does G4P support tooltips?
    - Update window title
    - Update readme with full feature explanation
- Add erosion settings presets
- Show preview of display gradient
- Begin with the simulation in an understandable state
- Test mouse brush on trackpad
- Remove GUI debug prints
- Add gray color scheme for disabled buttons

# Stretch goals
- Add gradient editor
- Fix directional bias on flat ground
- Implement terrain resistance map to mimic different materials
- Remember settings window position
- Add grouping and movement to rain pattern