public interface PW_VislaizationViewSetupListener {
  void onSetup(FK_ArcProgressView arcView, FK_TriangularMountainProgress triangleMountainView);
}

public class PW_VisView {

  private FK_ArcProgressView            arcView;
  private FK_TriangularMountainProgress triangleMountainView;

  public PW_VisView(PApplet applet) {
    init(applet, null);
  }

  public PW_VisView(PApplet applet, PW_VislaizationViewSetupListener listener) {
    init(applet, listener);
  }

  private void init(PApplet applet, PW_VislaizationViewSetupListener listener) {
    arcView              = new FK_ArcProgressView(applet);
    triangleMountainView = new FK_TriangularMountainProgress(applet);
    arcView.setCenterColor(PW_CONF_PAGE_SINGLE_BG_COLOR);
    setArcMode(PW_VisArcMode.Top);

    if (listener != null) {
      listener.onSetup(arcView, triangleMountainView);
    }

    triangleMountainView.setDraw4AnyListener(new FK_Draw4AnyListener() {
      public void onYes(PApplet applet, FK_View view) {
      }
      public void onNo(PApplet applet, FK_View view) {
        pushMatrix();
        applet.fill(#B71C1C);
        applet.textSize(48);
        applet.text("NO   DATA   AVAILABLE", view.getX(), view.getY());
        popMatrix();
      }
    }
    );
  }

  public void setArcMode(PW_VisArcMode arcMode) {
    switch(arcMode) {
    case Top:
      arcView.setBound(-180, 0);
      break;
    case Bottom:
      arcView.setBound(180, 0);
      break;
    }
  }

  public void setBounds(float x, float y, float w, float h) {
    arcView.setLocation(x, y);
    arcView.setSize(w, h);
    autoAligmentTriangles(0, 0);
  }

  public void autoAligmentTriangles(float offsetX, float offsetY) {
    triangleMountainView.setLocation(arcView.getX(), arcView.getY());
    float arcSize = arcView.getCenterOffset();
    triangleMountainView.setSize(
      arcView.getWidth()  - arcSize*2 + offsetX, 
      arcView.getHeight() - arcSize*3 + offsetY
      );
  }

  public void setVisible(boolean enabled) {
    arcView.setVisible(enabled);
    triangleMountainView.setVisible(enabled);
  }

  public void load(PW_WestOper westOper, PW_Waste waste) {
    injectWestOperToView(westOper, arcView);
    injectWasteToView(waste, triangleMountainView);
  }
}
