String FILE_NAME = "cars-cleaned.tsv";
float MIN_AXIS_X = 100;
float MAX_AXIS_X;
float MIN_AXIS_Y = 100;
float MAX_AXIS_Y;
ArrayList<String> axis_variables = new ArrayList<String>();
Boolean viz_drawn = false;
Axis[] axes;
TableReader tr;
float scale;

void setup() {
  //size(1200, 1000, P2D);
  fullScreen(P2D);
  MAX_AXIS_X = width - 100;
  MAX_AXIS_Y = height - 100;
  background(255,255,255);
  pixelDensity(displayDensity());
  loadData();
}

void draw() {
  
  if (!viz_drawn) {
    background(255,255,255);
    
    ArrayList<TableRow> valid_rows = new ArrayList<TableRow>();
    ArrayList<TableRow> invalid_rows = new ArrayList<TableRow>();
    
    for (int i=2; i<tr.getTable().getRowCount(); i++) {
       Boolean valid_row = true;
       for (int j=0; j<axes.length;j++) {
         float axis_widget_min_value = axes[j].getWidgetMin().getValue();
         float axis_widget_max_value = axes[j].getWidgetMax().getValue();
         float row_value = tr.getTable().getRow(i).getFloat(axes[j].getLabel());
         valid_row = valid_row && (row_value>=axis_widget_min_value && row_value<=axis_widget_max_value);
       }
       if (valid_row) {
         valid_rows.add(tr.getTable().getRow(i));
       }
       else {
         invalid_rows.add(tr.getTable().getRow(i));
       }
    }
    
    for (int i=2; i<invalid_rows.size(); i++) {
       for (int j=0; j<axes.length-1;j++) {
         Axis from_axis = axes[j];
         Axis to_axis = axes[j+1];
         float from_y_coordinate = from_axis.getYCoordinate(invalid_rows.get(i).getFloat(from_axis.getLabel()));
         float to_y_coordinate = to_axis.getYCoordinate(invalid_rows.get(i).getFloat(to_axis.getLabel()));
         stroke(211,211,211);
         strokeWeight(1);
         line(axes[j].x_pos, from_y_coordinate, axes[j+1].x_pos, to_y_coordinate);
       }
    }
    
    for (int i=2; i<valid_rows.size(); i++) {
       for (int j=0; j<axes.length-1;j++) {
         Axis from_axis = axes[j];
         Axis to_axis = axes[j+1];
         float from_y_coordinate = from_axis.getYCoordinate(valid_rows.get(i).getFloat(from_axis.getLabel()));
         float to_y_coordinate = to_axis.getYCoordinate(valid_rows.get(i).getFloat(to_axis.getLabel()));
         stroke(112,128,144);
         strokeWeight(1);
         line(axes[j].x_pos, from_y_coordinate, axes[j+1].x_pos, to_y_coordinate);
       }
   }
   
   //handle edge cases
   for(int i = 1; i < axes.length - 1; i++){
     
     if(axes[axes.length - 2].x_pos > axes[axes.length -1].x_pos){
       Axis temp = axes[axes.length - 2];
       axes[axes.length - 2] = axes[axes.length - 1];
       axes[axes.length - 1] = temp;
     }
     
     if(axes[i - 1].x_pos > axes[i].x_pos){
       Axis temp = axes[i - 1];
       axes[i - 1] = axes[i];
       axes[i] = temp;
     }
     if(axes[i].highlighted &&(axes[i].x_pos > axes[i-1].x_pos) && (axes[i].x_pos < axes[i-1].x_pos + 20)){
       axes[i - 1].x_pos -= 20;
    
     }
     if(axes[i].x_pos > axes[i + 1].x_pos - 20 && axes[i].x_pos < axes[i+1].x_pos && axes[i].highlighted){
       axes[i + 1].x_pos += 20;
     }
     if(axes[axes.length - 1].highlighted && (axes[axes.length - 1].x_pos > axes[axes.length-2].x_pos) && (axes[axes.length - 1].x_pos < axes[axes.length-2].x_pos + 20)){
       axes[axes.length - 2].x_pos -= 20;
    
     }
      if(axes[0].x_pos > axes[1].x_pos - 20 && axes[0].x_pos < axes[1].x_pos && axes[0].highlighted){
       axes[1].x_pos += 20;
     }
     
   }
   
   for(Axis a: axes){
     a.display(); 
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
    if (axis.getHighlighted()) {
      axis.drag(mouseX);
    }
    else if (axis.getWidgetMin().clicked(mouseX,mouseY) || axis.getWidgetMin().getClicked()) {
      axis.getWidgetMin().setClicked(true);
      axis.getWidgetMin().drag(mouseX, mouseY);
    }
    else if (axis.getWidgetMax().clicked(mouseX,mouseY) || axis.getWidgetMax().getClicked()) {
      axis.getWidgetMax().setClicked(true);
      axis.getWidgetMax().drag(mouseX, mouseY);
    }    
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
    axis.getWidgetMin().setClicked(false);
    axis.getWidgetMax().setClicked(false);
  }
  viz_drawn = false;
}