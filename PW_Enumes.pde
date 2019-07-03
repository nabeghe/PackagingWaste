public enum PW_WasteType {
  Total(0), 
    PaperAndCardboard(1), 
    Plastic(2), 
    Wooden(3), 
    Metallic(4), 
    Aluminium(5), 
    Steel(6), 
    Glass(7), 
    Other(8);

  private int id;

  private PW_WasteType(int id) {
    this.id = id;
  }

  public int id() {
    return id;
  }

  public static PW_WasteType fromId(int id) {
    switch(id) {
    case 0:  
      return  PW_WasteType.Total;
    case 1:  
      return  PW_WasteType.PaperAndCardboard;
    case 2:  
      return  PW_WasteType.Plastic;
    case 3:  
      return  PW_WasteType.Wooden;
    case 4:  
      return  PW_WasteType.Metallic;
    case 5:  
      return  PW_WasteType.Aluminium;
    case 6:  
      return  PW_WasteType.Steel;
    case 7:  
      return  PW_WasteType.Glass;
    default: 
      return  PW_WasteType.Other;
    }
  }
}

public enum PW_WstOperType {
  WasteGenerated(1), 
    Recovery(2), 
    Recycling(3);

  private int id;

  private PW_WstOperType(int id) {
    this.id = id;
  }

  public int id() {
    return id;
  }

  public static PW_WstOperType fromId(int id) {
    switch(id) {
    case 1:  
      return  PW_WstOperType.WasteGenerated;
    case 2:  
      return  PW_WstOperType.Recovery;
    default: 
      return  PW_WstOperType.Recycling;
    }
  }
}

public enum PW_CountryType {
  Austria(43), 
    Belgium(32), 
    Bulgaria(359), 
    Croatia(385), 
    Cyprus(357), 
    Czechia(420), 
    Denmark(45), 
    Estonia(372), 
    Finland(358), 
    France(33), 
    Germany(49), 
    Greece(30), 
    Hungary(36), 
    //Iceland(354), 
    Ireland(353), 
    Italy(39), 
    Latvia(371), 
    Liechtenstein(423), 
    Lithuania(370), 
    Luxembourg(352), 
    Malta(356), 
    Netherlands(31), 
    Norway(47), 
    Poland(48), 
    Portugal(351), 
    Romania(40), 
    Slovakia(421), 
    Slovenia(386), 
    Spain(34), 
    Sweden(46), 
    UnitedKingdom(44), 
    Nothing(-1);

  private int id;

  private PW_CountryType(int id) {
    this.id = id;
  }

  public int id() {
    return id;
  }

  public String toString() {
    return pwSplitCamelCase(super.toString());
  }

  public static PW_CountryType fromId(String id) {
    return fromId(int(id));
  }

  public static PW_CountryType fromId(int id) {
    switch(id) {
    case 32:  
      return  PW_CountryType.Belgium;
    case 359: 
      return  PW_CountryType.Bulgaria;
    case 420: 
      return  PW_CountryType.Czechia;
    case 45:  
      return  PW_CountryType.Denmark;
    case 49:  
      return  PW_CountryType.Germany;
    case 372: 
      return  PW_CountryType.Estonia;
    case 353: 
      return  PW_CountryType.Ireland;
    case 30:  
      return  PW_CountryType.Greece;
    case 34:  
      return  PW_CountryType.Spain;
    case 33:  
      return  PW_CountryType.France;
    case 385: 
      return  PW_CountryType.Croatia;
    case 39:  
      return  PW_CountryType.Italy;
    case 357: 
      return  PW_CountryType.Cyprus;
    case 371: 
      return  PW_CountryType.Latvia;
    case 370: 
      return  PW_CountryType.Lithuania;
    case 352: 
      return  PW_CountryType.Luxembourg;
    case 36:  
      return  PW_CountryType.Hungary;
    case 356: 
      return  PW_CountryType.Malta;
    case 31:  
      return  PW_CountryType.Netherlands;
    case 43:  
      return  PW_CountryType.Austria;
    case 48:  
      return  PW_CountryType.Poland;
    case 351: 
      return  PW_CountryType.Portugal;
    case 40:  
      return  PW_CountryType.Romania;
    case 386: 
      return  PW_CountryType.Slovenia;
    case 358: 
      return  PW_CountryType.Finland;
    case 46:  
      return  PW_CountryType.Sweden;
    case 44:  
      return  PW_CountryType.UnitedKingdom;
    //case 354: 
      //return  PW_CountryType.Iceland;
    case 423: 
      return  PW_CountryType.Liechtenstein;
    case 47:  
      return  PW_CountryType.Norway;
    default:  
      return  PW_CountryType.Nothing;
    }
  }
}

public enum PW_PageState {
  Empty, 
    Splash, 
    Overview, 
    Analyze
}

public enum PW_VisArcMode {
  Top, 
    Bottom
}
