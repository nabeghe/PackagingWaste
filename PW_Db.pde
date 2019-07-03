public class PW_Db extends FK_Db {

  public PW_Db(String path) {
    super(path);
  }

  public ArrayList<PWDbRow> getRowsInYear(int year) {
    return getRowsInYear(year, null);
  }

  public ArrayList<PWDbRow> getRowsInYear(int year, PWDbRowListener listener) {
    ArrayList<PWDbRow> result = new ArrayList<PWDbRow>();
    for (TableRow row : table.rows()) {
      if (row.getInt("Year") == year) {
        result.add(new PWDbRow(row));
      }
    }
    if (listener != null) listener.onDataRows(result);
    return result;
  }

  public ArrayList<PWDbRow> getRowsInYear(int year, int countryCode, PWDbRowListener listener) {
    ArrayList<PWDbRow> result = new ArrayList<PWDbRow>();
    for (TableRow row : table.rows()) {
      if (row.getInt("Year") == year && row.getInt("Code") == countryCode) {
        result.add(new PWDbRow(row));
      }
    }
    if (listener != null) listener.onDataRows(result);
    return result;
  }

  public ArrayList<PWDbRow> getRowsInYear(int year, PW_CountryType country, PWDbRowListener listener) {
    return getRowsInYear(year, country.id(), listener);
  }

  public void getRowsInYearAsync(int year) {
    thread("getRowsInYear");
  }

  // ----------------------

  public PW_WestOper getWestOperInYear(int year, PW_CountryType country) {
    PW_WestOper output = new PW_WestOper();
    ArrayList<PWDbRow> rows = db.getRowsInYear(year, country, null);
    for (PWDbRow row : rows) {
      switch (row.wstOper()) {
      case WasteGenerated:
        output.plusGenerated(row.value());
        break;
      case Recovery:
        output.plusRecovery(row.value());
        break;
      case Recycling:
        output.plusRecycling(row.value());
        break;
      }
    }
    return output;
  }

  public PW_Waste getWasteInYear(int year, PW_CountryType country) {
    PW_Waste output = new PW_Waste();
    ArrayList<PWDbRow> rows = db.getRowsInYear(year, country, null);
    for (PWDbRow row : rows) {
      switch (row.waste()) {
      case PaperAndCardboard:
        output.plusPaperAndCardboard(row.value());
        break;
      case Plastic:
        output.plusPlastic(row.value());
        break;
      case Wooden:
        output.plusWooden(row.value());
        break;
      case Metallic:
        output.plusMetallic(row.value());
        break;
      case Aluminium:
        output.plusAluminium(row.value());
        break;
      case Steel:
        output.plusSteel(row.value());
        break;
      case Glass:
        output.plusGlass(row.value());
        break;
      }
    }
    return output;
  }
}

/* ============================================================================================================================ */
/* Data Types */

public class PW_Waste {

  private int paperAndCardboard;
  public int paperAndCardboard() {
    return paperAndCardboard;
  }
  public PW_Waste plusPaperAndCardboard(int value) {
    if (value > 0) paperAndCardboard += value;
    return this;
  }

  private int plastic;
  public int plastic() {
    return plastic;
  }
  public PW_Waste plusPlastic(int value) {
    if (value > 0) plastic += value;
    return this;
  }

  private int wooden;
  public int wooden() {
    return wooden;
  }
  public PW_Waste plusWooden(int value) {
    if (value > 0) wooden += value;
    return this;
  }

  private int metallic;
  public int metallic() {
    return metallic;
  }
  public PW_Waste plusMetallic(int value) {
    if (value > 0) metallic += value;
    return this;
  }

  private int aluminium;
  public int aluminium() {
    return aluminium;
  }
  public PW_Waste plusAluminium(int value) {
    if (value > 0) aluminium += value;
    return this;
  }

  private int steel;
  public int steel() {
    return steel;
  }
  public PW_Waste plusSteel(int value) {
    if (value > 0) steel += value;
    return this;
  }

  private int glass;
  public int glass() {
    return glass;
  }
  public PW_Waste plusGlass(int value) {
    if (value > 0) glass += value;
    return this;
  }

  private int other;
  public int other() {
    return other;
  }
  public PW_Waste plusOther(int value) {
    if (value > 0) other += value;
    return this;
  }

  public int total() {
    return paperAndCardboard + plastic + wooden + metallic + aluminium + steel + glass + other;
  }
}

public class PW_WestOper {

  private int generated;
  public int generated() {
    return generated;
  }
  public PW_WestOper plusGenerated(int value) {
    if (value > 0) generated += value;
    return this;
  }

  private int recovery;
  public int recovery() {
    return recovery;
  }
  public PW_WestOper plusRecovery(int value) {
    if (value > 0) recovery += value;
    return this;
  }

  private int recycling;
  public int recycling() {
    return recycling;
  }
  public PW_WestOper plusRecycling(int value) {
    if (value > 0) recycling += value;
    return this;
  }

  public PW_WestOper(int generated, int recovery, int recycling) {
    this.generated = generated;
    this.recovery  = recovery;
    this.recycling = recycling;
  }

  public PW_WestOper() {
  }
}
