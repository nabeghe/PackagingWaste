public interface FK_SliderViewStepChangedListener {
  public void onChanged(FK_SliderView slider, int step);
}

public enum FK_LeverTextMode {
  Top, 
    Bottom
}

private class FK_SliderProgressStep {
  public int value;
  public float x;

  public FK_SliderProgressStep(int value, float x) {
    this.value = value;
    this.x = x;
  }
}

public class FK_SliderView extends FK_View {

  private boolean leverGoByMouse = false;
  private float channelLeftX;
  private float channelRightX;
  private float channelLeftTextX;
  private float channelRightTextX;
  private float channelLeftTextY;
  private float channelRightTextY;
  private float leverStepSize;
  private float leverHeight;
  private float leverX;
  private float leverY;
  private float leverTop;
  private float leverTextX;
  private float leverTextY;
  private ArrayList<FK_SliderProgressStep> leverPossibleSteps = new ArrayList<FK_SliderProgressStep>();
  private boolean minTextVisible  = true;
  private boolean maxTextVisible  = true;
  private boolean leverTextVisible = true;
  public void setLeverTextVisible(boolean value) {
    leverTextVisible = value;
  }
  private boolean hideLeverValueWhenStickedSides = true;

  private float lineCordiniate   = 7;
  private float leverCordiniate  = 7;

  private int   min              = 0;
  private int   max              = 100;
  private int   value             = 20;
  private float leverWidth       = 15;
  private float leverHeightRatio = 5;
  private float leverTextOffset  = 5;
  public int getValue() {
    return value;
  }
  public void setValue(int value) {
    if (this.value == value) return;
    this.value = value;
    reloadVariables();
    if (onStepChangedListener != null) onStepChangedListener.onChanged(this, value);
  }

  private float minTextOffsetX   = 10;
  private float maxTextOffsetX   = 10;
  private float minTextOffsetY   = 5;
  private float maxTextOffsetY   = 5;

  /* Colros */
  private color channelBgColor      = #a6a8ab;
  private color channelBorderColor  = #a6a8ab;
  private color leverBgColor        = #fff100;
  private color leverBorderColor    = #fff100;
  private color leftTextColor       = #FAFAFA;
  private color rightTextColor      = #FAFAFA;
  private color leverTextColor      = #FAFAFA;
  public color getChannelBgColor() {
    return this.channelBgColor;
  }
  public void setChannelBgColor(color colour) {
    this.channelBgColor = colour;
  }
  public color getChannelBorderColor() {
    return this.channelBorderColor;
  }
  public void setChannelBorderColor(color colour) {
    this.channelBorderColor = colour;
  }
  public void setChannelColor(color colour) {
    setChannelBgColor(colour);
    setChannelBorderColor(colour);
  }
  public color getLeverBgColor() {
    return this.leverBgColor;
  }
  public void setLeverBgColor(color colour) {
    this.leverBgColor = colour;
  }
  public color getLeverBorderColor() {
    return this.leverBorderColor;
  }
  public void setLeverBorderColor(color colour) {
    this.leverBorderColor = colour;
  }
  public void setLeverColor(color colour) {
    setLeverBgColor(colour);
    setLeverBorderColor(colour);
  }
  public color getLeftTextColor() {
    return this.leftTextColor;
  }
  public void setLeftTextColor(color colour) {
    this.leftTextColor = colour;
  }
  public color getRightTextColor() {
    return this.rightTextColor;
  }
  public void setRightTextColor(color colour) {
    this.rightTextColor = colour;
  }
  public color getLeverTextColor() {
    return this.leverTextColor;
  }
  public void setLeverTextColor(color colour) {
    this.leverTextColor = colour;
  }
  public void setTextColors(color colour) {
    setLeftTextColor(colour);
    setRightTextColor(colour);
    setLeverTextColor(colour);
  }
  /* ----- * ----- */

  /* Text Sizes */
  private float leftTextSize     = 18;
  private float rightTextSize    = 18;
  private float leverTextSize    = 18;
  public float leftTextSize() {
    return leftTextSize;
  }
  public void leftTextSize(float size) {
    this.leftTextSize = size;
  }
  public float rightTextSize() {
    return rightTextSize;
  }
  public void rightTextSize(float size) {
    this.rightTextSize = size;
  }
  public float leverTextSize() {
    return leverTextSize;
  }
  public void leverTextSize(float size) {
    this.leverTextSize = size;
  }
  public void textSize(float size) {
    leftTextSize(size);
    rightTextSize(size);
    leverTextSize(size);
  }
  /* ----- * ----- */

