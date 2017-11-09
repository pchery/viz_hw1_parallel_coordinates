class Widget {
  float WIDGET_WIDTH = 25;
  float WIDGET_HEIGHT = 15;
  float MIN_AXIS_Y = 100;
  float MAX_AXIS_Y = 800;
  float MAX_DATA_VALUE;
  float MIN_DATA_VALUE;
  float x_pos;
  float y_pos;
  String type;
  float value;
  boolean clicked = false;
  Axis axis;
  
  Widget(String type, Axis axis, float value) {
    this.type = type;
    this.axis = axis;
    this.value = value;
    this.MAX_DATA_VALUE = axis.getMaxDataValue();
    this.MIN_DATA_VALUE = axis.getMinDataValue();
  }
  
  float getValue() {
    return this.value;
  }
  
  void display() {
    float center_y_pos = this.axis.getYCoordinate(value);
    x_pos = this.axis.getXPos()-(WIDGET_WIDTH/2);
    y_pos = center_y_pos - (WIDGET_HEIGHT/2);
    fill(255,99,71);
    rect(x_pos, y_pos, WIDGET_WIDTH, WIDGET_HEIGHT);
    textAlign(LEFT);
    fill(0,0,0);
    text(String.format("%.2f", this.value), this.axis.getXPos()+(WIDGET_WIDTH/2) + 5, center_y_pos);
  }
  
  Widget opposite() {
    if (this.type.equals("min")) {
     return this.axis.getWidgetMax(); 
    }
    else {
     return this.axis.getWidgetMin();
    }
  }
  
  Boolean clicked(float x, float y) {
    return ((x>=this.x_pos && x<=this.x_pos+WIDGET_WIDTH) && (y>=this.y_pos && y<=this.y_pos+WIDGET_HEIGHT));
  }
  
  Boolean getClicked() {
    return this.clicked; 
  }
  
  float getYPos() {
   return this.y_pos; 
  }
  
  void setClicked(Boolean bool) {
    this.clicked = bool;
  }
  
  void drag(float x, float y) {
    float new_value = axis.getValue(y);
    float widgit_margin = (MAX_DATA_VALUE-MIN_DATA_VALUE)/WIDGET_HEIGHT;
    if ((this.type.equals("min")) && new_value+(widgit_margin/2) < this.axis.getWidgetMax().getValue() ||
          (this.type.equals("max")) && (new_value-widgit_margin/2) > this.axis.getWidgetMin().getValue()) {
         if ((y>=MIN_AXIS_Y && y<=MAX_AXIS_Y)) {
           this.value = new_value; 
         }
         else if (y>MAX_AXIS_Y) {
           this.value = MIN_DATA_VALUE; 
         }
         else if (y<MIN_AXIS_Y) {
           this.value = MAX_DATA_VALUE; 
         }
    }
  }
  
}