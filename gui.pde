/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void btnPlay_click(GButton source, GEvent event) { //_CODE_:btnPlay:661167:
  // println("btnPlay - GButton >> GEvent." + event + " @ " + millis());
  
  boolean isPlaying = !settingsInstance.running;
  if (isPlaying)
  {
    source.setText("Pause");
    source.setLocalColorScheme(G4P.RED_SCHEME);
    //btnReload.setEnabled(false);
    // btnReload.setLocalColorScheme();
  } else {
    source.setText("Play");
    source.setLocalColorScheme(G4P.GREEN_SCHEME);
    //btnReload.setEnabled(true);
  }
  
  settingsInstance.running = isPlaying;
  
} //_CODE_:btnPlay:661167:

public void btnStep_click(GButton source, GEvent event) { //_CODE_:btnStep:679000:
  // println("btnStep - GButton >> GEvent." + event + " @ " + millis());

  activeSimulation.doSimulationStep();

} //_CODE_:btnStep:679000:

public void sliderErodeSpeed_change(GSlider source, GEvent event) { //_CODE_:sliderErodeSpeed:635420:
  // println("sliderErodeSpeed - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.erodeSpeed = source.getValueF();

} //_CODE_:sliderErodeSpeed:635420:

public void sliderDepositSpeed_change(GSlider source, GEvent event) { //_CODE_:sliderDepositSpeed:833393:
  // println("sliderDepositSpeed - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.depositSpeed = source.getValueF();

} //_CODE_:sliderDepositSpeed:833393:

public void sliderInitialSpeed_change(GSlider source, GEvent event) { //_CODE_:sliderInitialSpeed:667892:
  // println("sliderInitialSpeed - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.initialSpeed = source.getValueF();

} //_CODE_:sliderInitialSpeed:667892:

public void sliderInertia_change(GSlider source, GEvent event) { //_CODE_:sliderInertia:777540:
  // println("sliderInertia - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.inertia = source.getValueF();

} //_CODE_:sliderInertia:777540:

public void sliderInitialWater_change(GSlider source, GEvent event) { //_CODE_:sliderInitialWater:899212:
  // println("sliderInitialWater - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.initialWater = source.getValueF();

} //_CODE_:sliderInitialWater:899212:

public void sliderEvaporateSpeed_change(GSlider source, GEvent event) { //_CODE_:sliderEvaporateSpeed:898709:
  // println("sliderEvaporateSpeed - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.evaporateSpeed = source.getValueF();

} //_CODE_:sliderEvaporateSpeed:898709:

public void sliderDropletLimit_change(GSlider source, GEvent event) { //_CODE_:sliderDropletLimit:631859:
  // println("sliderDropletLimit - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.dropletSoftLimit = source.getValueI();

} //_CODE_:sliderDropletLimit:631859:

public void sliderDropletLifetime_change(GSlider source, GEvent event) { //_CODE_:sliderDropletLifetime:273768:
  // println("sliderDropletLifetime - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.maxDropletLifetime = source.getValueI();

} //_CODE_:sliderDropletLifetime:273768:

public void btnReset_click(GButton source, GEvent event) { //_CODE_:btnReset:423398:
  // println("btnReset - GButton >> GEvent." + event + " @ " + millis());

  setErosionSettings( listErosionPresets.getSelectedIndex() );

} //_CODE_:btnReset:423398:

public void listErosionPresets_click(GDropList source, GEvent event) { //_CODE_:listErosionPresets:394470:
  // println("listErosionPresets - GDropList >> GEvent." + event + " @ " + millis());

  setErosionSettings( source.getSelectedIndex() );

} //_CODE_:listErosionPresets:394470:

