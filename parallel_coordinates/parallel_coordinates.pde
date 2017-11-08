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
  background(255);
  
  if (!viz_drawn) {
    
    for(Axis a: axes){
     a.display(); 
    }
    
    for (int i=2; i<tr.getTable().getRowCount(); i++) {
       for (int j=0; j<axes.length-1;j++) {
         String from = axes[j].getLabel();
         String to = axes[j+1].getLabel();
         float from_min = tr.getMin(from);
         float from_max = tr.getMax(from);
         float to_min = tr.getMin(to);
         float to_max = tr.getMax(to);
         float from_y_coordinate = MIN_AXIS_Y + (((MAX_AXIS_Y-MIN_AXIS_Y)/(from_max-from_min))*(from_max-tr.getTable().getRow(i).getFloat(from)));
         float to_y_coordinate = MIN_AXIS_Y + (((MAX_AXIS_Y-MIN_AXIS_Y)/(to_max-to_min))*(to_max-tr.getTable().getRow(i).getFloat(to)));
         stroke(204, 102, 0);
         strokeWeight(0.2);
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
    //viz_drawn = true;
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
      axes[i] = new Axis(axis_variables.get(i), MIN_AXIS_X + (scale*i));
  }
  
}
void mouseDragged(){
  for(Axis axis: axes){
    axis.drag(mouseX);
  }
}

void mouseClicked(){
  for(Axis axis: axes){
    axis.highlight(mouseX);
  }
}

void mouseReleased(){
  for(Axis axis: axes){
    axis.unhighlight();
  }
}

//void mouseMoved(){
//  //viz_drawn = false;
//  for(Axis axis: axes){
//    axis.move(mouseX);
//  }
//}