  private boolean canWheel = false;
  private boolean canClick = true;
  private boolean canMove  = true;
  public boolean canWheel() {
    return this.canWheel;
  }
  public void canWheel(boolean canWheel) {
    this.canWheel = canWheel;
  }
  public boolean canClick() {
    return this.canWheel;
  }
  public void canClick(boolean canClick) {
    this.canClick = canClick;
  }
  public boolean canMove() {
    return this.canWheel;
  }
  public void canMove(boolean canMove) {
    this.canMove = canMove;
  }

  private FK_SliderViewStepChangedListener onStepChangedListener;
  public void setOnStepChangedListener(FK_SliderViewStepChangedListener listener) {
    this.onStepChangedListener = listener;
  }

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  public void lineCordiniate(float lineCordiniate) {
    this.lineCordiniate = lineCordiniate;
  }

  public void leverCordiniate(float leverCordiniate) {
    this.leverCordiniate = leverCordiniate;
  }

  public void bounds(int min, int max) {
    if (min >= max) return;
    this.min = min;
    this.max = max;
    reloadVariables();
    reloadPossibleLverSteps();
  }

  public void leverHeightRatio(float leverHeightRatio) {
    this.leverHeightRatio = leverHeightRatio;
    reloadVariables();
  }

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  public void setLocation(float x, float y) {
    super.setLocation(x, y);
    reloadVariables();
    reloadPossibleLverSteps();
  }

  public void setSize(float w, float h) {
    super.setSize(w, h);
    reloadVariables();
    reloadPossibleLverSteps();
  }

  /* ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- */

  private FK_SliderProgressStep getNearstPossibleLeverStep(float targetX) {
    int size = leverPossibleSteps.size();
    if (size == 1 || targetX <= channelLeftX) {
      return leverPossibleSteps.get(0);
    }
    if (targetX >= channelRightX) {
      return leverPossibleSteps.get(size - 1);
    }
    for (int i = 1; i < size; i++) {
      FK_SliderProgressStep prevStep = leverPossibleSteps.get(i - 1);
      FK_SliderProgressStep nextStep = leverPossibleSteps.get(i);

      float diffFromNext = abs(nextStep.x    - targetX);
      float diffFromPrev = abs(targetX - prevStep.x);

      if (targetX >= prevStep.x && targetX <= nextStep.x) {
        if (diffFromNext <= diffFromPrev) {
          return nextStep;
        } else {
          return prevStep;
        }
      }
    }
    return leverPossibleSteps.get(0);
  }

  private boolean isMouseOnLever() {
    if (applet.mouseX > leverX - leverWidth / 2 && applet.mouseX < leverX + leverWidth / 2
      && applet.mouseY > leverY - leverHeight / 2 && applet.mouseY < leverY + leverHeight / 2) {
      return true;
    }
    return false;
  }

  private boolean isMouseOnLine() {
    if (applet.mouseX > x - w - 5 / 2 && applet.mouseX < x + w / 2 + 5
      && applet.mouseY > y - h - 5 / 2 && applet.mouseY < y + h / 2 + 5) {
      return true;
    }
    return false;
  }

  private void increaseStep() {
    if (value < max) {
      setValue(value + 1);
    }
  }

  private void decreaseStep() {
    if (value > min) {
      setValue(value - 1);
    }
  }

  private void reloadVariables() {
    channelLeftX      = x - (w / 2);
    channelRightX     = x + (w / 2);
    channelLeftTextX  = (x - (w / 2)) - minTextOffsetX;
    channelRightTextX = (x + (w - w/2)) + maxTextOffsetX;
    channelLeftTextY  = (y - (h / 2)) + minTextOffsetY;
    channelRightTextY = (y - (h / 2)) + maxTextOffsetY;

    leverStepSize     = w / (max - min);
    leverX            = channelLeftX + (leverStepSize * (value - min));
    leverY            = y - h /2;
    leverHeight       = h * leverHeightRatio;
    leverTop          = leverY - leverHeight / 2;

    leverTextX        = channelLeftX + (leverStepSize * (value - min));
    leverTextY        = leverTop - leverTextOffset;
  }