public void btnHeightmapBrowse_click(GButton source, GEvent event) { //_CODE_:btnHeightmapBrowse:338927:
  // println("btnHeightmapBrowse - GButton >> GEvent." + event + " @ " + millis());

  String selected = G4P.selectInput("Source heightmap", "./Heightmaps");
  try
  {
    settingsInstance.setSourceHeightmap( selected );
  } catch (Exception e) { e.printStackTrace(); }
  btnReload_click(btnReload, GEvent.CLICKED);

} //_CODE_:btnHeightmapBrowse:338927:

public void btnReload_click(GButton source, GEvent event) { //_CODE_:btnReload:587278:
  // println("btnReload2 - GButton >> GEvent." + event + " @ " + millis());
  
  // TODO better check for window is open
  if (activeSimulation != null)
  {
    activeSimulation.dispose();
    activeSimulation.frame.setVisible(false);
  }
  startSimulation();
  
} //_CODE_:btnReload:587278:

public void chkWater_clicked(GCheckbox source, GEvent event) { //_CODE_:chkWater:982245:
  // println("chkWater2 - GCheckbox >> GEvent." + event + " @ " + millis());
  
  settingsInstance.showWater = source.isSelected();
  
} //_CODE_:chkWater:982245:

public void listDisplayGradients_click(GDropList source, GEvent event) { //_CODE_:listDisplayGradients:960364:
  // println("listDisplayGradients2 - GDropList >> GEvent." + event + " @ " + millis());
  
  String gradientName = source.getSelectedText();
  settingsInstance.displayGradient = gradientPresets.get(gradientName);
  
} //_CODE_:listDisplayGradients:960364:

public void btnSaveImage_click(GButton source, GEvent event) { //_CODE_:btnSaveImage:435836:
  // println("btnSave2 - GButton >> GEvent." + event + " @ " + millis());
  
  activeSimulation.saveSimulationFrame();
  
} //_CODE_:btnSaveImage:435836:

public void knobDisplayScale_turn(GKnob source, GEvent event) { //_CODE_:knobDisplayScale:796179:
  // println("knobDisplayScale - GKnob >> GEvent." + event + " @ " + millis());
  
  settingsInstance.displayScale = source.getValueI();
  settingsInstance.displayScaleChanged = true;
  
} //_CODE_:knobDisplayScale:796179:

public void btnSaveHeightmap_click(GButton source, GEvent event) { //_CODE_:btnSaveHeightmap:270944:
  // println("btnSaveHeightmap - GButton >> GEvent." + event + " @ " + millis());

  activeSimulation.saveHeightmap();

} //_CODE_:btnSaveHeightmap:270944:

public void optMouseTerrain_clicked(GOption source, GEvent event) { //_CODE_:optMouseTerrain:370312:
  // println("optMouseTerrain - GOption >> GEvent." + event + " @ " + millis());

  settingsInstance.setMouseMode(MouseMode.HEIGHT);
  loadBrushSettings();

} //_CODE_:optMouseTerrain:370312:

public void optMouseWater_clicked(GOption source, GEvent event) { //_CODE_:optMouseWater:988387:
  // println("optMouseWater - GOption >> GEvent." + event + " @ " + millis());

  settingsInstance.setMouseMode(MouseMode.WATERSOURCE);
  loadBrushSettings();

} //_CODE_:optMouseWater:988387:

public void sliderBrushRadius_change(GSlider source, GEvent event) { //_CODE_:sliderBrushRadius:748696:
  // println("sliderBrushRadius - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.activeBrush.setRadius( source.getValueI() );

} //_CODE_:sliderBrushRadius:748696:

