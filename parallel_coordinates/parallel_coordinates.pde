String FILE_NAME = "cars-cleaned.tsv";
float MIN_AXIS_X = 100;
float MAX_AXIS_X = 1300;
float MIN_AXIS_Y = 100;
float MAX_AXIS_Y = 800;
ArrayList<String> axis_variables = new ArrayList<String>();
Boolean viz_drawn = false;
TableReader tr;

void setup() {
  size(1500, 1000);
  background(255,255,255);
  pixelDensity(displayDensity());
  loadData();
}

void draw() {
  float scale = (MAX_AXIS_X-MIN_AXIS_X)/(axis_variables.size()-1);
  if (!viz_drawn) {
    strokeWeight(3);
    for (int i=0; i<axis_variables.size();i++) {
      line(MIN_AXIS_X+(scale*i), MIN_AXIS_Y, MIN_AXIS_X+(scale*i), MAX_AXIS_Y);
      textAlign(CENTER);
      fill(0, 102, 153);
      text(axis_variables.get(i), MIN_AXIS_X+(scale*i), MIN_AXIS_Y-6);
    }
    for (int i=2; i<tr.getTable().getRowCount(); i++) {
       for (int j=0; j<axis_variables.size()-1;j++) {
         String from = axis_variables.get(j);
         String to = axis_variables.get(j+1);
         float from_min = tr.getMin(from);
         float from_max = tr.getMax(from);
         float to_min = tr.getMin(to);
         float to_max = tr.getMax(to);
         float from_y_coordinate = MIN_AXIS_Y + (((MAX_AXIS_Y-MIN_AXIS_Y)/(from_max-from_min))*(from_max-tr.getTable().getRow(i).getFloat(from)));
         float to_y_coordinate = MIN_AXIS_Y + (((MAX_AXIS_Y-MIN_AXIS_Y)/(to_max-to_min))*(to_max-tr.getTable().getRow(i).getFloat(to)));
         stroke(204, 102, 0);
         strokeWeight(0.2);
         line(MIN_AXIS_X+(scale*j), from_y_coordinate, MIN_AXIS_X+(scale*(j+1)), to_y_coordinate);
       }
   }
    viz_drawn = true;
  }
  
}

void loadData() {
  tr = new TableReader(FILE_NAME);
  String[] variable_names = tr.getVariableNames();
  for (int i=0; i<variable_names.length; i++) {
    String variable_type = tr.getVariableType(variable_names[i]);
    if (variable_type.equals("int") || variable_type.equals("float")) {
      axis_variables.add(variable_names[i]);
    }
  }
}