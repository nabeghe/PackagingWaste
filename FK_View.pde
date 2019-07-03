public interface FK_Draw4AnyListener {
  void onYes(PApplet applet, FK_View view);
  void onNo(PApplet applet, FK_View view);
}

public interface FK_ViewDrawListener {
  void onBeforeDraw(PApplet applet);
  void onFinishDraw(PApplet applet);
}

public class FK_View {

  protected PApplet            applet;
  protected boolean            enabled;
  protected FK_ViewDrawListener drawListener;

  protected float x;
  protected float y;

  protected float w;
  protected float h;

  private PFont font;
  private float textSize;

  private FK_Draw4AnyListener draw4AnyListener;
  protected boolean anyDrawed = true;

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  public PApplet getApplet() {
    return applet;
  }

  public void setFont(PFont font) {
    this.font = font;
  }

  public void setTextSize(float textSize) {
    this.textSize = textSize;
  }

  public void setDraweListener(FK_ViewDrawListener listener) {
    drawListener = listener;
  }

  public void setDrawListener(FK_ViewDrawListener drawListener) {
    this.drawListener = drawListener;
  }

  public final void setVisible(boolean enabled) {
    if (this.enabled == enabled) return;
    this.enabled = enabled;
    if (enabled) {
      try {
        applet.registerMethod("draw", this); 
        started();
      } 
      catch (Exception e) {
      }
    } else {
      try {
        applet.unregisterMethod("draw", this);
        stopped();
      } 
      catch (Exception e) {
      }
    }
  }

  public void setSize(float w, float h) {
    this.w = w;
    this.h = h;
  }

  public void setLocation(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public void setDraw4AnyListener(FK_Draw4AnyListener value) {
    draw4AnyListener = value;
  }

  public float getWidth() {
    return this.w;
  }

  public float getHeight() {
    return this.h;
  }

  public float getX() {
    return this.x;
  }

  public float getY() {
    return this.y;
  }

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  public FK_View(PApplet applet) {
    this.applet = applet;
  }

  public void draw() {
    color oldFillColor = applet.g.fillColor;
    PFont oldTextFont  = applet.g.textFont;
    float oldTextSize  = applet.g.textSize;

    applet.pushMatrix();
    if (this.font != null) applet.textFont(font);
    if (this.textSize > 0) applet.textSize(textSize);
    if (drawListener != null) drawListener.onBeforeDraw(applet);
    drawer();
    if (draw4AnyListener != null) {
      if (anyDrawed) {
        draw4AnyListener.onYes(applet, this);
      } else {
        draw4AnyListener.onNo(applet, this);
      }
    }
    if (drawListener != null) drawListener.onFinishDraw(applet);
    applet.popMatrix();

    applet.fill(oldFillColor);
    if (oldTextFont != null) applet.textFont(oldTextFont);
    applet.textSize(oldTextSize);
  }

  protected void started() {
  }

  protected void stopped() {
  }

  protected void drawer() {
  }
}
