import java.util.Map;

class Axis{
  float x_pos;
  String label;
  float MIN_AXIS_Y = 100;
  float MAX_AXIS_Y = 800;
  Map map = new HashMap<String, Float>();
   Axis(String label, float x_pos){
    this.label = label;
    this.x_pos = x_pos;
  };
  Axis(String label, float x_pos, HashMap map){
    this.label = label;
    this.x_pos = x_pos;
    this.map = map;
  }
  
  void display(){
    stroke(0);
    strokeWeight(3);
    line(x_pos, MIN_AXIS_Y, x_pos, MAX_AXIS_Y);
    fill(0, 102, 153);
    textAlign(CENTER);
    text(label, x_pos, MIN_AXIS_Y-6);
  }
  
  Map getMap(){
    return map;
  }
  
  String getLabel(){
   return label; 
  }
  
  
  
}