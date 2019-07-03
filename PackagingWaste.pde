import controlP5.*;
import g4p_controls.*;

/* ============================================================================================================================ */

GImageButton            backButton;
ControlP5               cp5;
ArrayList<GImageButton> coutryButtons;
PW_PageState            currentPage;
int                     currentYear;
PW_Db                   db;
DropdownList            ddlCountries;
PFont                   fontDefault;
PImage                  overviewPageImgMap;
FK_SliderView           overviewPageSlider;
FK_SliderView           analyzePageSlider;
PW_CountryType          selectedCountry1;
PW_CountryType          selectedCountry2;
PW_VisView              vis1;
PW_VisView              vis2;
int testState = 1;

PImage splashPageImgTitle;
PImage splashPageImgTop1;
PImage splashPageImgTop2;
PImage splashPageImgTop3;
PImage splashPageImgTop4;
PImage splashPageImgBottom1;
PImage splashPageImgBottom2;
PImage splashPageImgBottom3;
PImage splashPageImgBottom4;

/* ============================================================================================================================ */

void settings() {
  initConfig();
  if (PW_CONF_FULLSCREEN) {
    fullScreen();
  } else {
    size(PW_CONF_WIDTH, PW_CONF_HEIGHT);
  }
  if (PW_CONF_SMOOTH) {
    smooth();
  }
}

void setup() {
  background(PW_CONF_DEFAULT_BG_COLOR);

  fontDefault = loadFont("data/fonts/" + PW_CONF_FONT_DEFAULT + ".vlw");
  textFont(fontDefault);

  db = new PW_Db("data/csv/domestic.csv");
  overviewPageImgMap = loadImage(PW_CONF_MAP_IMAGE_PATH);
  overviewPageImgMap.resize(width, height);
  pw_SwitchPageState(currentPage);
  cp5 = new ControlP5(this);

  splashPageImgTitle = loadImage("data/images/splash/title.png");
  int newWidth = 0;
  int diffWidth = 0;
  if (splashPageImgTitle.width > width) {
    newWidth = width - 200;
    diffWidth = splashPageImgTitle.width - newWidth;
  }
  splashPageImgTitle.resize(newWidth, abs(splashPageImgTitle.height - diffWidth) /2);

  splashPageImgTop1 = loadImage("data/images/splash/top1.png");
  splashPageImgTop2 = loadImage("data/images/splash/top2.png");
  splashPageImgTop3 = loadImage("data/images/splash/top3.png");
  splashPageImgTop4 = loadImage("data/images/splash/top4.png");

  splashPageImgBottom1 = loadImage("data/images/splash/buttom1.png");
  splashPageImgBottom2 = loadImage("data/images/splash/buttom2.png");
  splashPageImgBottom3 = loadImage("data/images/splash/buttom3.png");
  splashPageImgBottom4 = loadImage("data/images/splash/buttom4.png");
}

