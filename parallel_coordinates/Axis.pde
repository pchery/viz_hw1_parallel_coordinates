import java.util.Map;

class Axis{
  boolean highlighted = false;
  float x_pos;
  String label;
  float min_data_value;
  float max_data_value;
  float MIN_AXIS_Y = 100;
  float MAX_AXIS_Y = 800;
  Widget min;
  Widget max;

  Map map = new HashMap<String, Float>();
  
  Axis(String label, float x_pos, float min_data_value, float max_data_value){
    this.label = label;
    this.x_pos = x_pos;
    this.min_data_value = min_data_value;
    this.max_data_value = max_data_value;
    this.min = new Widget("min", this, min_data_value);
    this.max = new Widget("max", this, max_data_value);
  };
  
  Axis(String label, float x_pos, HashMap map){
    this.label = label;
    this.x_pos = x_pos;
    this.map = map;
  }
  
  void display(){
    
    if(highlighted){
      strokeWeight(7);
      stroke(255,0,0);
    }else{
      strokeWeight(3);
      stroke(0);
    }
    line(x_pos, MIN_AXIS_Y, x_pos, MAX_AXIS_Y);
    fill(0, 102, 153);
    textAlign(CENTER);
    text(label, x_pos, MIN_AXIS_Y-20);
    this.min.display();
    this.max.display();
  }
  
  Map getMap(){
    return map;
  }
  
  Widget getWidgetMin() {
    return this.min;
  }
  
  Widget getWidgetMax() {
    return this.max;
  }
  
  String getLabel(){
   return label; 
  }
  
  float getMaxDataValue() {
    return this.max_data_value;
  }
  
  float getMinDataValue() {
    return this.min_data_value;
  }
  
  float getXPos(){
    return this.x_pos;
  }
  
  float getYCoordinate(float value) {
    return MIN_AXIS_Y + (((MAX_AXIS_Y-MIN_AXIS_Y)/(max_data_value-min_data_value))*(max_data_value-value));
  }
  
  float getValue(float y) {
    return max_data_value - ((y-MIN_AXIS_Y)/(((MAX_AXIS_Y-MIN_AXIS_Y)/(max_data_value-min_data_value))));
  }
  
  Boolean getHighlighted() {
    return this.highlighted;
  }
  
  void highlight(float x){
    if(x > x_pos - 5 && x < x_pos + 5 && !highlighted){
      highlighted = true; 
    }
  }
  
  void unhighlight(){
    if(highlighted){
      highlighted = false;
    }
    
  }
  //void move(float x){
    
  //}
  void drag(float x){
    if(highlighted){
      this.x_pos = x;
    }
  }
}