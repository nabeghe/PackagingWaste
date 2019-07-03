public class FK_Db {

  protected Table table;

  public Table getTable() {
    return table;
  }

  // ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ----------

  public FK_Db(String path) {
    table = loadTable(path, "header");
  }

  // ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ---------- * ----------

  public TableRow getRow(int rowIndex) {
    TableRow row = table.getRow(rowIndex);
    return row;
  }

  public TableRow getRow(int columnIndex, String value) {
    TableRow result = table.findRow(value, columnIndex);
    return result;
  }

  public TableRow getRow(String columnName, String value) {
    TableRow result = table.findRow(value, columnName);
    return result;
  }

  public ArrayList<String> rowsToStringArray(String columnName) {
    ArrayList<String> result = new ArrayList();
    for (TableRow row : table.rows()) {
      String value = row.getString(columnName);
      result.add(value);
    }
    return result;
  }

  // return a hashmap that key was country code & value was index of row in table
  public HashMap<String, Integer> rowsToIndexedHashMap(String columnName) {
    HashMap<String, Integer> result = new HashMap();
    int rowIndex                    = 0;
    for (TableRow row : table.rows()) {
      String columnValue = row.getString(columnName);
      result.put(columnValue, rowIndex);
      rowIndex = rowIndex + 1;
    }
    return result;
  }

  public java.util.ArrayList<TableRow> getSortedRows(String column) {
    ArrayList<TableRow> result = new ArrayList<TableRow>();
    Iterable<TableRow>  rows   = getTable().rows();
    for (TableRow row : rows) {
      result.add(row);
    }
    return result;
  }
}
