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

public void btnReload_click(GButton source, GEvent event) { //_CODE_:btnReload:483371:
  println("btnReload - GButton >> GEvent." + event + " @ " + millis());

  // TODO better check for window is open
  if (activeSimulation != null)
  {
    activeSimulation.dispose();
    activeSimulation.frame.setVisible(false);
  }
  startSimulation();

} //_CODE_:btnReload:483371:

public void btnPlay_click(GButton source, GEvent event) { //_CODE_:btnPlay:661167:
  println("btnPlay - GButton >> GEvent." + event + " @ " + millis());
  
  boolean isPlaying = !settingsInstance.running;
  if (isPlaying)
  {
    source.setText("Stop");
    source.setLocalColorScheme(G4P.RED_SCHEME);
    btnReload.setEnabled(false);
    // btnReload.setLocalColorScheme();
  } else {
    source.setText("Play");
    source.setLocalColorScheme(G4P.GREEN_SCHEME);
    btnReload.setEnabled(true);
  }
  
  settingsInstance.running = isPlaying;
  
} //_CODE_:btnPlay:661167:

public void btnSave_click(GButton source, GEvent event) { //_CODE_:btnSave:965615:
  println("btnSave - GButton >> GEvent." + event + " @ " + millis());

  activeSimulation.saveSimulationFrame();

} //_CODE_:btnSave:965615:

public void btnStep_click(GButton source, GEvent event) { //_CODE_:btnStep:679000:
  println("btnStep - GButton >> GEvent." + event + " @ " + millis());

  activeSimulation.doSimulationStep();

} //_CODE_:btnStep:679000:

public void chkWater_clicked(GCheckbox source, GEvent event) { //_CODE_:chkWater:767303:
  println("chkWater - GCheckbox >> GEvent." + event + " @ " + millis());

  settingsInstance.showWater = source.isSelected();

} //_CODE_:chkWater:767303:

public void listDisplayGradients_click(GDropList source, GEvent event) { //_CODE_:listDisplayGradients:261396:
  println("listDisplayGradients - GDropList >> GEvent." + event + " @ " + millis());

  String gradientName = source.getSelectedText();
  settingsInstance.displayGradient = gradientPresets.get(gradientName);

} //_CODE_:listDisplayGradients:261396:

