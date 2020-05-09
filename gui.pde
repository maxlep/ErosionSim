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
  pnlControls = new GPanel(this, 0, 70, 300, 150, "Controls");
  pnlControls.setCollapsible(false);
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
  btnSave = new GButton(this, 200, 80, 90, 30);
  btnSave.setText("Save frame");
  btnSave.addEventHandler(this, "btnSave_click");
  btnStep = new GButton(this, 150, 30, 60, 30);
  btnStep.setText("Step");
  btnStep.addEventHandler(this, "btnStep_click");
  chkWater = new GCheckbox(this, 220, 30, 70, 30);
  chkWater.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  chkWater.setText("Show water");
  chkWater.setOpaque(false);
  chkWater.addEventHandler(this, "chkWater_clicked");
  chkWater.setSelected(true);
  listDisplayGradients = new GDropList(this, 10, 80, 180, 120, 3, 10);
  listDisplayGradients.setItems(loadStrings("list_261396"), 0);
  listDisplayGradients.addEventHandler(this, "listDisplayGradients_click");
  pnlControls.addControl(btnReload);
  pnlControls.addControl(btnPlay);
  pnlControls.addControl(btnSave);
  pnlControls.addControl(btnStep);
  pnlControls.addControl(chkWater);
  pnlControls.addControl(listDisplayGradients);
  pnlSourceHeightmap = new GPanel(this, 0, 0, 300, 70, "Source Heightmap");
  pnlSourceHeightmap.setCollapsible(false);
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
  pnlTools = new GPanel(this, 0, 220, 300, 190, "Tools");
  pnlTools.setCollapsible(false);
  pnlTools.setText("Tools");
  pnlTools.setOpaque(true);
  lblMouseMode = new GLabel(this, 10, 30, 86, 20);
  lblMouseMode.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblMouseMode.setText("Mouse tool");
  lblMouseMode.setOpaque(false);
  togGroupMouseMode = new GToggleGroup();
  optMouseTerrain = new GOption(this, 10, 50, 70, 20);
  optMouseTerrain.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optMouseTerrain.setText("Terrain");
  optMouseTerrain.setOpaque(false);
  optMouseTerrain.addEventHandler(this, "optMouseTerrain_clicked");
  optMouseWater = new GOption(this, 90, 50, 113, 20);
  optMouseWater.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  optMouseWater.setText("Water source");
  optMouseWater.setOpaque(false);
  optMouseWater.addEventHandler(this, "optMouseWater_clicked");
  togGroupMouseMode.addControl(optMouseTerrain);
  optMouseTerrain.setSelected(true);
  pnlTools.addControl(optMouseTerrain);
  togGroupMouseMode.addControl(optMouseWater);
  pnlTools.addControl(optMouseWater);
  sliderBrushRadius = new GSlider(this, 10, 80, 280, 50, 10.0);
  sliderBrushRadius.setShowValue(true);
  sliderBrushRadius.setLimits(50, 1, 500);
  sliderBrushRadius.setNbrTicks(300);
  sliderBrushRadius.setStickToTicks(true);
  sliderBrushRadius.setNumberFormat(G4P.INTEGER, 0);
  sliderBrushRadius.setOpaque(false);
  sliderBrushRadius.addEventHandler(this, "sliderBrushRadius_change");
  sliderBrushHardness = new GSlider(this, 10, 120, 280, 50, 10.0);
  sliderBrushHardness.setShowValue(true);
  sliderBrushHardness.setLimits(1.0, 0.0, 1.0);
  sliderBrushHardness.setNumberFormat(G4P.DECIMAL, 2);
  sliderBrushHardness.setOpaque(false);
  sliderBrushHardness.addEventHandler(this, "sliderBrushHardness_change");
  pnlTools.addControl(lblMouseMode);
  pnlTools.addControl(sliderBrushRadius);
  pnlTools.addControl(sliderBrushHardness);
  pnlInfo = new GPanel(this, 0, 410, 300, 90, "Debug Info");
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
