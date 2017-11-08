class Widget {
  float WIDGET_WIDTH = 10;
  float WIDGET_HEIGHT = 20;
  float MIN_AXIS_Y = 100;
  float MAX_AXIS_Y = 800;
  float x_pos;
  float y_pos;
  String type;
  float value;
  Axis axis;
  
  Widget(String type, Axis axis, float value) {
    this.type = type;
    this.axis = axis;
    this.value = value;
  }
  
  float getValue() {
    return this.value;
  }
  
  void display() {
    float center_y_pos = this.axis.getYCoordinate(value);
    x_pos = this.axis.getXPos()-(WIDGET_WIDTH/2);
    y_pos = center_y_pos - (WIDGET_HEIGHT/2);
    rect(x_pos, y_pos, WIDGET_WIDTH, WIDGET_HEIGHT);
    textAlign(LEFT);
    text(this.value, this.axis.getXPos()+(WIDGET_WIDTH/2) + 5, center_y_pos);
  }
  
  Boolean clicked(float x, float y) {
    return ((x>=this.x_pos && x<=this.x_pos+WIDGET_WIDTH) && (y>=this.y_pos && y<=this.y_pos+WIDGET_HEIGHT));
  }
  
  void drag(float x, float y) {
    if (this.clicked(x,y)) {
       if (y>=MIN_AXIS_Y && y<=MAX_AXIS_Y) {
         this.value = axis.getValue(y);
       }
    }
  }
  
}