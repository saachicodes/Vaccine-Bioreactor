import controlP5.*; 
import processing.serial.*;
Serial myport;
ControlP5 cp5; 
Textarea myTextarea;
PFont font;

Textfield rpmtext;

void setup() {
    size(300, 200);
    cp5 = new ControlP5(this);
    font = createFont("arial", 20);
    
    myTextarea = cp5.addTextarea("txt")
                  .setPosition(20,50)
                  .setSize(200,200)
                  .setFont(createFont("arial",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100));
                  ;
                  
    myTextarea.setText("Enter rpm: "); 
         
    cp5.addButton("send");
    
    rpmtext = cp5.addTextfield("rpm")
     .setPosition(20,100)
     .setSize(100,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
     
     rpmtext.setInputFilter(ControlP5.INTEGER); 
}

void controlEvent(ControlEvent theEvent) {
     if(theEvent.isController()) { 
         if(theEvent.getController().getName()=="send") {
            String portname = Serial.list()[9];
            myport = new Serial(this, portname, 9600);
            textFont(font);
            String rpmstring = rpmtext.getText();
     
            while (rpmstring.equals("")) {}
     
            int rpm = Integer.parseInt(rpmstring);      
            
            while (rpm < 500 || rpm > 1500) {}
            myport.write(rpm);
        }
    }

}
     
void draw() {
  background(255,255,255);
}
      
