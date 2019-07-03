public interface PWDbRowListener {
  public void onDataRows(ArrayList<PWDbRow> rows);
}

public class PWDbRow {
  private int         year;
  private PW_CountryType country;
  private PW_WasteType   waste;
  private PW_WstOperType wstOper;
  private int         value;

  public PWDbRow(TableRow row) {
    year    = row.getInt("Year");
    country = PW_CountryType.fromId(row.getInt("Code"));
    waste   = PW_WasteType.fromId(row.getInt("Waste"));
    wstOper = PW_WstOperType.fromId(row.getInt("WstOper"));
    value   = row.getInt("Value");
  }

  public int year() {
    return year;
  }

  public PWDbRow year(int val) {
    this.year = val;
    return this;
  }

  public PW_CountryType country() {
    return country;
  }

  public PWDbRow country(PW_CountryType val) {
    this.country = val;
    return this;
  }

  public PW_WasteType waste() {
    return waste;
  }

  public PWDbRow waste(PW_WasteType val) {
    this.waste = val;
    return this;
  }

  public PWDbRow waste(int val) {
    this.waste = PW_WasteType.fromId(val);
    return this;
  }

  public PW_WstOperType wstOper() {
    return wstOper;
  }

  public PWDbRow wstOper(PW_WstOperType val) {
    this.wstOper = val;
    return this;
  }

  public PWDbRow wstOper(int val) {
    this.wstOper = PW_WstOperType.fromId(val);
    return this;
  }

  public int value() {
    return value;
  }

  public PWDbRow value(int val) {
    this.value = val;
    return this;
  }
}
