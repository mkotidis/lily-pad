/*********************************************************
                  Main Window! 

Click the "Run" button to Run the simulation.

Change the geometry, flow conditions, numercial parameters
 visualizations and measurments from this window. 

*********************************************************/
InlineFoilTest test;
SaveData dat;
float maxT;
String datapath = "saved/";
  
void setup() {
  int Re = 6000, nflaps = 1;
  float stru = .45, stk = -135*PI/180, hc = 1, dAoA = 25*PI/180, uAoA = 0;
  int resolution = 32, xLengths=7, yLengths=7, xStart = 3, zoom = 3;
  maxT = (int)(2*hc/stru*resolution*nflaps);

  test = new InlineFoilTest(resolution, xLengths, yLengths, xStart, zoom, Re, true);
  test.setFlapParams(stru, stk, dAoA, uAoA, hc, "Sine");
  size(600,600);
  dat = new SaveData(datapath+"pressure.txt", test.foil.coords, resolution, xLengths, yLengths, zoom);
}
void draw() {
  test.update();
  test.display();
  dat.addData(test.t, test.foil.pressForce(test.flow.p), test.foil, test.flow.p);

  if (test.t>=maxT) {
    dat.finish();
    exit();
  }
}
void keyPressed() {
  dat.finish();
  exit();
}