  private void reloadPossibleLverSteps() {
    leverPossibleSteps.clear();
    for (int i = min; i <= max; i++) {
      leverPossibleSteps.add(new FK_SliderProgressStep(i, channelLeftX + (leverStepSize * (i - min))));
    }
  }

  public FK_SliderView(PApplet applet) {
    super(applet);
    applet.rectMode(CENTER);

    w = applet.width - 20;
    h = 5;
    reloadVariables();
  }

  protected void started() {
    try {
      applet.registerMethod("mouseEvent", this);
    } 
    catch (Exception e) {
    }
  }

  protected void stopped() {
    try {
      applet.unregisterMethod("mouseEvent", this);
    } 
    catch (Exception e) {
    }
  }

  public void mouseEvent(MouseEvent event) {
    if (!enabled) return;
    try {
      switch(event.getAction()) {
      case MouseEvent.CLICK:
        if (canClick) {
          if (isMouseOnLine() && !isMouseOnLever()) {
            FK_SliderProgressStep possible = getNearstPossibleLeverStep(applet.mouseX);
            leverX = possible.x;
            setValue(possible.value);
          }
        }
        break;
      case MouseEvent.DRAG :
        if (canMove) {
          if (leverGoByMouse) {
            if (applet.mouseX> channelLeftX && applet.mouseX < channelRightX) {
              leverX     = applet.mouseX;
              leverTextX = applet.mouseX;
              FK_SliderProgressStep possible = getNearstPossibleLeverStep(leverX);
              value      = possible.value;
              if (onStepChangedListener != null) onStepChangedListener.onChanged(this, value);
            }
          }
        }
        break;
      case MouseEvent.ENTER :

        break;
      case MouseEvent.EXIT :

        break;
      case MouseEvent.MOVE :

        break;
      case MouseEvent.PRESS :
        //applet.mousePressed = true;
        if (canMove && isMouseOnLever()) {
          leverGoByMouse = true;
        }
        break;
      case MouseEvent.RELEASE :
        //applet.mousePressed = false;
        if (leverGoByMouse) {
          leverGoByMouse = false;
          FK_SliderProgressStep possible = getNearstPossibleLeverStep(leverX);
          leverX = possible.x;
          leverTextX = possible.x;
          setValue(possible.value);
        }

        break;
      case MouseEvent.WHEEL:
        if (!leverGoByMouse && canWheel) {
          if (event.getCount() < 0) {
            increaseStep();
          } else {
            decreaseStep();
          }
        }
        break;
      }
    } 
    catch (Exception e) {
    }
  }

  protected void drawer() {
    /* CHANNEL (SLIDER LINE) */
    applet.fill(channelBgColor);
    applet.stroke(channelBorderColor);
    applet.rect(x, y, w, h, lineCordiniate);

    /* LEFT TEXT (MINIMUM VALUE TITLE) */
    if (minTextVisible) {
      applet.fill(leftTextColor);
      applet.textSize(leftTextSize);
      textAlign(RIGHT); // chon channel samte rasteshe, pas bayad az samte rast type she
      applet.text(min, channelLeftTextX, channelLeftTextY);
    }

    /* RIGHT TEXT (MAXIMUM VALUE TITLE) */
    if (maxTextVisible) {
      applet.fill(rightTextColor);
      applet.textSize(rightTextSize);
      textAlign(LEFT); // chon channel samte chapeshe, pas bayad az samte chap type she
      applet.text(max, channelRightTextX, channelRightTextY);
    }

    /* LEVER */
    applet.fill(leverBgColor);
    applet.stroke(leverBorderColor);
    float newLeverX = leverX;
    applet.rect(newLeverX, leverY, leverWidth, leverHeight, leverCordiniate);

    /* LEVER TEXT */
    if (leverTextVisible && (!hideLeverValueWhenStickedSides || (value != min && value != max))) {
      applet.fill(leverTextColor);
      applet.textSize(leverTextSize);
      textAlign(CENTER);
      applet.text(value, leverTextX, leverTextY);
    }
  }
}