void draw() {
  if (currentPage != null) {
    switch(currentPage) {
    case Splash:
      {
        background(PW_CONF_PAGE_SPLASH_BG_COLOR);
        pushMatrix();
        imageMode(CENTER);
        image(splashPageImgTitle, width/2, height/2);

        image(splashPageImgTop1, width/2 - 375, 150);
        image(splashPageImgTop2, width/2 - 150, 160);
        image(splashPageImgTop3, width/2 + 150, 200);
        image(splashPageImgTop4, width/2 + 375, 200);

        image(splashPageImgBottom1, width/2 - 375, height - 150);
        image(splashPageImgBottom2, width/2 - 150, height - 160);
        image(splashPageImgBottom3, width/2 + 150, height - 180);
        image(splashPageImgBottom4, width/2 + 375, height - 170);
        popMatrix();
      }
      break;
    case Overview:
      {
        background(overviewPageImgMap);
      }
      break;
    case Analyze:
      {
        background(PW_CONF_PAGE_SINGLE_BG_COLOR);
        pushMatrix();
        if (isActiveDualAnalyzation()) {
          textAlign(RIGHT);
          fill(#37474F);
          textSize(48);
          text("VS", width/3.6, height/1.95);

          textAlign(CENTER);
          fill(#90A4AE);
          textSize(40);
          text(selectedCountry1.toString(), width/2, height/7.5);

          textAlign(CENTER);
          fill(#90A4AE);
          textSize(40);
          text(selectedCountry2.toString(), width/2, height - height/8.6);

          fill(#37474F);
          textSize(52);
          text(currentYear, width/2, height/11);
        } else {
          textAlign(CENTER);
          fill(#90A4AE);
          textSize(48);
          text(selectedCountry1.toString(), width/2, height/4.5);

          fill(#37474F);
          textSize(96);
          text(currentYear, width/2, height/6);
        }

        switch (testState) {
        case 1:
          {
            float _w = 50;
            float _h = 50;
            float _x = _w/2 + 10;
            float _y = 110;
            fill(PW_VIS_GENERATED_COLOR);
            rect(_x, _y, _w, _h);
            fill(PW_VIS_RECYCLING_COLOR);
            rect(_x, _y + _h, _w, _h);
            fill(PW_VIS_RECOVERY_COLOR);
            rect(_x, _y + _h*2, _w, _h);
            fill(#212121);
            textSize(20);
            textAlign(LEFT);
            text("Generated", _x + _w - 15, _y + 7);
            text("Recyceling", _x + _w - 15, _y + _h + 7);
            text("Recovery", _x + _w - 15, _y + _h*2 + 7);
          }
          break;
        case 2:
          {
            float _w = width/3;
            float _h = 100;
            fill(PW_VIS_GENERATED_COLOR);
            rect(0  * 1 + _w/2, height, _w, _h);
            fill(PW_VIS_RECYCLING_COLOR);
            rect(_w * 1 + _w/2, height, _w, _h);
            fill(PW_VIS_RECOVERY_COLOR);
            rect(_w * 2 + _w/2, height, _w, _h);
          }
          break;
        }

        popMatrix();
      }
      break;
    }
  }

  if (PW_CONF_DEBUG) {
    line(0, height/2, width, height/2);
    line(width/2, 0, width/2, height);
  }
}

void keyPressed() {
  if (key == ESC) {
    switch(currentPage) {
    case Splash:
      {
        exit();
      }
      break;
    case Overview:
      {
        exit();
      }
      break;
    case Analyze:
      {
        selectedCountry2 = PW_CountryType.Nothing;
        pw_SwitchPageState(PW_PageState.Overview);
        key = 0;
      }
      break;
    }
  } else if (currentPage == PW_PageState.Splash) {
    pw_SwitchPageState(PW_PageState.Overview);
    key = 0;
  }
}

void mouseClicked() {
  if (currentPage == PW_PageState.Splash) {
    pw_SwitchPageState(PW_PageState.Overview);
  }
}

/* ============================================================================================================================ */

void pw_loadOverViewPage() {
  /* Remove Analyze */
  if (vis1 != null) vis1.setVisible(false);
  if (vis2 != null) vis2.setVisible(false);
  if (analyzePageSlider != null) analyzePageSlider.setVisible(false);
  if (ddlCountries != null) ddlCountries.hide();
  vis1 = null;
  vis2 = null;
  analyzePageSlider = null;
  /* ----- * ----- */

  /* Initalize Overview */
  if (overviewPageSlider == null) {
    overviewPageSlider = new FK_SliderView(this);
    overviewPageSlider.setLocation(width/2, height-85);
    overviewPageSlider.setSize(width/2, 5);
    overviewPageSlider.bounds(PW_CONF_MIN_YEAR, PW_CONF_MAX_YEAR);
    overviewPageSlider.setValue(currentYear);
    overviewPageSlider.canWheel(true);
  }
  overviewPageSlider.setVisible(true);
  pw_setCountryButtonsEnabled(true);
  if (backButton != null) backButton.setVisible(false);
  /* ----- * ----- */
}

void pw_loadAnalyzePage() {
  /* Remove Overview */
  pw_setCountryButtonsEnabled(false);
  overviewPageSlider.setVisible(false);
  overviewPageSlider = null;
  /* ----- * ----- */

  /* Initialize Vis 1 */
  if (vis1 == null) {
    vis1 = new PW_VisView(this, new PW_VislaizationViewSetupListener() {
      public void onSetup(FK_ArcProgressView arcView, FK_TriangularMountainProgress triangleMountainView) {
        triangleMountainView.setTextSize(16);
      }
    }
    );
  }
  reloadVis1Data();
  vis1.setVisible(true);
  /* ----- * ----- */

  /* Initialize Vis 2 */
  if (vis2 == null) {
    vis2 = new PW_VisView(this, new PW_VislaizationViewSetupListener() {
      public void onSetup(final FK_ArcProgressView arcView, FK_TriangularMountainProgress triangleMountainView) {
        triangleMountainView.setTextSize(16);
        FK_ViewDrawListener drawListener = new FK_ViewDrawListener() {
          public void onBeforeDraw(PApplet applet) {
            applet.translate(width/2, height/2);
            applet.scale(-1, 1);
            applet.translate(width/2, height/2);
            applet.rotate(PI);
          }
          public void onFinishDraw(PApplet applet) {
          }
        };
        arcView.setDrawListener(drawListener);
        triangleMountainView.setDrawListener(drawListener);

        triangleMountainView.setBeforeDrawPercentListener(new FK_TriangleBeforeDrawPercent() {
          public void onBefore(PApplet applet) {
            applet.scale(-1, 1);
            applet.rotate(-PI);
            applet.translate(0, 70);
          }
        }
        );
      }
    }
    );
  }
  /* ----- * ----- */

  /* Initialize Year Slider */
  if (analyzePageSlider == null) {
    analyzePageSlider = new FK_SliderView(this);
    analyzePageSlider.bounds(PW_CONF_MIN_YEAR, PW_CONF_MAX_YEAR);
    analyzePageSlider.setValue(currentYear);
    analyzePageSlider.canWheel(true);
    analyzePageSlider.setTextColors(#000000);
    analyzePageSlider.setOnStepChangedListener(new FK_SliderViewStepChangedListener() {
      public void onChanged(FK_SliderView slider, int step) {
        currentYear = step;
        reloadVis1Data();
        if (isActiveDualAnalyzation()) reloadVis2Data();
      }
    }
    );
  }
  analyzePageSlider.setVisible(true);
  /* ----- * ----- */

  /* Initialize DropdownList */
  if (ddlCountries == null) {
    ddlCountries = cp5.addDropdownList("Comparison")
      .setPosition(width - 200, 0)
      .setSize(200, height/2)
      .setBackgroundColor(color(190))
      .setColorBackground(color(60))
      .setColorActive(color(255, 128))
      .setItemHeight(45)
      .setBarHeight(45);
    ControlFont cf1 = new ControlFont(fontDefault, 20);
    ddlCountries.setFont(cf1);
    ddlCountries.addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        switch(event.getAction()) {
        case ControlP5.ACTION_ENTER:
          {
            if (analyzePageSlider != null) analyzePageSlider.canWheel(false);
          }
          break;
        case ControlP5.ACTION_LEAVE:
          if (analyzePageSlider != null) analyzePageSlider.canWheel(true);
          break;
        }
      }
    }
    );
    //ddlCountries.getCaptionLabel().set("dropdown");
    for (PW_CountryType country : PW_CountryType.values()) {
      ddlCountries.addItem(country.toString(), country.id());
    }
  }
  ddlCountries.close();
  ddlCountries.show();
  if (backButton == null) {
    String[] icons = new String[] {
      "images/ic_back_1.png", 
      "images/ic_back_2.png", 
      "images/ic_back_1.png"
    };
    backButton = new GImageButton(this, 5, 5, icons);
    backButton.tag = "btn_back";
    coutryButtons.add(backButton);
  } else {
    backButton.setVisible(true);
  }
  /* ----- * ----- */

  initAnalyzePageViewBounds();
}

void pw_SwitchPageState(PW_PageState state) {
  this.currentPage = state;
  switch (this.currentPage) {
  case Overview:
    {
      pw_loadOverViewPage();
    }
    break;
  case Analyze:
    {
      pw_loadAnalyzePage();
    }
    break;
  }
}

void pw_setCountryButtonsEnabled(boolean enabled) {
  if (coutryButtons == null) coutryButtons = new ArrayList<GImageButton>();
  if (coutryButtons.size() == 0) {
    pw_addOverviewButton(PW_CountryType.Ireland, 3.9, 4.2);
    pw_addOverviewButton(PW_CountryType.UnitedKingdom, 3.2, 3);
    pw_addOverviewButton(PW_CountryType.Norway, 1.85, 3.2);
    pw_addOverviewButton(PW_CountryType.Sweden, 1.72, 2.6);
    pw_addOverviewButton(PW_CountryType.Finland, 1.38, 2.25);
    pw_addOverviewButton(PW_CountryType.Portugal, 12, 2.45);
    pw_addOverviewButton(PW_CountryType.Spain, 7.8, 2.1);
    pw_addOverviewButton(PW_CountryType.France, 3.7, 2.2);
    pw_addOverviewButton(PW_CountryType.Belgium, 2.85, 2.45);
    pw_addOverviewButton(PW_CountryType.Netherlands, 2.62, 2.58);
    pw_addOverviewButton(PW_CountryType.Denmark, 2.15, 2.7);
    pw_addOverviewButton(PW_CountryType.Germany, 2.45, 2.15);
    pw_addOverviewButton(PW_CountryType.Poland, 1.95, 1.85);
    pw_addOverviewButton(PW_CountryType.Lithuania, 1.67, 1.88);
    pw_addOverviewButton(PW_CountryType.Latvia, 1.55, 1.88);
    pw_addOverviewButton(PW_CountryType.Estonia, 1.48, 2);
    pw_addOverviewButton(PW_CountryType.Italy, 3, 1.75);
    pw_addOverviewButton(PW_CountryType.Austria, 2.45, 1.85);
    pw_addOverviewButton(PW_CountryType.Slovakia, 2.15, 1.75);
    pw_addOverviewButton(PW_CountryType.Slovenia, 2.65, 1.8);
    pw_addOverviewButton(PW_CountryType.Croatia, 2.45, 1.67);
    pw_addOverviewButton(PW_CountryType.Hungary, 2.25, 1.65);
    pw_addOverviewButton(PW_CountryType.Romania, 2.07, 1.47);
    pw_addOverviewButton(PW_CountryType.Bulgaria, 2.22, 1.4);
    pw_addOverviewButton(PW_CountryType.Greece, 2.67, 1.38);
    // Czechia
    // Liechtenstein
    // Luxembourg
    // Malta
    return;
  }
  for (GImageButton btn : coutryButtons) {
    btn.setVisible(enabled);
  }
}

// ezafe kardan dokme jadide keshvar be overview ruye map
void pw_addOverviewButton(PW_CountryType country, float wPart, float hPart) {
  if (wPart != 0) wPart = width  / wPart;
  if (hPart != 0) hPart = height / hPart;
  String countryName  = country.toString(); // esme keshvar
  String iconFileName = countryName + ".png"; // esme file icon
  String[] icons = new String[] {
    "images/flags/2/" + iconFileName, 
    "images/flags/1/" + iconFileName, 
    "images/flags/1/" + iconFileName
  }; // masire iconaye dokme {idle, click start, click end}
  GImageButton btn = new GImageButton(this, wPart, hPart, icons); // dokme jadido misazim
  btn.tag = country.id() + ""; // code pish shomareye keshvar ro be tage dokme midim ta badan azash moqe click estefade konim
  coutryButtons.add(btn); // ezafe mikonim be liste dokmeha
}

// evente: vaqti ruye dokmehaye keshvar to overview click mishe
void handleButtonEvents(GImageButton button, GEvent event) {
  if (event == GEvent.CLICKED) {
    if (button.tag.equals("btn_back")) {
      selectedCountry2 = PW_CountryType.Nothing;
      pw_SwitchPageState(PW_PageState.Overview);
      return;
    }
    selectedCountry1 = PW_CountryType.fromId(button.tag); // keshvare avali ke select shode ro az tage dokme (ke pish shomareye keshvar tosh save shode) begir
    currentYear = overviewPageSlider.getValue(); // sale felio az slidere sal to overview begir
    pw_SwitchPageState(PW_PageState.Analyze); // boro to halate safheye Analyze
  }
}

// event: vaqti az liste keshvara to safheye Analyze ru yekish click she
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isController()) {
    int selectedIndex = int(theEvent.getController().getValue()); // ruye iteme chandom click shode
    int i = 0;
    for (PW_CountryType country : PW_CountryType.values()) { // bayad to enume keshvara begardim bebinim ru kodom click shode
      if (selectedIndex == i) {
        selectedCountry2 = country;
      }
      i++;
    }
    initAnalyzePageViewBounds();
    if (isActiveDualAnalyzation()) reloadVis2Data();
  }
}

// aya dota keshvaro bayad baham analyze konim?! (bala va paeen)
boolean isActiveDualAnalyzation() {
  return selectedCountry2 != PW_CountryType.Nothing; // aya keshvare dovomi entekhab shode?!
}

void reloadVis1Data() {
  vis1.load(db.getWestOperInYear(currentYear, selectedCountry1), db.getWasteInYear(currentYear, selectedCountry1));
}

void reloadVis2Data() {
  vis2.load(db.getWestOperInYear(currentYear, selectedCountry2), db.getWasteInYear(currentYear, selectedCountry2));
}

void initAnalyzePageViewBounds() {
  float vis1X;
  float vis1Y;
  float vis1W;
  float vis1H;
  float analyzePageSliderX;
  float analyzePageSliderY;
  float analyzePageSliderW;
  float analyzePageSliderH;

  vis1X = width/2;
  if (isActiveDualAnalyzation()) {  
    vis1Y = height/2.0 - 30;
    vis1W = 680;
    vis1H = 680;
    analyzePageSliderX = width/2;
    analyzePageSliderY = height/2;
    analyzePageSliderW = vis1W + 50;
    analyzePageSliderH = 5;
    if (vis2 != null) vis2.setVisible(true);
    analyzePageSlider.setLeverTextVisible(false);
  } else {
    vis1Y = height/2 + height/3.5;
    vis1W = 1200;
    vis1H = 1100;
    analyzePageSliderX = width/2;
    analyzePageSliderY = height/2 + height/3;
    analyzePageSliderW = vis1W + 100;
    analyzePageSliderH = 5;
    if (vis2 != null) vis2.setVisible(false);
    analyzePageSlider.setLeverTextVisible(true);
  }

  if (vis1 != null) {
    vis1.setBounds(vis1X, vis1Y, vis1W, vis1H);
  }
  if (vis2 != null) {
    vis2.setBounds(vis1X, vis1Y, vis1W, vis1H);
  }
  if (analyzePageSlider != null) {
    analyzePageSlider.setLocation(analyzePageSliderX, analyzePageSliderY);
    analyzePageSlider.setSize(analyzePageSliderW, analyzePageSliderH);
  }
}