public void sliderErodeSpeed_change(GSlider source, GEvent event) { //_CODE_:sliderErodeSpeed:635420:
  println("sliderErodeSpeed - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.erodeSpeed = source.getValueF();

} //_CODE_:sliderErodeSpeed:635420:

public void sliderDepositSpeed_change(GSlider source, GEvent event) { //_CODE_:sliderDepositSpeed:833393:
  println("sliderDepositSpeed - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.depositSpeed = source.getValueF();

} //_CODE_:sliderDepositSpeed:833393:

public void sliderInitialSpeed_change(GSlider source, GEvent event) { //_CODE_:sliderInitialSpeed:667892:
  println("sliderInitialSpeed - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.initialSpeed = source.getValueF();

} //_CODE_:sliderInitialSpeed:667892:

public void sliderInertia_change(GSlider source, GEvent event) { //_CODE_:sliderInertia:777540:
  println("sliderInertia - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.inertia = source.getValueF();

} //_CODE_:sliderInertia:777540:

public void sliderInitialWater_change(GSlider source, GEvent event) { //_CODE_:sliderInitialWater:899212:
  println("sliderInitialWater - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.initialWater = source.getValueF();

} //_CODE_:sliderInitialWater:899212:

public void sliderEvaporateSpeed_change(GSlider source, GEvent event) { //_CODE_:sliderEvaporateSpeed:898709:
  println("sliderEvaporateSpeed - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.evaporateSpeed = source.getValueF();

} //_CODE_:sliderEvaporateSpeed:898709:

public void sliderDropletLimit_change(GSlider source, GEvent event) { //_CODE_:sliderDropletLimit:631859:
  println("sliderDropletLimit - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.dropletSoftLimit = source.getValueI();

} //_CODE_:sliderDropletLimit:631859:

public void sliderDropletLifetime_change(GSlider source, GEvent event) { //_CODE_:sliderDropletLifetime:273768:
  println("sliderDropletLifetime - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.maxDropletLifetime = source.getValueI();

} //_CODE_:sliderDropletLifetime:273768:

public void btnReset_click(GButton source, GEvent event) { //_CODE_:btnReset:423398:
  println("btnReset - GButton >> GEvent." + event + " @ " + millis());

  setGUIdefaults();

} //_CODE_:btnReset:423398:

public void txtHeightmapPath_change(GTextField source, GEvent event) { //_CODE_:txtHeightmapPath:394852:
  println("txtHeightmapPath - GTextField >> GEvent." + event + " @ " + millis());

  if (event == GEvent.ENTERED || event == GEvent.LOST_FOCUS)
  {
    try
    {
      settingsInstance.setSourceHeightmap( source.getText() );
    } catch (Exception e) { e.printStackTrace(); }
  }

} //_CODE_:txtHeightmapPath:394852:

public void btnHeightmapBrowse_click(GButton source, GEvent event) { //_CODE_:btnHeightmapBrowse:338927:
  println("btnHeightmapBrowse - GButton >> GEvent." + event + " @ " + millis());

  String selected = G4P.selectInput("Source heightmap", "./Heightmaps");
  txtHeightmapPath.setText(selected);
  txtHeightmapPath_change(txtHeightmapPath, GEvent.ENTERED);

} //_CODE_:btnHeightmapBrowse:338927:

public void optMouseTerrain_clicked(GOption source, GEvent event) { //_CODE_:optMouseTerrain:370312:
  println("optMouseTerrain - GOption >> GEvent." + event + " @ " + millis());

  settingsInstance.setMouseMode(MouseMode.HEIGHT);
  loadBrushSettings();

} //_CODE_:optMouseTerrain:370312:

public void optMouseWater_clicked(GOption source, GEvent event) { //_CODE_:optMouseWater:988387:
  println("optMouseWater - GOption >> GEvent." + event + " @ " + millis());

  settingsInstance.setMouseMode(MouseMode.WATERSOURCE);
  loadBrushSettings();

} //_CODE_:optMouseWater:988387:

public void sliderBrushRadius_change(GSlider source, GEvent event) { //_CODE_:sliderBrushRadius:748696:
  println("sliderBrushRadius - GSlider >> GEvent." + event + " @ " + millis());

  settingsInstance.activeBrush.setRadius( source.getValueI() );

} //_CODE_:sliderBrushRadius:748696:

public void sliderBrushHardness_change(GSlider source, GEvent event) { //_CODE_:sliderBrushHardness:774342:
  println("sliderBrushHardness - GSlider >> GEvent." + event + " @ " + millis());

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
  pnlControls = new GPanel(this, 0, 70, 300, 410, "Controls");
  pnlControls.setCollapsible(false);
  pnlControls.setDraggable(false);
  pnlControls.setText("Controls");
  pnlControls.setOpaque(true);
  btnReload = new GButton(this, 10, 30, 60, 30);
  btnReload.setText("Reload");
  btnReload.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  btnReload.addEventHandler(this, "btnReload_click");
  btnPlay = new GButton(this, 80, 30, 60, 30);
  btnPlay.setText("Play");
  btnPlay.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  btnPlay.addEventHandler(this, "btnPlay_click");
  btnSave = new GButton(this, 200, 370, 90, 30);
  btnSave.setText("Save frame");
  btnSave.addEventHandler(this, "btnSave_click");
  btnStep = new GButton(this, 150, 30, 60, 30);
  btnStep.setText("Step");
  btnStep.addEventHandler(this, "btnStep_click");
  chkWater = new GCheckbox(this, 10, 370, 70, 30);
  chkWater.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkWater.setText("Show water");
  chkWater.setOpaque(false);
  chkWater.addEventHandler(this, "chkWater_clicked");
  chkWater.setSelected(true);
  listDisplayGradients = new GDropList(this, 80, 370, 110, 120, 3, 10);
  listDisplayGradients.setItems(loadStrings("list_261396"), 0);
  listDisplayGradients.addEventHandler(this, "listDisplayGradients_click");
  sliderErodeSpeed = new GSlider(this, 10, 270, 140, 40, 10.0);
  sliderErodeSpeed.setShowValue(true);
  sliderErodeSpeed.setLimits(0.01, 0.0, 1.0);
  sliderErodeSpeed.setNumberFormat(G4P.DECIMAL, 2);
  sliderErodeSpeed.setOpaque(false);
  sliderErodeSpeed.addEventHandler(this, "sliderErodeSpeed_change");
  sliderDepositSpeed = new GSlider(this, 150, 270, 140, 40, 10.0);
  sliderDepositSpeed.setShowValue(true);
  sliderDepositSpeed.setLimits(0.01, 0.0, 1.0);
  sliderDepositSpeed.setNumberFormat(G4P.DECIMAL, 2);
  sliderDepositSpeed.setOpaque(false);
  sliderDepositSpeed.addEventHandler(this, "sliderDepositSpeed_change");
  lblErodeSpeed = new GLabel(this, 0, 250, 140, 20);
  lblErodeSpeed.setText("Erode speed");
  lblErodeSpeed.setOpaque(false);
  lblDepositSpeed = new GLabel(this, 150, 250, 140, 20);
  lblDepositSpeed.setText("Deposit speed");
  lblDepositSpeed.setOpaque(false);
  lblInitialSpeed = new GLabel(this, 0, 130, 140, 20);
  lblInitialSpeed.setText("Initial speed");
  lblInitialSpeed.setOpaque(false);
  sliderInitialSpeed = new GSlider(this, 10, 150, 140, 40, 10.0);
  sliderInitialSpeed.setShowValue(true);
  sliderInitialSpeed.setLimits(1.0, 0.01, 10.0);
  sliderInitialSpeed.setNumberFormat(G4P.DECIMAL, 2);
  sliderInitialSpeed.setOpaque(false);
  sliderInitialSpeed.addEventHandler(this, "sliderInitialSpeed_change");
  lblInertia = new GLabel(this, 150, 130, 140, 20);
  lblInertia.setText("Inertia");
  lblInertia.setOpaque(false);
  sliderInertia = new GSlider(this, 150, 150, 140, 40, 10.0);
  sliderInertia.setShowValue(true);
  sliderInertia.setLimits(0.05, 0.0, 1.0);
  sliderInertia.setNumberFormat(G4P.DECIMAL, 2);
  sliderInertia.setOpaque(false);
  sliderInertia.addEventHandler(this, "sliderInertia_change");
  lblInitialWater = new GLabel(this, 0, 190, 150, 20);
  lblInitialWater.setText("Initial water volume");
  lblInitialWater.setOpaque(false);
  sliderInitialWater = new GSlider(this, 10, 210, 140, 40, 10.0);
  sliderInitialWater.setShowValue(true);
  sliderInitialWater.setLimits(0.5, 0.01, 10.0);
  sliderInitialWater.setNumberFormat(G4P.DECIMAL, 2);
  sliderInitialWater.setOpaque(false);
  sliderInitialWater.addEventHandler(this, "sliderInitialWater_change");
  lblEvaporateSpeed = new GLabel(this, 150, 190, 140, 20);
  lblEvaporateSpeed.setText("Evaporate speed");
  lblEvaporateSpeed.setOpaque(false);
  sliderEvaporateSpeed = new GSlider(this, 150, 210, 140, 40, 10.0);
  sliderEvaporateSpeed.setShowValue(true);
  sliderEvaporateSpeed.setLimits(0.05, 0.0, 1.0);
  sliderEvaporateSpeed.setNumberFormat(G4P.DECIMAL, 2);
  sliderEvaporateSpeed.setOpaque(false);
  sliderEvaporateSpeed.addEventHandler(this, "sliderEvaporateSpeed_change");
  lblDropletLimit = new GLabel(this, 0, 70, 140, 20);
  lblDropletLimit.setText("Droplet limit");
  lblDropletLimit.setOpaque(false);
  sliderDropletLimit = new GSlider(this, 10, 90, 140, 40, 10.0);
  sliderDropletLimit.setShowValue(true);
  sliderDropletLimit.setLimits(1, 1, 50000);
  sliderDropletLimit.setNumberFormat(G4P.INTEGER, 0);
  sliderDropletLimit.setOpaque(false);
  sliderDropletLimit.addEventHandler(this, "sliderDropletLimit_change");
  lblDropletLifetime = new GLabel(this, 150, 70, 150, 20);
  lblDropletLifetime.setText("Max droplet lifetime");
  lblDropletLifetime.setOpaque(false);
  sliderDropletLifetime = new GSlider(this, 150, 90, 140, 40, 10.0);
  sliderDropletLifetime.setShowValue(true);
  sliderDropletLifetime.setLimits(50, 1, 100);
  sliderDropletLifetime.setNumberFormat(G4P.INTEGER, 0);
  sliderDropletLifetime.setOpaque(false);
  sliderDropletLifetime.addEventHandler(this, "sliderDropletLifetime_change");
  btnReset = new GButton(this, 220, 30, 70, 30);
  btnReset.setText("Reset");
  btnReset.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  btnReset.addEventHandler(this, "btnReset_click");
  pnlControls.addControl(btnReload);
  pnlControls.addControl(btnPlay);
  pnlControls.addControl(btnSave);
  pnlControls.addControl(btnStep);
  pnlControls.addControl(chkWater);
  pnlControls.addControl(listDisplayGradients);
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
  pnlSourceHeightmap = new GPanel(this, 0, 0, 300, 70, "Source Heightmap");
  pnlSourceHeightmap.setCollapsible(false);
  pnlSourceHeightmap.setDraggable(false);
  pnlSourceHeightmap.setText("Source Heightmap");
  pnlSourceHeightmap.setOpaque(true);
  txtHeightmapPath = new GTextField(this, 10, 30, 210, 30, G4P.SCROLLBARS_NONE);
  txtHeightmapPath.setPromptText("Image path");
  txtHeightmapPath.setOpaque(true);
  txtHeightmapPath.addEventHandler(this, "txtHeightmapPath_change");
  btnHeightmapBrowse = new GButton(this, 230, 30, 60, 30);
  btnHeightmapBrowse.setText("Browse");
  btnHeightmapBrowse.addEventHandler(this, "btnHeightmapBrowse_click");
  pnlSourceHeightmap.addControl(txtHeightmapPath);
  pnlSourceHeightmap.addControl(btnHeightmapBrowse);
  pnlTools = new GPanel(this, 0, 480, 300, 190, "Tools");
  pnlTools.setCollapsible(false);
  pnlTools.setDraggable(false);
  pnlTools.setText("Tools");
  pnlTools.setOpaque(true);
  lblMouseMode = new GLabel(this, 10, 30, 86, 20);
  lblMouseMode.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblMouseMode.setText("Mouse tool");
  lblMouseMode.setOpaque(false);
  togGroupMouseMode = new GToggleGroup();
  optMouseTerrain = new GOption(this, 100, 30, 70, 20);
  optMouseTerrain.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optMouseTerrain.setText("Terrain");
  optMouseTerrain.setOpaque(false);
  optMouseTerrain.addEventHandler(this, "optMouseTerrain_clicked");
  optMouseWater = new GOption(this, 170, 30, 113, 20);
  optMouseWater.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optMouseWater.setText("Water source");
  optMouseWater.setOpaque(false);
  optMouseWater.addEventHandler(this, "optMouseWater_clicked");
  togGroupMouseMode.addControl(optMouseTerrain);
  optMouseTerrain.setSelected(true);
  pnlTools.addControl(optMouseTerrain);
  togGroupMouseMode.addControl(optMouseWater);
  pnlTools.addControl(optMouseWater);
  sliderBrushRadius = new GSlider(this, 10, 80, 140, 40, 10.0);
  sliderBrushRadius.setShowValue(true);
  sliderBrushRadius.setLimits(50, 1, 500);
  sliderBrushRadius.setNbrTicks(300);
  sliderBrushRadius.setNumberFormat(G4P.INTEGER, 0);
  sliderBrushRadius.setOpaque(false);
  sliderBrushRadius.addEventHandler(this, "sliderBrushRadius_change");
  sliderBrushHardness = new GSlider(this, 150, 80, 140, 40, 10.0);
  sliderBrushHardness.setShowValue(true);
  sliderBrushHardness.setLimits(1.0, 0.0, 1.0);
  sliderBrushHardness.setNumberFormat(G4P.DECIMAL, 2);
  sliderBrushHardness.setOpaque(false);
  sliderBrushHardness.addEventHandler(this, "sliderBrushHardness_change");
  lblBrushRadius = new GLabel(this, 10, 60, 140, 20);
  lblBrushRadius.setText("Brush radius");
  lblBrushRadius.setOpaque(false);
  lblBrushHardness = new GLabel(this, 150, 60, 140, 20);
  lblBrushHardness.setText("Brush hardness");
  lblBrushHardness.setOpaque(false);
  pnlTools.addControl(lblMouseMode);
  pnlTools.addControl(sliderBrushRadius);
  pnlTools.addControl(sliderBrushHardness);
  pnlTools.addControl(lblBrushRadius);
  pnlTools.addControl(lblBrushHardness);
  pnlInfo = new GPanel(this, 0, 670, 300, 130, "Debug Info");
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
GButton btnReload; 
GButton btnPlay; 
GButton btnSave; 
GButton btnStep; 
GCheckbox chkWater; 
GDropList listDisplayGradients; 
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
GPanel pnlSourceHeightmap; 
GTextField txtHeightmapPath; 
GButton btnHeightmapBrowse; 
GPanel pnlTools; 
GLabel lblMouseMode; 
GToggleGroup togGroupMouseMode; 
GOption optMouseTerrain; 
GOption optMouseWater; 
GSlider sliderBrushRadius; 
GSlider sliderBrushHardness; 
GLabel lblBrushRadius; 
GLabel lblBrushHardness; 
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
