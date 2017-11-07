class Axis{
  float x_pos;
  String label;
  float MIN_AXIS_Y = 100;
  float MAX_AXIS_Y = 800;
  Axis(String label, float x_pos){
    this.label = label;
    this.x_pos = x_pos;
    
  }
  
  void display(){
    stroke(0);
    strokeWeight(3);
    line(x_pos, MIN_AXIS_Y, x_pos, MAX_AXIS_Y);
    fill(0, 102, 153);
    textAlign(CENTER);
    text(label, x_pos, MIN_AXIS_Y-6);
  }
  
  
  
  
  
}