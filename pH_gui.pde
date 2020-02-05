import processing.serial.*;
Serial myPort;

import controlP5.*;
ControlP5 cp5;
Textfield phTextfield;
Chart pHChart;
float phSlider = 5;
float pH = 5;

void setup() {
  size(640, 480);
  
  printArray(Serial.list());
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  
  myPort.bufferUntil('\n');
  
  cp5 = new ControlP5(this);
    
  pHChart = cp5.addChart("PH chart")
               .setPosition(50, 50)
               .setSize(200, 100)
               .setRange(-0.05, 14.05)
               .setView(Chart.LINE)
               .lock();
               
  pHChart.addDataSet("ph");
  pHChart.setData("ph", new float[100]);
  
  cp5.addSlider("phSlider")
     .setPosition(50, 300)
     .setSize(200, 100)
     .setRange(-0.05, 14.05)
     .lock();
     
  phTextfield = cp5.addTextfield("Change pH value")
                   .setPosition(50, 300)
                   .setSize(100, 50)
                   .bringToFront();
      
  cp5.addButton("Change")
     .setValue(0)
     .setPosition(200, 300)
     .setSize(100, 50);
}

public void Change(int value) {
  float data = float(trim(phTextfield.getText()));
  if(data >= 0 && data <= 14 ){
    if(data >= 10) { 
      myPort.write("W" + nf(data, 0, 1));
    } else {
      myPort.write("W" + nf(data, 0, 2));
    }
    println(phTextfield.getText());
  }
}

void draw() {
  background(0);
  myPort.write("R"); 
  pHChart.push("ph", phSlider);
  //println(phSlider);
}

void serialEvent(Serial myPort) {
  String myString = myPort.readStringUntil('\n');
  myString = trim(myString);
  phSlider = float(myString);
  pHChart.push("ph", phSlider);
  cp5.getController("phSlider").setValue(phSlider);
}