public void sliderBrushHardness_change(GSlider source, GEvent event) { //_CODE_:sliderBrushHardness:774342:
  // println("sliderBrushHardness - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.activeBrush.setHardness( source.getValueF() );

} //_CODE_:sliderBrushHardness:774342:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.CYAN_SCHEME);
  G4P.setMouseOverEnabled(false);
  GButton.useRoundCorners(false);
  G4P.setDisplayFont("Lucida Sans", G4P.PLAIN, 14);
  G4P.setInputFont("Arial", G4P.PLAIN, 14);
  G4P.setSliderFont("Arial", G4P.PLAIN, 11);
  surface.setTitle("Settings");
  pnlControls = new GPanel(this, 0, 150, 300, 370, "Controls");
  pnlControls.setCollapsible(false);
  pnlControls.setDraggable(false);
  pnlControls.setText("Controls");
  pnlControls.setOpaque(true);
  btnPlay = new GButton(this, 160, 30, 120, 50);
  btnPlay.setText("Play");
  btnPlay.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  btnPlay.addEventHandler(this, "btnPlay_click");
  btnStep = new GButton(this, 160, 80, 120, 30);
  btnStep.setText("Step");
  btnStep.addEventHandler(this, "btnStep_click");
  sliderErodeSpeed = new GSlider(this, 10, 320, 140, 40, 10.0);
  sliderErodeSpeed.setShowValue(true);
  sliderErodeSpeed.setLimits(0.01, 0.01, 1.0);
  sliderErodeSpeed.setNumberFormat(G4P.DECIMAL, 2);
  sliderErodeSpeed.setOpaque(false);
  sliderErodeSpeed.addEventHandler(this, "sliderErodeSpeed_change");
  sliderDepositSpeed = new GSlider(this, 150, 320, 140, 40, 10.0);
  sliderDepositSpeed.setShowValue(true);
  sliderDepositSpeed.setLimits(0.01, 0.01, 1.0);
  sliderDepositSpeed.setNumberFormat(G4P.DECIMAL, 2);
  sliderDepositSpeed.setOpaque(false);
  sliderDepositSpeed.addEventHandler(this, "sliderDepositSpeed_change");
  lblErodeSpeed = new GLabel(this, 10, 300, 140, 20);
  lblErodeSpeed.setText("Erode strength");
  lblErodeSpeed.setOpaque(false);
  lblDepositSpeed = new GLabel(this, 150, 300, 140, 20);
  lblDepositSpeed.setText("Deposit strength");
  lblDepositSpeed.setOpaque(false);
  lblInitialSpeed = new GLabel(this, 10, 180, 140, 20);
  lblInitialSpeed.setText("Initial speed");
  lblInitialSpeed.setOpaque(false);
  sliderInitialSpeed = new GSlider(this, 10, 200, 140, 40, 10.0);
  sliderInitialSpeed.setShowValue(true);
  sliderInitialSpeed.setLimits(1.0, 0.01, 10.0);
  sliderInitialSpeed.setNumberFormat(G4P.DECIMAL, 2);
  sliderInitialSpeed.setOpaque(false);
  sliderInitialSpeed.addEventHandler(this, "sliderInitialSpeed_change");
  lblInertia = new GLabel(this, 150, 180, 140, 20);
  lblInertia.setText("Inertia");
  lblInertia.setOpaque(false);
  sliderInertia = new GSlider(this, 150, 200, 140, 40, 10.0);
  sliderInertia.setShowValue(true);
  sliderInertia.setLimits(0.05, 0.01, 0.99);
  sliderInertia.setNumberFormat(G4P.DECIMAL, 2);
  sliderInertia.setOpaque(false);
  sliderInertia.addEventHandler(this, "sliderInertia_change");
  lblInitialWater = new GLabel(this, 10, 240, 140, 20);
  lblInitialWater.setText("Droplet volume");
  lblInitialWater.setOpaque(false);
  sliderInitialWater = new GSlider(this, 10, 260, 140, 40, 10.0);
  sliderInitialWater.setShowValue(true);
  sliderInitialWater.setLimits(0.5, 0.01, 10.0);
  sliderInitialWater.setNumberFormat(G4P.DECIMAL, 2);
  sliderInitialWater.setOpaque(false);
  sliderInitialWater.addEventHandler(this, "sliderInitialWater_change");
  lblEvaporateSpeed = new GLabel(this, 150, 240, 140, 20);
  lblEvaporateSpeed.setText("Evaporate speed");
  lblEvaporateSpeed.setOpaque(false);
  sliderEvaporateSpeed = new GSlider(this, 150, 260, 140, 40, 10.0);
  sliderEvaporateSpeed.setShowValue(true);
  sliderEvaporateSpeed.setLimits(0.05, 0.01, 1.0);
  sliderEvaporateSpeed.setNumberFormat(G4P.DECIMAL, 2);
  sliderEvaporateSpeed.setOpaque(false);
  sliderEvaporateSpeed.addEventHandler(this, "sliderEvaporateSpeed_change");
  lblDropletLimit = new GLabel(this, 10, 120, 140, 20);
  lblDropletLimit.setText("Dropet count");
  lblDropletLimit.setOpaque(false);
  sliderDropletLimit = new GSlider(this, 10, 140, 140, 40, 10.0);
  sliderDropletLimit.setShowValue(true);
  sliderDropletLimit.setLimits(1, 1, 50000);
  sliderDropletLimit.setNumberFormat(G4P.INTEGER, 0);
  sliderDropletLimit.setOpaque(false);
  sliderDropletLimit.addEventHandler(this, "sliderDropletLimit_change");
  lblDropletLifetime = new GLabel(this, 150, 120, 150, 20);
  lblDropletLifetime.setText("Max droplet lifetime");
  lblDropletLifetime.setOpaque(false);
  sliderDropletLifetime = new GSlider(this, 150, 140, 140, 40, 10.0);
  sliderDropletLifetime.setShowValue(true);
  sliderDropletLifetime.setLimits(50, 1, 100);
  sliderDropletLifetime.setNumberFormat(G4P.INTEGER, 0);
  sliderDropletLifetime.setOpaque(false);
  sliderDropletLifetime.addEventHandler(this, "sliderDropletLifetime_change");
  btnReset = new GButton(this, 20, 80, 120, 30);
  btnReset.setText("Reload preset");
  btnReset.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  btnReset.addEventHandler(this, "btnReset_click");
  listErosionPresets = new GDropList(this, 20, 50, 120, 220, 10, 20);
  listErosionPresets.setItems(loadStrings("list_394470"), 0);
  listErosionPresets.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  listErosionPresets.addEventHandler(this, "listErosionPresets_click");
  lblErosionPresets = new GLabel(this, 10, 30, 130, 20);
  lblErosionPresets.setText("Erosion presets");
  lblErosionPresets.setOpaque(false);
  pnlControls.addControl(btnPlay);
  pnlControls.addControl(btnStep);
  pnlControls.addControl(sliderErodeSpeed);
  pnlControls.addControl(sliderDepositSpeed);
  pnlControls.addControl(lblErodeSpeed);
  pnlControls.addControl(lblDepositSpeed);
  pnlControls.addControl(lblInitialSpeed);
  pnlControls.addControl(sliderInitialSpeed);
  pnlControls.addControl(lblInertia);
  pnlControls.addControl(sliderInertia);
  pnlControls.addControl(lblInitialWater);
  pnlControls.addControl(sliderInitialWater);
  pnlControls.addControl(lblEvaporateSpeed);
  pnlControls.addControl(sliderEvaporateSpeed);
  pnlControls.addControl(lblDropletLimit);
  pnlControls.addControl(sliderDropletLimit);
  pnlControls.addControl(lblDropletLifetime);
  pnlControls.addControl(sliderDropletLifetime);
  pnlControls.addControl(btnReset);
  pnlControls.addControl(listErosionPresets);
  pnlControls.addControl(lblErosionPresets);
  pnlSourceHeightmap = new GPanel(this, 0, 0, 300, 150, "Display settings");
  pnlSourceHeightmap.setCollapsible(false);
  pnlSourceHeightmap.setDraggable(false);
  pnlSourceHeightmap.setText("Display settings");
  pnlSourceHeightmap.setOpaque(true);
  btnHeightmapBrowse = new GButton(this, 10, 30, 80, 30);
  btnHeightmapBrowse.setText("Load map");
  btnHeightmapBrowse.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  btnHeightmapBrowse.addEventHandler(this, "btnHeightmapBrowse_click");
  btnReload = new GButton(this, 100, 30, 60, 30);
  btnReload.setText("Reload");
  btnReload.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  btnReload.addEventHandler(this, "btnReload_click");
  chkWater = new GCheckbox(this, 170, 120, 120, 20);
  chkWater.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkWater.setText("Show droplets");
  chkWater.setOpaque(false);
  chkWater.addEventHandler(this, "chkWater_clicked");
  chkWater.setSelected(true);
  listDisplayGradients = new GDropList(this, 180, 50, 110, 220, 10, 20);
  listDisplayGradients.setItems(loadStrings("list_960364"), 0);
  listDisplayGradients.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  listDisplayGradients.addEventHandler(this, "listDisplayGradients_click");
  btnSaveImage = new GButton(this, 10, 110, 150, 30);
  btnSaveImage.setText("Save image");
  btnSaveImage.addEventHandler(this, "btnSaveImage_click");
  knobDisplayScale = new GKnob(this, 240, 80, 40, 40, 0.8);
  knobDisplayScale.setTurnRange(180, 0);
  knobDisplayScale.setTurnMode(GKnob.CTRL_HORIZONTAL);
  knobDisplayScale.setSensitivity(1);
  knobDisplayScale.setShowArcOnly(false);
  knobDisplayScale.setOverArcOnly(true);
  knobDisplayScale.setIncludeOverBezel(false);
  knobDisplayScale.setShowTrack(true);
  knobDisplayScale.setLimits(1.0, 1.0, 4.0);
  knobDisplayScale.setNbrTicks(4);
  knobDisplayScale.setStickToTicks(true);
  knobDisplayScale.setShowTicks(true);
  knobDisplayScale.setOpaque(false);
  knobDisplayScale.addEventHandler(this, "knobDisplayScale_turn");
  lblDisplayScale = new GLabel(this, 180, 90, 60, 20);
  lblDisplayScale.setText("Scaling");
  lblDisplayScale.setOpaque(false);
  lblDisplayGradient = new GLabel(this, 170, 30, 130, 20);
  lblDisplayGradient.setText("Display gradient");
  lblDisplayGradient.setOpaque(false);
  btnSaveHeightmap = new GButton(this, 10, 70, 150, 30);
  btnSaveHeightmap.setText("Save heightmap");
  btnSaveHeightmap.addEventHandler(this, "btnSaveHeightmap_click");
  pnlSourceHeightmap.addControl(btnHeightmapBrowse);
  pnlSourceHeightmap.addControl(btnReload);
  pnlSourceHeightmap.addControl(chkWater);
  pnlSourceHeightmap.addControl(listDisplayGradients);
  pnlSourceHeightmap.addControl(btnSaveImage);
  pnlSourceHeightmap.addControl(knobDisplayScale);
  pnlSourceHeightmap.addControl(lblDisplayScale);
  pnlSourceHeightmap.addControl(lblDisplayGradient);
  pnlSourceHeightmap.addControl(btnSaveHeightmap);
  pnlTools = new GPanel(this, 0, 520, 300, 170, "Tools");
  pnlTools.setCollapsible(false);
  pnlTools.setDraggable(false);
  pnlTools.setText("Tools");
  pnlTools.setOpaque(true);
  lblMouseMode = new GLabel(this, 10, 30, 90, 20);
  lblMouseMode.setText("Mouse tool");
  lblMouseMode.setOpaque(false);
  togGroupMouseMode = new GToggleGroup();
  optMouseTerrain = new GOption(this, 20, 50, 114, 20);
  optMouseTerrain.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optMouseTerrain.setText("Terrain");
  optMouseTerrain.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  optMouseTerrain.setOpaque(true);
  optMouseTerrain.addEventHandler(this, "optMouseTerrain_clicked");
  optMouseWater = new GOption(this, 20, 70, 114, 20);
  optMouseWater.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optMouseWater.setText("Water source");
  optMouseWater.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  optMouseWater.setOpaque(true);
  optMouseWater.addEventHandler(this, "optMouseWater_clicked");
  togGroupMouseMode.addControl(optMouseTerrain);
  optMouseTerrain.setSelected(true);
  pnlTools.addControl(optMouseTerrain);
  togGroupMouseMode.addControl(optMouseWater);
  pnlTools.addControl(optMouseWater);
  sliderBrushRadius = new GSlider(this, 150, 50, 140, 40, 10.0);
  sliderBrushRadius.setShowValue(true);
  sliderBrushRadius.setLimits(50, 1, 500);
  sliderBrushRadius.setNbrTicks(300);
  sliderBrushRadius.setNumberFormat(G4P.INTEGER, 0);
  sliderBrushRadius.setOpaque(false);
  sliderBrushRadius.addEventHandler(this, "sliderBrushRadius_change");
  sliderBrushHardness = new GSlider(this, 150, 120, 140, 40, 10.0);
  sliderBrushHardness.setShowValue(true);
  sliderBrushHardness.setLimits(1.0, 0.01, 1.0);
  sliderBrushHardness.setNumberFormat(G4P.DECIMAL, 2);
  sliderBrushHardness.setOpaque(false);
  sliderBrushHardness.addEventHandler(this, "sliderBrushHardness_change");
  lblBrushRadius = new GLabel(this, 150, 30, 140, 20);
  lblBrushRadius.setText("Brush radius");
  lblBrushRadius.setOpaque(false);
  lblBrushHardness = new GLabel(this, 150, 100, 140, 20);
  lblBrushHardness.setText("Brush hardness");
  lblBrushHardness.setOpaque(false);
  lblMouseDescription1 = new GLabel(this, 10, 100, 120, 20);
  lblMouseDescription1.setText("LClick to Add");
  lblMouseDescription1.setOpaque(false);
  lblMouseDescription2 = new GLabel(this, 10, 120, 120, 20);
  lblMouseDescription2.setText("RClick to Erase");
  lblMouseDescription2.setOpaque(false);
  lblMouseDescription3 = new GLabel(this, 10, 140, 120, 20);
  lblMouseDescription3.setText("Scroll to Resize");
  lblMouseDescription3.setOpaque(false);
  pnlTools.addControl(lblMouseMode);
  pnlTools.addControl(sliderBrushRadius);
  pnlTools.addControl(sliderBrushHardness);
  pnlTools.addControl(lblBrushRadius);
  pnlTools.addControl(lblBrushHardness);
  pnlTools.addControl(lblMouseDescription1);
  pnlTools.addControl(lblMouseDescription2);
  pnlTools.addControl(lblMouseDescription3);
  pnlInfo = new GPanel(this, 0, 690, 300, 110, "Debug Info");
  pnlInfo.setCollapsible(false);
  pnlInfo.setDraggable(false);
  pnlInfo.setText("Debug Info");
  pnlInfo.setOpaque(true);
  lblDropletCount = new GLabel(this, 0, 40, 70, 20);
  lblDropletCount.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblDropletCount.setText("Droplets:");
  lblDropletCount.setOpaque(false);
  valDropletCount = new GLabel(this, 70, 40, 60, 20);
  valDropletCount.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  valDropletCount.setText("#");
  valDropletCount.setOpaque(false);
  lblStepCount = new GLabel(this, 0, 20, 70, 20);
  lblStepCount.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblStepCount.setText("Steps:");
  lblStepCount.setOpaque(false);
  valStepCount = new GLabel(this, 70, 20, 60, 20);
  valStepCount.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  valStepCount.setText("#");
  valStepCount.setOpaque(false);
  lblStepRate = new GLabel(this, 130, 20, 80, 20);
  lblStepRate.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblStepRate.setText("Steps/sec:");
  lblStepRate.setOpaque(false);
  valStepRate = new GLabel(this, 210, 20, 60, 20);
  valStepRate.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  valStepRate.setText("#");
  valStepRate.setOpaque(false);
  lblMousePos = new GLabel(this, 0, 60, 70, 20);
  lblMousePos.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblMousePos.setText("Mouse:");
  lblMousePos.setOpaque(false);
  valMousePos = new GLabel(this, 70, 60, 80, 20);
  valMousePos.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  valMousePos.setText("#,#");
  valMousePos.setOpaque(false);
  lblHeight = new GLabel(this, 150, 60, 60, 20);
  lblHeight.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblHeight.setText("Height:");
  lblHeight.setOpaque(false);
  valHeight = new GLabel(this, 210, 60, 60, 20);
  valHeight.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  valHeight.setText("#");
  valHeight.setOpaque(false);
  lblGradient = new GLabel(this, 0, 80, 70, 20);
  lblGradient.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  lblGradient.setText("Gradient:");
  lblGradient.setOpaque(false);
  valGradient = new GLabel(this, 70, 80, 100, 20);
  valGradient.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  valGradient.setText("#,#");
  valGradient.setOpaque(false);
  pnlInfo.addControl(lblDropletCount);
  pnlInfo.addControl(valDropletCount);
  pnlInfo.addControl(lblStepCount);
  pnlInfo.addControl(valStepCount);
  pnlInfo.addControl(lblStepRate);
  pnlInfo.addControl(valStepRate);
  pnlInfo.addControl(lblMousePos);
  pnlInfo.addControl(valMousePos);
  pnlInfo.addControl(lblHeight);
  pnlInfo.addControl(valHeight);
  pnlInfo.addControl(lblGradient);
  pnlInfo.addControl(valGradient);
}

