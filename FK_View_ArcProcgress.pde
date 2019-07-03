public class FK_ArcProgressObject {

  public float value;
  public float percent;
  public float start;
  public float stop;
  public color colour;

  public FK_ArcProgressObject(float value, color colour) {
    this.value   = value;
    this.percent = radians(value);
    this.colour  = colour;
  }
}

public class FK_ArcProgressView extends FK_View {

  private ArrayList<FK_ArcProgressObject> arcs = new ArrayList<FK_ArcProgressObject>();
  private color centerColor = color(0); // center arc color (the arc over the progressess)
  private float centerOffset = 120;
  private float startBound = -180; // from -180 degree
  private float stopBound; // to 0 degree

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  public float getCenterOffset() {
    return this.centerOffset;
  }

  public void setBound(float from, float to) {
    startBound = from;
    stopBound  = to;
    refresh();
  }

  public void setCenterColor(color c) {
    centerColor = c;
  }

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  public void clearArcs() {
    arcs.clear();
    refresh();
  }

  public void addArc(FK_ArcProgressObject progress) {
    if (progress == null) return;
    arcs.add(progress);
    refresh();
  }

  // refresh some values depends on new arc progresses
  private void refresh() {
    int arcCount    = arcs.size();
    float sumOfVals = 0;
    for (FK_ArcProgressObject arc : arcs) {
      sumOfVals += arc.value;
    }
    float lastStart = startBound;
    for (int i = 0; i < arcCount; i++) {
      FK_ArcProgressObject p = arcs.get(i);
      p.percent    = map(p.value, 0, sumOfVals, 0, 100);
      float mapped = map(p.percent, 0, 100, 0, 180) * -1;
      if (i == 0) {
        p.start = lastStart;
      } else {
        p.start = lastStart - mapped;
      }
      lastStart = p.start;
    }
    for (int i = 0; i < arcCount; i++) {
      FK_ArcProgressObject p = arcs.get(i);
      if (i + 1 < arcCount) {
        p.stop = arcs.get(i + 1).start;
      } else {
        p.stop = stopBound;
      }
    }
    for (FK_ArcProgressObject p : arcs) {
      p.start = radians(p.start);
      p.stop  = radians(p.stop);
    }
  }

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  public FK_ArcProgressView(PApplet applet) {
    super(applet);
    w = 700;
    h = 550;
  }

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  protected void drawer() {
    applet.noStroke();
    
    // draw arcs
    for (FK_ArcProgressObject arc : arcs) {
      applet.fill(arc.colour);
      applet.arc(this.x, this.y, this.w, this.h, arc.start, arc.stop);
    }

    // draw a full arc (circle) in center of all
    applet.fill(centerColor);
    applet.arc(this.x, this.y, this.w - centerOffset, this.h - centerOffset, radians(startBound), radians(stopBound));
  }
}
