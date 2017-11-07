class TableReader {
  
  Table table;
  
  TableReader(String link) {
    this.table = loadTable(link, "header,tsv");
  }
  
  String getVariableType(String variable_name) {
    return this.table.getRow(0).getString(variable_name);
  }
  
  String[] getVariableNames() {
    int variable_count = table.getRow(-1).getColumnCount();
    String[] variable_names = new String[variable_count];
    for (int i=0; i<variable_count;i++) {
      variable_names[i] = this.table.getRow(-1).getColumnTitle(i);
    }
    return variable_names;
  }
  
  int getVariableCount() {
    return table.getRow(-1).getColumnCount();
  }
  
  Table getTable() {
     return this.table; 
  }
  
  float getMin(String variable_name) {
    float min = this.table.getRow(1).getFloat(variable_name);
    for (int i=2; i<this.table.getRowCount(); i++) {
       if (this.table.getRow(i).getFloat(variable_name) < min) {
         min = this.table.getRow(i).getFloat(variable_name);
       }
    }
    return min;
  }
  
  float getMax(String variable_name) {
    float max = this.table.getRow(1).getFloat(variable_name);
    for (int i=2; i<this.table.getRowCount(); i++) {
       if (this.table.getRow(i).getFloat(variable_name) > max) {
         max = this.table.getRow(i).getFloat(variable_name);
       }
    }
    return max;
  }
  
}