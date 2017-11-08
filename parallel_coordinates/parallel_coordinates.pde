String FILE_NAME = "cars-cleaned.tsv";
float MIN_AXIS_X = 100;
float MAX_AXIS_X = 1300;
float MIN_AXIS_Y = 100;
float MAX_AXIS_Y = 800;
ArrayList<String> axis_variables = new ArrayList<String>();
Boolean viz_drawn = false;
Axis[] axes;
TableReader tr;
float scale; 

void setup() {
  size(1500, 1000, P2D);
  background(255,255,255);
  pixelDensity(displayDensity());
  loadData();
}

void draw() {
  
  if (!viz_drawn) {
    background(255,255,255);
    for(Axis a: axes){
     a.display(); 
    }
    
    ArrayList<TableRow> valid_rows = new ArrayList<TableRow>();
    for (int i=2; i<tr.getTable().getRowCount(); i++) {
       Boolean valid_row = true;
       for (int j=0; j<axes.length;j++) {
         String axis_label = axes[j].getLabel();
         float axis_widget_min_value = axes[j].getWidgetMin().getValue();
         float axis_widget_max_value = axes[j].getWidgetMax().getValue();
         float row_value = tr.getTable().getRow(i).getFloat(axis_label);
         valid_row = valid_row && (row_value>=axis_widget_min_value && row_value<=axis_widget_max_value);
       }
       if (valid_row) {
         valid_rows.add(tr.getTable().getRow(i));
       }
   }
    
    for (int i=2; i<valid_rows.size(); i++) {
       for (int j=0; j<axes.length-1;j++) {
         String from = axes[j].getLabel();
         String to = axes[j+1].getLabel();
         float from_min = tr.getMin(from);
         float from_max = tr.getMax(from);
         float to_min = tr.getMin(to);
         float to_max = tr.getMax(to);
         float from_y_coordinate = MIN_AXIS_Y + (((MAX_AXIS_Y-MIN_AXIS_Y)/(from_max-from_min))*(from_max-valid_rows.get(i).getFloat(from)));
         float to_y_coordinate = MIN_AXIS_Y + (((MAX_AXIS_Y-MIN_AXIS_Y)/(to_max-to_min))*(to_max-valid_rows.get(i).getFloat(to)));
         stroke(204, 102, 0);
         strokeWeight(1);
         line(axes[j].x_pos, from_y_coordinate, axes[j+1].x_pos, to_y_coordinate);
       }
   }
   
   
   for(int i = 1; i < axes.length; i++){
     if(axes[i - 1].x_pos > axes[i].x_pos){
       Axis temp = axes[i - 1];
       axes[i - 1] = axes[i];
       axes[i] = temp;
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
  
  //Create and load axes
  axes = new Axis[axis_variables.size()];
  scale = (MAX_AXIS_X-MIN_AXIS_X)/(axis_variables.size()-1);
  for (int i=0; i<axis_variables.size();i++) {
      String label = axis_variables.get(i);
      axes[i] = new Axis(label, MIN_AXIS_X + (scale*i), tr.getMin(label), tr.getMax(label));
  }
  
}
void mouseDragged(){
  for(Axis axis: axes){
    axis.getWidgetMin().drag(mouseX, mouseY);
    axis.getWidgetMax().drag(mouseX, mouseY);
    axis.drag(mouseX);
  }
  viz_drawn = false;
}

void mouseClicked(){
  for(Axis axis: axes){
    if(!axis.getWidgetMin().clicked(mouseX,mouseY) && !axis.getWidgetMax().clicked(mouseX,mouseY)) {
      axis.highlight(mouseX);

    }
  }
  viz_drawn = false;
}

void mouseReleased(){
  for(Axis axis: axes){
    axis.unhighlight();
  }
  viz_drawn = false;
}