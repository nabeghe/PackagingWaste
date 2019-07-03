public interface FK_TriangleBeforeDrawPercent {
  void onBefore(PApplet applet);
}

public class FK_TriangleMountain {

  public float x1;
  public float x2;
  public float x3;

  public float y1;
  public float y2;
  public float y3;

  public float percent;

  public float value;
  public color colour;

  public String iconPath;
  public PImage icon;

  public FK_TriangleMountain(float value, color colour) {
    this.value   = value;
    this.colour  = colour;
  }

  public FK_TriangleMountain(float value, color colour, String iconPath) {
    this.value    = value;
    this.colour   = colour;
    this.iconPath = iconPath;
    icon = loadImage(iconPath);
    icon.resize(40, 40);
  }
}

public class FK_TriangularMountainProgress extends FK_View {

  private float left;
  private float right;
  private float centerX;
  private float top;
  private float bottom;

  private int triangleCount;

  private FK_TriangleBeforeDrawPercent beforeDrawPercentListener;

  public void setBeforeDrawPercentListener(FK_TriangleBeforeDrawPercent value) {
    beforeDrawPercentListener = value;
  }

  private ArrayList<FK_TriangleMountain> triangles = new ArrayList<FK_TriangleMountain>();

  public void setBounds(float left, float right, float top, float bottom) {
    this.left    = left;
    this.right   = right;
    this.centerX = (right - left) / 2;
    this.top     = top;
    this.bottom  = bottom;
    this.w       = abs(right)  - abs(left);
    this.h       = abs(bottom) - abs(top);
    this.refresh();
  }

  public void setLocation(float x, float y) {
    super.setLocation(x, y);
    this.autoBounds();
    this.refresh();
  }

  public void setSize(float w, float h) {
    super.setSize(w, h);
    this.autoBounds();
    this.refresh();
  }

  private void autoBounds() {
    this.left    = this.x - this.w/2;
    this.right   = this.x + this.w/2;
    this.centerX = this.x;
    this.top     = this.y - this.h/2;
    this.bottom  = this.y;
  }

  public void clearTriangles() {
    this.triangles.clear();
    this.refresh();
  }

  public void addTriangle(FK_TriangleMountain triangle) {
    if (triangle.value <= 0) return;
    this.triangles.add(triangle);
    this.refresh();
  }

  private void refresh() {
    float triangleCount = this.triangles.size(); // gereftane tedade mosalas ha
    if (triangleCount == 0) return; // age hich mosalasi nabud bikhial

    float sumOfVals = 0; // majmue meqdare kole mosalas ha
    for (FK_TriangleMountain triangle : triangles) {
      sumOfVals += triangle.value;
    }

    /* Sorting: bozorgtarha balatar */
    ArrayList<FK_TriangleMountain> tempTriangles = new ArrayList<FK_TriangleMountain>();
    for (int i = 0; i < triangleCount; i++) {
      FK_TriangleMountain triangle = triangles.get(i);
      int tempSize = tempTriangles.size();
      boolean added    = false;
      for (int j = 0; j < tempSize; j++) {
        FK_TriangleMountain triangle2 = tempTriangles.get(j);
        if (triangle.value >= triangle2.value) {
          tempTriangles.add(j, triangle);
          added = true;
          break;
        }
      }
      if (!added) {
        tempTriangles.add(triangle);
      }
    }
    triangles.clear();
    for (int i = 0; i < triangleCount; i++) {
      triangles.add(tempTriangles.get(i));
    }

    /* Locations: */
    float partStep = (this.right - this.left) / (triangleCount * 2);
    partStep += ((triangleCount - 1) * partStep) / triangleCount;
    FloatList possibleCenters = new FloatList();
    FloatList removedPossibleCenters = new FloatList();
    possibleCenters.append(this.centerX);
    for (int i = 0; i < triangleCount; i++) {
      FK_TriangleMountain triangle = triangles.get(i);
      triangle.percent             = map(triangle.value, 0, sumOfVals, 0, 100);

      triangle.y1 = this.bottom;
      triangle.y2 = map(triangle.percent, 0, 100, this.bottom, this.top);
      triangle.y3 = this.bottom;

      int randomCenterIndex = 0; // int(random(0, possibleCenters.size()))
      float randomCenter = possibleCenters.get(randomCenterIndex);
      triangle.x1        = randomCenter - partStep;
      triangle.x2        = randomCenter;
      triangle.x3        = randomCenter + partStep;

      // format
      triangle.x1    = float(String.format("%.2f", triangle.x1));
      triangle.x3    = float(String.format("%.2f", triangle.x3));
      left           = float(String.format("%.2f", left));
      right          = float(String.format("%.2f", right));

      // find used center to remove it
      possibleCenters.remove(randomCenterIndex);
      removedPossibleCenters.append(randomCenter);

      if (triangle.x1 != left  && !removedPossibleCenters.hasValue(triangle.x1) && !possibleCenters.hasValue(triangle.x1)) {
        possibleCenters.append(triangle.x1);
      }
      if (triangle.x3 != right && !removedPossibleCenters.hasValue(triangle.x3) && !possibleCenters.hasValue(triangle.x3)) {
        possibleCenters.append(triangle.x3);
      }
    }

    // align to center
    FK_TriangleMountain leftT  = triangles.get(0);
    FK_TriangleMountain rightT = triangles.get(0);
    for (int i = 1; i < triangleCount; i++) {
      FK_TriangleMountain triangle = triangles.get(i);
      if (triangle.x1 <  leftT.x1)  leftT  = triangle;
      if (triangle.x3 >  rightT.x3) rightT = triangle;
    }
    if (leftT != rightT) {
      // what do for align...
      float rightSpace = this.right - rightT.x3;
      float leftSpace  = leftT.x1  - this.left;
      if (leftSpace < 0) {
        float shiftSpace = abs(abs(rightSpace) - abs(leftSpace));
        for (int i = 1; i < triangleCount; i++) {
          FK_TriangleMountain triangle = triangles.get(i);
          triangle.x1 += shiftSpace;
          triangle.x2 += shiftSpace;
          triangle.x3 += shiftSpace;
        }
      }
    }

    // to top
    FK_TriangleMountain tallerTriangle = triangles.get(0);
    float diffTop = tallerTriangle.y2 - top;
    if (diffTop > 0) {
      for (FK_TriangleMountain triangle : triangles) {
        triangle.y2 -= diffTop;
        diffTop = diffTop/1.1;
      }
    }
  }

  public FK_TriangularMountainProgress(PApplet applet) {
    super(applet);
    this.w       = 512;
    this.h       = 512;
    this.left    = this.applet.width;
    this.bottom  = this.applet.height;
    this.autoBounds();
  }

  protected void drawer() {
    this.applet.noStroke();
    anyDrawed = false;

    textAlign(CENTER, BOTTOM);
    for (FK_TriangleMountain triangle : this.triangles) {
      anyDrawed = true;
      
      this.applet.fill(triangle.colour);
      this.applet.triangle(triangle.x1, triangle.y1, triangle.x2, triangle.y2, triangle.x3, triangle.y3);
      this.applet.fill(#000000);

      pushMatrix();
      if (triangle.icon != null) {
        this.applet.imageMode(CENTER);
        this.applet.translate(triangle.x2, triangle.y2 - 15);
        this.applet.image(triangle.icon, 0, 0);
        pushMatrix();
        if (beforeDrawPercentListener != null) beforeDrawPercentListener.onBefore(applet);
        this.applet.text(String.format("%.2f", triangle.percent) + "%", 0, -25);
        popMatrix();
      }
      popMatrix();
    }
  }
}
