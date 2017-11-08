import java.util.Map;

class Axis{
  boolean highlighted = false;
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
    text(label, x_pos, MIN_AXIS_Y-6);
  }
  
  Map getMap(){
    return map;
  }
  
  String getLabel(){
   return label; 
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