String        PW_CURRENT_PATH;
final Boolean PW_CONF_FULLSCREEN             = true;
final int     PW_CONF_WIDTH                  = 1425;
final int     PW_CONF_HEIGHT                 = 625;
final color   PW_CONF_DEFAULT_BG_COLOR       = #fff100;
final color   PW_CONF_PAGE_SPLASH_BG_COLOR   = #fff100;
final color   PW_CONF_PAGE_OVERVIEW_BG_COLOR = #231F20;
final color   PW_CONF_PAGE_SINGLE_BG_COLOR   = #F5F5F5;
final color   PW_CONF_PAGE_SPLASH_GB_COLOR   = #FFEE58;
final String  PW_CONF_MAP_IMAGE_PATH         = "data/images/map.png";
final String  PW_CONF_FONT_DEFAULT           = "HelveticaNeueLight-32";
final String  PW_CONF_FONT_SPLASH_TITLE      = "HelveticaNeueBold-32";
final int     PW_CONF_MIN_YEAR               = 1997;
final int     PW_CONF_MAX_YEAR               = 2016;
final boolean PW_CONF_SMOOTH                 = true;

final color PW_VIS_GENERATED_COLOR = #fff100;
final color PW_VIS_RECYCLING_COLOR = #cbbf4d;
final color PW_VIS_RECOVERY_COLOR  = #948f5a;

final boolean PW_CONF_DEBUG                  = false;

void initConfig() {
  PW_CURRENT_PATH    = sketchPath("");
  currentPage        = PW_PageState.Splash;
  currentYear        = int(random(PW_CONF_MIN_YEAR, PW_CONF_MAX_YEAR));
  selectedCountry1   = PW_CountryType.Nothing;
  selectedCountry2   = PW_CountryType.Nothing;
}