// Variable declarations 
// autogenerated do not edit
GPanel pnlControls; 
GButton btnPlay; 
GButton btnStep; 
GSlider sliderErodeSpeed; 
GSlider sliderDepositSpeed; 
GLabel lblErodeSpeed; 
GLabel lblDepositSpeed; 
GLabel lblInitialSpeed; 
GSlider sliderInitialSpeed; 
GLabel lblInertia; 
GSlider sliderInertia; 
GLabel lblInitialWater; 
GSlider sliderInitialWater; 
GLabel lblEvaporateSpeed; 
GSlider sliderEvaporateSpeed; 
GLabel lblDropletLimit; 
GSlider sliderDropletLimit; 
GLabel lblDropletLifetime; 
GSlider sliderDropletLifetime; 
GButton btnReset; 
GDropList listErosionPresets; 
GLabel lblErosionPresets; 
GPanel pnlSourceHeightmap; 
GButton btnHeightmapBrowse; 
GButton btnReload; 
GCheckbox chkWater; 
GDropList listDisplayGradients; 
GButton btnSaveImage; 
GKnob knobDisplayScale; 
GLabel lblDisplayScale; 
GLabel lblDisplayGradient; 
GButton btnSaveHeightmap; 
GPanel pnlTools; 
GLabel lblMouseMode; 
GToggleGroup togGroupMouseMode; 
GOption optMouseTerrain; 
GOption optMouseWater; 
GSlider sliderBrushRadius; 
GSlider sliderBrushHardness; 
GLabel lblBrushRadius; 
GLabel lblBrushHardness; 
GLabel lblMouseDescription1; 
GLabel lblMouseDescription2; 
GLabel lblMouseDescription3; 
GPanel pnlInfo; 
GLabel lblDropletCount; 
GLabel valDropletCount; 
GLabel lblStepCount; 
GLabel valStepCount; 
GLabel lblStepRate; 
GLabel valStepRate; 
GLabel lblMousePos; 
GLabel valMousePos; 
GLabel lblHeight; 
GLabel valHeight; 
GLabel lblGradient; 
GLabel valGradient; 
